part of 'main.dart';

// ═══════════════════════════════════════════════════════
// FLOOR SCREEN — Table layout with drag support
// ═══════════════════════════════════════════════════════
class FloorScreen extends ConsumerStatefulWidget {
  const FloorScreen({super.key});
  @override ConsumerState<FloorScreen> createState() => _FloorScreenState();
}

class _FloorScreenState extends ConsumerState<FloorScreen> {
  int _selectedFloorId = -1;
  bool _editMode = false;
  final _transform = TransformationController();

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      final floors = await ref.read(dbProvider).tableDao.allFloors();
      if (floors.isNotEmpty && mounted) {
        setState(() => _selectedFloorId = floors.first.id);
      }
    });
  }

  @override
  void dispose() { _transform.dispose(); super.dispose(); }

  @override
  Widget build(BuildContext context) {
    final floorsAsync = ref.watch(floorsProvider);
    final isDark = context.isDark;

    return SideNav(child: Scaffold(
      appBar: AppBar(
        title: const Text('Floor Plan'),
        leading: IconButton(icon: const Icon(Icons.arrow_back), onPressed: () => context.go('/dashboard')),
        actions: [
          // Floor selector
          floorsAsync.when(
            data: (floors) => Row(children: floors.map((f) {
              final sel = f.id == _selectedFloorId;
              return Padding(
                padding: const EdgeInsets.only(right: 6),
                child: GestureDetector(
                  onTap: () => setState(() => _selectedFloorId = f.id),
                  child: AnimatedContainer(
                    duration: const Duration(milliseconds: 200),
                    padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 7),
                    decoration: BoxDecoration(
                      color: sel ? context.cs.primary : context.elevated,
                      borderRadius: BorderRadius.circular(8),
                      border: Border.all(color: sel ? context.cs.primary : context.border),
                    ),
                    child: Text(f.name, style: TextStyle(
                      color: sel ? Colors.white : context.cs.onSurface,
                      fontWeight: sel ? FontWeight.w600 : FontWeight.w400,
                      fontSize: 13,
                    )),
                  ),
                ),
              );
            }).toList()),
            loading: () => const SizedBox(),
            error: (_, __) => const SizedBox(),
          ),
          const SizedBox(width: 8),
          // Add floor
          IconButton(icon: const Icon(Icons.add_box_outlined), tooltip: 'Add floor', onPressed: _addFloor),
          const SizedBox(width: 4),
          // Edit toggle
          Padding(
            padding: const EdgeInsets.only(right: 8),
            child: FilledButton.tonal(
              onPressed: () => setState(() => _editMode = !_editMode),
              style: FilledButton.styleFrom(
                backgroundColor: _editMode ? context.cs.primary.withAlpha(30) : null,
              ),
              child: Row(children: [
                Icon(_editMode ? Icons.edit_off_rounded : Icons.edit_rounded, size: 16,
                    color: _editMode ? context.cs.primary : null),
                const SizedBox(width: 6),
                Text(_editMode ? 'Done editing' : 'Edit layout',
                    style: _editMode ? TextStyle(color: context.cs.primary) : null),
              ]),
            ),
          ),
          if (_editMode) ...[
            OutlinedButton.icon(
              icon: const Icon(Icons.add_circle_outline, size: 16),
              label: const Text('Add Table'),
              onPressed: _addTable,
            ),
            const SizedBox(width: 8),
          ],
          // Zoom reset
          IconButton(icon: const Icon(Icons.fit_screen_rounded), tooltip: 'Reset zoom',
            onPressed: () => _transform.value = Matrix4.identity()),
          const SizedBox(width: 8),
        ],
      ),
      body: _selectedFloorId == -1
          ? const Center(child: CircularProgressIndicator())
          : Consumer(builder: (_, ref, __) {
              final tablesAsync = ref.watch(floorTablesProvider(_selectedFloorId));
              return tablesAsync.when(
                loading: () => const Center(child: CircularProgressIndicator()),
                error: (e, _) => Center(child: Text('Error: $e')),
                data: (tables) => Column(children: [
                  // Status bar
                  Container(
                    height: 36,
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    color: isDark ? AppColors.darkCard : Colors.white,
                    child: Row(children: [
                      Text('${tables.length} tables', style: const TextStyle(fontSize: 12)),
                      const SizedBox(width: 16),
                      _FloorLegend(AppColors.tableAvailable, 'Available'),
                      const SizedBox(width: 12),
                      _FloorLegend(AppColors.tableOccupied, 'Occupied'),
                      const SizedBox(width: 12),
                      _FloorLegend(AppColors.tableReserved, 'Reserved'),
                      const Spacer(),
                      if (_editMode) Text('Drag tables to reposition', style: TextStyle(fontSize: 11, color: context.cs.onSurfaceVariant)),
                      if (!_editMode) Text('Tap a table to open order terminal', style: TextStyle(fontSize: 11, color: context.cs.onSurfaceVariant)),
                    ]),
                  ),
                  // Canvas
                  Expanded(
                    child: Container(
                      color: isDark ? const Color(0xFF0A1628) : const Color(0xFFF0F4F8),
                      child: InteractiveViewer(
                        transformationController: _transform,
                        minScale: 0.3, maxScale: 3.0,
                        constrained: false,
                        child: SizedBox(
                          width: 2000, height: 1400,
                          child: CustomPaint(
                            painter: _GridPainter(isDark ? const Color(0xFF1A2332) : const Color(0xFFDDE3EA)),
                            child: Stack(children: tables.map((t) => _TableWidget(
                              table: t,
                              editMode: _editMode,
                              onTap: () => _onTableTap(t),
                              onDragged: (pos) => ref.read(dbProvider).tableDao.updatePosition(t.id, pos.dx, pos.dy),
                            )).toList()),
                          ),
                        ),
                      ),
                    ),
                  ),
                ]),
              );
            }),
    ));
  }

  void _onTableTap(TableEntity table) {
    if (_editMode) return;
    if (table.isAvailable) {
      _showGuestDialog(table);
    } else {
      context.go('/pos/${table.id}');
    }
  }

  void _showGuestDialog(TableEntity table) {
    int guests = 2;
    final waiterCtrl = TextEditingController();
    final staffList = ref.read(staffProvider).valueOrNull ?? [];
    // Pre-fill with logged-in user's name
    waiterCtrl.text = ref.read(authProvider).user?.name ?? '';

    showDialog(context: context, builder: (_) => StatefulBuilder(builder: (ctx, ss) => AlertDialog(
      title: Row(children: [
        const Icon(Icons.table_restaurant_rounded, size: 22),
        const SizedBox(width: 10),
        Text('Open ${table.name}'),
      ]),
      content: SizedBox(width: 380, child: Column(mainAxisSize: MainAxisSize.min, crossAxisAlignment: CrossAxisAlignment.start, children: [
        // Waiter name
        const Text('Waiter / Server name:', style: TextStyle(fontSize: 13, fontWeight: FontWeight.w600)),
        const SizedBox(height: 8),
        Row(children: [
          Expanded(
            child: TextField(
              controller: waiterCtrl,
              textCapitalization: TextCapitalization.words,
              decoration: InputDecoration(
                hintText: 'e.g. Ahmed',
                prefixIcon: const Icon(Icons.badge_outlined, size: 18),
                isDense: true,
                suffixText: waiterCtrl.text.isEmpty ? '← defaults to your name' : null,
              ),
              onChanged: (_) => ss(() {}),
            ),
          ),
          if (staffList.isNotEmpty) ...[
            const SizedBox(width: 8),
            PopupMenuButton<String>(
              tooltip: 'Pick from staff',
              icon: const Icon(Icons.people_alt_outlined),
              onSelected: (name) => ss(() => waiterCtrl.text = name),
              itemBuilder: (_) => staffList.map((u) => PopupMenuItem(
                value: u.name,
                child: Row(children: [
                  CircleAvatar(radius: 14, child: Text(u.name[0].toUpperCase(), style: const TextStyle(fontSize: 12))),
                  const SizedBox(width: 8),
                  Text(u.name),
                ]),
              )).toList(),
            ),
          ],
        ]),
        const SizedBox(height: 20),
        // Guest count
        const Text('Number of guests:', style: TextStyle(fontSize: 13, fontWeight: FontWeight.w600)),
        const SizedBox(height: 12),
        Row(mainAxisAlignment: MainAxisAlignment.center, children: [
          _RoundBtn(icon: Icons.remove, onTap: guests > 1 ? () => ss(() => guests--) : null),
          SizedBox(width: 70, child: Center(child: Text('$guests',
            style: const TextStyle(fontSize: 32, fontWeight: FontWeight.w800)))),
          _RoundBtn(icon: Icons.add, onTap: () => ss(() => guests++)),
        ]),
      ])),
      actions: [
        TextButton(onPressed: () => Navigator.pop(ctx), child: const Text('Cancel')),
        FilledButton(
          onPressed: () async {
            Navigator.pop(ctx);
            final waiterName = waiterCtrl.text.trim();
            await ref.read(posProvider(table.id).notifier).openTableWithWaiter(
              guests, waiterName: waiterName,
            );
            if (mounted) context.go('/pos/${table.id}');
          },
          child: const Text('Open Table'),
        ),
      ],
    )));
  }

  Future<void> _addFloor() async {
    final ctrl = TextEditingController();
    final name = await showDialog<String>(context: context, builder: (_) => AlertDialog(
      title: const Text('Add floor'),
      content: TextField(controller: ctrl, autofocus: true, decoration: const InputDecoration(labelText: 'Floor name')),
      actions: [
        TextButton(onPressed: () => Navigator.pop(context), child: const Text('Cancel')),
        FilledButton(onPressed: () => Navigator.pop(context, ctrl.text), child: const Text('Add')),
      ],
    ));
    if (name != null && name.isNotEmpty) {
      await ref.read(dbProvider).into(ref.read(dbProvider).floors).insert(
        FloorsCompanion.insert(name: name));
      ref.invalidate(floorsProvider);
    }
  }

  Future<void> _addTable() async {
    if (_selectedFloorId == -1) return;
    final db = ref.read(dbProvider);
    final existing = await db.tableDao.watchByFloor(_selectedFloorId).first;
    final num = existing.length + 1;
    await db.into(db.restaurantTables).insert(RestaurantTablesCompanion.insert(
      floorId: _selectedFloorId,
      name: 'T$num',
      posX: const Value(100),
      posY: const Value(100),
    ));
  }
}

class _FloorLegend extends StatelessWidget {
  const _FloorLegend(this.color, this.label);
  final Color color; final String label;
  @override
  Widget build(BuildContext context) => Row(mainAxisSize: MainAxisSize.min, children: [
    Container(width: 10, height: 10, margin: const EdgeInsets.only(right: 4),
      decoration: BoxDecoration(color: color, borderRadius: BorderRadius.circular(3))),
    Text(label, style: const TextStyle(fontSize: 11)),
  ]);
}

class _GridPainter extends CustomPainter {
  const _GridPainter(this.color);
  final Color color;
  @override
  void paint(Canvas canvas, Size size) {
    final p = Paint()..color = color..strokeWidth = 0.5;
    for (double x = 0; x < size.width; x += 40) canvas.drawLine(Offset(x, 0), Offset(x, size.height), p);
    for (double y = 0; y < size.height; y += 40) canvas.drawLine(Offset(0, y), Offset(size.width, y), p);
  }
  @override bool shouldRepaint(_GridPainter o) => o.color != color;
}


class _TableWidget extends ConsumerStatefulWidget {
  const _TableWidget({required this.table, required this.editMode, required this.onTap, required this.onDragged});
  final TableEntity table;
  final bool editMode;
  final VoidCallback onTap;
  final ValueChanged<Offset> onDragged;
  @override ConsumerState<_TableWidget> createState() => _TableWidgetState();
}

class _TableWidgetState extends ConsumerState<_TableWidget> with SingleTickerProviderStateMixin {
  late Offset _pos;
  late final AnimationController _pulse;
  @override
  void initState() {
    super.initState();
    _pos = Offset(widget.table.posX, widget.table.posY);
    _pulse = AnimationController(vsync: this, duration: const Duration(seconds: 2))..repeat(reverse: true);
  }
  @override
  void didUpdateWidget(_TableWidget old) {
    super.didUpdateWidget(old);
    if (!widget.editMode) _pos = Offset(widget.table.posX, widget.table.posY);
  }
  @override void dispose() { _pulse.dispose(); super.dispose(); }

  Color get _color => switch (widget.table.status) {
    TableStatus.available => AppColors.tableAvailable,
    TableStatus.occupied  => AppColors.tableOccupied,
    TableStatus.reserved  => AppColors.tableReserved,
    TableStatus.cleaning  => AppColors.tableCleaning,
  };

  void _showTableContextMenu(BuildContext context, Offset globalPosition, TableEntity table, WidgetRef ref) {
    showMenu<String>(
      context: context,
      position: RelativeRect.fromLTRB(
        globalPosition.dx,
        globalPosition.dy,
        globalPosition.dx + 1,
        globalPosition.dy + 1,
      ),
      items: const [
        PopupMenuItem<String>(
          value: 'available',
          child: Row(children: [
            Icon(Icons.check_circle_outline, color: AppColors.tableAvailable, size: 18),
            SizedBox(width: 8),
            Text('Set Available'),
          ]),
        ),
        PopupMenuItem<String>(
          value: 'reserved',
          child: Row(children: [
            Icon(Icons.bookmark_outline, color: AppColors.tableReserved, size: 18),
            SizedBox(width: 8),
            Text('Set Reserved'),
          ]),
        ),
        PopupMenuItem<String>(
          value: 'cleaning',
          child: Row(children: [
            Icon(Icons.cleaning_services_outlined, color: AppColors.tableCleaning, size: 18),
            SizedBox(width: 8),
            Text('Set Cleaning'),
          ]),
        ),
      ],
    ).then((value) async {
      if (value == null) return;
      final db = ref.read(dbProvider);
      if (value == 'available') {
        await db.tableDao.freeTable(table.id);
      } else {
        await db.tableDao.freeTable(table.id);
        await db.tableDao.setStatus(table.id, value);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final t = widget.table;
    final c = _color;
    return Positioned(
      left: _pos.dx, top: _pos.dy,
      child: GestureDetector(
        onTap: widget.onTap,
        onSecondaryTapDown: (details) => _showTableContextMenu(context, details.globalPosition, t, ref),
        onPanUpdate: widget.editMode ? (d) => setState(() => _pos += d.delta) : null,
        onPanEnd: widget.editMode ? (_) => widget.onDragged(_pos) : null,
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 300),
          width: t.width, height: t.height,
          decoration: BoxDecoration(
            color: c.withAlpha(t.isOccupied ? 35 : 20),
            borderRadius: t.shape == 'circle' ? BorderRadius.circular(t.width / 2) : BorderRadius.circular(12),
            border: Border.all(color: c, width: widget.editMode ? 2 : 1.5),
            boxShadow: t.isOccupied ? [BoxShadow(color: c.withAlpha(60), blurRadius: 8, spreadRadius: 1)] : null,
          ),
          child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
            Icon(t.isOccupied ? Icons.person_rounded : Icons.table_restaurant_rounded, color: c, size: 18),
            const SizedBox(height: 3),
            Text(t.name, style: TextStyle(color: c, fontWeight: FontWeight.w800, fontSize: 13)),
            if (t.isOccupied) ...[
              if (t.runningTotal > 0)
                Consumer(builder: (_, ref, __) => Text(
                  '${ref.watch(settingsProvider).currencySymbol} ${t.runningTotal.toStringAsFixed(0)}',
                  style: TextStyle(fontSize: 10, color: c.withAlpha(200)))),
              if (t.waiterName != null)
                Text(t.waiterName!.split(' ').first, style: TextStyle(fontSize: 9, color: c.withAlpha(170))),
            ],
            const SizedBox(height: 3),
            if (t.isOccupied)
              FadeTransition(
                opacity: Tween(begin: 0.4, end: 1.0).animate(_pulse),
                child: Container(width: 7, height: 7, decoration: BoxDecoration(color: c, shape: BoxShape.circle)),
              )
            else
              Container(width: 7, height: 7, decoration: BoxDecoration(color: c, shape: BoxShape.circle)),
          ]),
        ),
      ),
    );
  }
}

class _RoundBtn extends StatelessWidget {
  const _RoundBtn({required this.icon, required this.onTap});
  final IconData icon; final VoidCallback? onTap;
  @override
  Widget build(BuildContext context) => GestureDetector(
    onTap: onTap,
    child: Container(
      width: 40, height: 40,
      decoration: BoxDecoration(
        color: onTap != null ? context.cs.primary.withAlpha(20) : context.border,
        shape: BoxShape.circle,
        border: Border.all(color: onTap != null ? context.cs.primary.withAlpha(80) : context.border),
      ),
      child: Icon(icon, size: 22, color: onTap != null ? context.cs.primary : context.cs.onSurfaceVariant),
    ),
  );
}

// ═══════════════════════════════════════════════════════
// ORDER TERMINAL SCREEN — Complete order management
// ═══════════════════════════════════════════════════════
class POSScreen extends ConsumerStatefulWidget {
  const POSScreen({super.key, required this.tableId});
  final int tableId;
  @override ConsumerState<POSScreen> createState() => _POSScreenState();
}

class _POSScreenState extends ConsumerState<POSScreen> {
  int? _selectedGroupId;
  String _search = '';
  final _searchCtrl = TextEditingController();
  bool _showSearch = false;
  bool _showDeals = false;

  @override
  void dispose() { _searchCtrl.dispose(); super.dispose(); }

  @override
  Widget build(BuildContext context) {
    final orderAsync = ref.watch(posProvider(widget.tableId));
    final order = orderAsync.valueOrNull;
    final isDark = context.isDark;
    final settings = ref.watch(settingsProvider);
    final groupsAsync = ref.watch(menuGroupsProvider);
    final groups = groupsAsync.valueOrNull ?? [];

    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_new, size: 18),
          tooltip: 'Back to floor',
          onPressed: () => context.go('/floor'),
        ),
        title: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Text('Table ${_getTableName()}', style: const TextStyle(fontSize: 17, fontWeight: FontWeight.w700)),
          if (order != null)
            Text('#${order.orderNumber} · ${order.waiterName} · ${order.guestCount} guests',
              style: TextStyle(fontSize: 11, color: context.cs.onSurfaceVariant, fontWeight: FontWeight.w400)),
        ]),
        actions: [
          // Search
          IconButton(icon: Icon(_showSearch ? Icons.close : Icons.search_rounded),
            tooltip: _showSearch ? 'Close search' : 'Search menu',
            onPressed: () => setState(() { _showSearch = !_showSearch; if (!_showSearch) { _search = ''; _searchCtrl.clear(); } if (_showSearch) _showDeals = false; } )),
          // Order actions
          if (order != null) ...[
            IconButton(icon: const Icon(Icons.pause_rounded), tooltip: 'Hold order',
              onPressed: () => ref.read(posProvider(widget.tableId).notifier).holdOrder()),
            IconButton(icon: const Icon(Icons.kitchen_rounded), tooltip: 'Send to kitchen',
              onPressed: order.pendingKitchenItems.isEmpty ? null : _sendToKitchen),
            IconButton(
              icon: const Icon(Icons.receipt_long_rounded),
              tooltip: 'Print bill',
              onPressed: order.activeItems.isEmpty ? null : _printBill,
            ),
            PopupMenuButton(
              icon: const Icon(Icons.more_vert_rounded),
              itemBuilder: (_) => [
                const PopupMenuItem(value: 'void', child: Row(children: [Icon(Icons.cancel_outlined, color: Colors.red, size: 18), SizedBox(width: 8), Text('Void order', style: TextStyle(color: Colors.red))])),
                const PopupMenuItem(value: 'transfer', child: Row(children: [Icon(Icons.swap_horiz, size: 18), SizedBox(width: 8), Text('Transfer table')])),
                const PopupMenuItem(value: 'a4', child: Row(children: [Icon(Icons.picture_as_pdf_outlined, size: 18), SizedBox(width: 8), Text('Print A4 invoice')])),
              ],
              onSelected: (v) async {
                if (v == 'void') await _voidOrder();
                if (v == 'transfer') await _transferTable();
                if (v == 'a4' && order != null) _printA4();
              },
            ),
          ],
        ],
      ),
      body: Row(children: [
        // ── LEFT: Menu panel ──────────────────────
        Expanded(flex: 3, child: Column(children: [
          // Search bar
          AnimatedSize(
            duration: const Duration(milliseconds: 250),
            child: _showSearch ? Container(
              padding: const EdgeInsets.all(10),
              color: isDark ? AppColors.darkCard : Colors.white,
              child: TextField(
                controller: _searchCtrl, autofocus: true,
                onChanged: (v) => setState(() => _search = v),
                decoration: const InputDecoration(
                  hintText: 'Search menu items...', isDense: true,
                  prefixIcon: Icon(Icons.search, size: 18),
                ),
              ),
            ) : const SizedBox.shrink(),
          ),

          // Menu grid — groups or items
          Expanded(
            child: _search.isNotEmpty
              ? _SearchResults(search: _search, onAdd: _addItem)
              : _showDeals
                ? _DealsGrid(onAdd: _addDeal, onBack: () => setState(() => _showDeals = false))
              : _selectedGroupId == null
                ? _GroupGrid(groups: groups, onGroupTap: (g) => setState(() { _selectedGroupId = g.id; _showDeals = false; }), onDealsTap: () => setState(() => _showDeals = true))
                : _MenuGrid(groupId: _selectedGroupId!, onAdd: _addItem, onBack: () => setState(() => _selectedGroupId = null)),
          ),
        ])),

        // ── RIGHT: Cart panel ─────────────────────
        SizedBox(
          width: 380,
          child: _CartPanel(
            order: order,
            tableId: widget.tableId,
            onQtyChange: (itemId, qty) => ref.read(posProvider(widget.tableId).notifier).setQty(itemId, qty),
            onVoidItem: (itemId) => ref.read(posProvider(widget.tableId).notifier).voidItem(itemId),
            onDiscount: _showDiscountDialog,
            onKitchen: order != null && order.pendingKitchenItems.isNotEmpty ? _sendToKitchen : null,
            onBill: order != null && order.activeItems.isNotEmpty ? _printBill : null,
            onPay: order != null && order.activeItems.isNotEmpty ? _showPaymentDialog : null,
          ),
        ),
      ]),
    );
  }

  String _getTableName() {
    final tableAsync = ref.read(tablesProvider);
    final table = tableAsync.valueOrNull?.firstWhere((t) => t.id == widget.tableId, orElse: () => TableEntity(id: widget.tableId, floorId: 0, name: 'T${widget.tableId}', capacity: 4, status: TableStatus.occupied));
    return table?.name ?? 'Table';
  }

  Color _hexColor(String hex) {
    try {
      return Color(int.parse(hex.replaceFirst('#', 'FF'), radix: 16));
    } catch (_) {
      return const Color(0xFF1A56DB);
    }
  }

  void _addItem(MenuItemEntity item) {
    if (item.isOutOfStock) { showError(context, '${item.name} is out of stock'); return; }
    ref.read(posProvider(widget.tableId).notifier).addItem(item);
  }

  Future<void> _addDeal(DealRow deal) async {
    final db = ref.read(dbProvider);
    final dealItems = await db.dealDao.itemsForDeal(deal.id);
    if (dealItems.isEmpty) {
      if (mounted) showError(context, 'This deal has no menu items');
      return;
    }

    final menuItems = <MenuItemRow>[];
    for (final dealItem in dealItems) {
      final menuItem = await db.menuDao.byId(dealItem.menuItemId);
      if (menuItem != null) menuItems.add(menuItem);
    }
    if (menuItems.length != dealItems.length) {
      if (mounted) showError(context, 'One or more deal items are missing');
      return;
    }

    await ref.read(posProvider(widget.tableId).notifier).addDeal(deal, dealItems, menuItems);
    if (mounted) showSuccess(context, '${deal.name} added');
  }

  void _showModifierSheet(MenuItemEntity item) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(borderRadius: BorderRadius.vertical(top: Radius.circular(20))),
      builder: (_) => _ItemCustomizationSheet(
        item: item,
        onConfirm: (qty, notes, mods) => ref.read(posProvider(widget.tableId).notifier).addItem(item, qty: qty, notes: notes, mods: mods),
      ),
    );
  }

  Future<void> _sendToKitchen() async {
    final order = ref.read(posProvider(widget.tableId)).valueOrNull;
    if (order == null) return;
    await ref.read(posProvider(widget.tableId).notifier).sendToKitchen();
    // Print kitchen ticket
    await PrintService.instance.printKitchenTicket(order);
    if (mounted) showSuccess(context, 'Sent to kitchen & ticket printed');
  }

  Future<void> _printBill() async {
    final order = ref.read(posProvider(widget.tableId)).valueOrNull;
    if (order == null) return;
    await ref.read(posProvider(widget.tableId).notifier).printProformaBill();
    await PrintService.instance.printProformaBill(order);
    if (mounted) showSuccess(context, 'Bill printed');
  }

  Future<void> _transferTable() async {
    final db = ref.read(dbProvider);
    final order = ref.read(posProvider(widget.tableId)).valueOrNull;
    if (order == null) return;
    final currentTable = await db.tableDao.byId(widget.tableId);
    if (currentTable == null) return;
    final tables = await db.tableDao.watchByFloor(currentTable.floorId).first;
    final available = tables.where((t) => t.id != widget.tableId && (t.status == 'available' || t.status == 'reserved')).toList();
    if (available.isEmpty) {
      if (mounted) showError(context, 'No other available tables on this floor');
      return;
    }
    final sel = await showDialog<RestaurantTableRow>(
      context: context,
      builder: (ctx) => AlertDialog(
        title: const Text('Transfer to table'),
        content: SizedBox(
          width: 300, height: 400,
          child: ListView.builder(
            itemCount: available.length,
            itemBuilder: (_, i) {
              final t = available[i];
              return ListTile(
                leading: Icon(t.status == 'available' ? Icons.check_circle_outline : Icons.event_busy,
                    color: t.status == 'available' ? Colors.green : Colors.orange),
                title: Text(t.name),
                subtitle: Text(t.status == 'available' ? 'Available' : 'Reserved'),
                onTap: () => Navigator.pop(ctx, t),
              );
            },
          ),
        ),
        actions: [TextButton(onPressed: () => Navigator.pop(ctx), child: const Text('Cancel'))],
      ),
    );
    if (sel == null || !mounted) return;

    // Update order's tableId
    await db.orderDao.updateOrder(OrdersCompanion(
      id: Value(order.id),
      tableId: Value(sel.id),
      tableNameCol: Value(sel.name),
    ));
    // Free old table
    await db.tableDao.freeTable(widget.tableId);
    // Occupy new table
    await db.tableDao.setStatus(sel.id, 'occupied',
        orderId: order.id, waiterName: order.waiterName,
        guestCount: order.guestCount, orderStartTime: order.createdAt);
    // Navigate to new table POS
    if (mounted) context.go('/pos/${sel.id}');
  }

  Future<void> _printA4() async {
    final db = ref.read(dbProvider);
    final order = ref.read(posProvider(widget.tableId)).valueOrNull;
    if (order == null) return;
    final invRow = await db.invoiceDao.byOrder(order.id);
    // Proforma A4 if no final invoice exists yet
    final inv = invRow != null
        ? _buildInvoiceFromRow(invRow, order)
        : InvoiceEntity(
            id: 0, invoiceNumber: 'PROFORMA', orderId: order.id,
            orderNumber: order.orderNumber, tableName: order.tableName,
            waiterName: order.waiterName,
            items: order.activeItems, subtotal: order.subtotal,
            discountValue: order.discountValue, taxValue: order.taxValue,
            serviceChargeValue: order.serviceChargeValue,
            grandTotal: order.grandTotal, amountPaid: 0, changeAmount: 0,
            paymentMethod: PaymentMethod.cash, status: BillStatus.proforma,
            createdAt: DateTime.now(), paymentSplits: const [],
          );
    await PrintService.instance.printA4Invoice(inv);
  }

  InvoiceEntity _buildInvoiceFromRow(InvoiceRow r, OrderEntity o) {
    List<PaymentSplit> splits = [];
    try {
      final d = jsonDecode(r.paymentSplitsJson) as List;
      splits = d.map((s) => PaymentSplit(method: PaymentMethod.values.firstWhere((m) => m.name == s['method'], orElse: () => PaymentMethod.cash), amount: (s['amount'] as num).toDouble())).toList();
    } catch (_) {}
    return InvoiceEntity(
      id: r.id, invoiceNumber: r.invoiceNumber, orderId: r.orderId,
      orderNumber: r.orderNumber, tableName: r.tableNameCol, waiterName: r.waiterName,
      items: o.activeItems, subtotal: r.subtotal, discountValue: r.discountValue,
      taxValue: r.taxValue, serviceChargeValue: r.serviceChargeValue,
      grandTotal: r.grandTotal, amountPaid: r.amountPaid, changeAmount: r.changeAmount,
      paymentMethod: PaymentMethod.values.firstWhere((m) => m.name == r.paymentMethod, orElse: () => PaymentMethod.cash),
      status: BillStatus.final_, createdAt: r.createdAt, paymentSplits: splits,
    );
  }

  void _showDiscountDialog() {
    final order = ref.read(posProvider(widget.tableId)).valueOrNull;
    if (order == null) return;
    bool isPct = true;
    final ctrl = TextEditingController();
    showDialog(context: context, builder: (_) => StatefulBuilder(builder: (ctx, ss) => AlertDialog(
      title: const Text('Apply discount'),
      content: Column(mainAxisSize: MainAxisSize.min, children: [
        SegmentedButton<bool>(
          segments: const [ButtonSegment(value: true, label: Text('Percentage %')), ButtonSegment(value: false, label: Text('Fixed amount'))],
          selected: {isPct}, onSelectionChanged: (s) => ss(() => isPct = s.first),
        ),
        const SizedBox(height: 14),
        TextField(controller: ctrl, autofocus: true, keyboardType: TextInputType.number,
          decoration: InputDecoration(labelText: isPct ? 'Discount %' : 'Amount', prefixIcon: Icon(isPct ? Icons.percent : Icons.currency_exchange))),
        if (isPct) ...[
          const SizedBox(height: 10),
          Wrap(spacing: 8, children: [5, 10, 15, 20, 25, 50].map((p) => OutlinedButton(
            onPressed: () => ctrl.text = '$p',
            style: OutlinedButton.styleFrom(padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6)),
            child: Text('$p%', style: const TextStyle(fontSize: 12)),
          )).toList()),
        ],
      ]),
      actions: [
        TextButton(onPressed: () { ref.read(posProvider(widget.tableId).notifier).applyDiscount(); Navigator.pop(ctx); }, child: const Text('Remove')),
        TextButton(onPressed: () => Navigator.pop(ctx), child: const Text('Cancel')),
        FilledButton(
          onPressed: () {
            final v = double.tryParse(ctrl.text) ?? 0;
            ref.read(posProvider(widget.tableId).notifier).applyDiscount(percent: isPct ? v : 0, amount: isPct ? 0 : v);
            Navigator.pop(ctx);
          },
          child: const Text('Apply'),
        ),
      ],
    )));
  }

  void _showPaymentDialog() {
    final order = ref.read(posProvider(widget.tableId)).valueOrNull;
    if (order == null) return;
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (_) => _PaymentDialog(
        order: order,
        onPay: (method, amountPaid, splits, custName, custPhone) async {
          final inv = await ref.read(posProvider(widget.tableId).notifier).processPayment(
            method: method, amountPaid: amountPaid, splits: splits,
            customerName: custName, customerPhone: custPhone,
          );
          if (inv != null) {
            // Print final receipt
            await PrintService.instance.printFinalReceipt(inv);
            if (mounted) {
              Navigator.of(context).pop();
              showSuccess(context, 'Payment done! Receipt printed.');
              context.go('/floor');
            }
          }
        },
      ),
    );
  }

  Future<void> _voidOrder() async {
    final ok = await confirm(context, 'Void Order?', 'This will cancel the entire order and free the table.', danger: true);
    if (ok) {
      await ref.read(posProvider(widget.tableId).notifier).voidOrder();
      if (mounted) { showSuccess(context, 'Order voided'); context.go('/floor'); }
    }
  }
}

// ── Menu Grid ─────────────────────────────────────────
class _DealsGrid extends ConsumerWidget {
  const _DealsGrid({required this.onAdd, required this.onBack});
  final ValueChanged<DealRow> onAdd;
  final VoidCallback onBack;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final dealsAsync = ref.watch(activeDealsProvider);
    return Column(children: [
      // Back header
      Container(
        height: 44,
        color: context.cardBg,
        child: Row(children: [
          IconButton(
            icon: const Icon(Icons.arrow_back_ios_new, size: 16),
            onPressed: onBack,
            tooltip: 'All categories',
          ),
          Text('Categories', style: TextStyle(fontSize: 12, color: context.cs.onSurfaceVariant)),
          const SizedBox(width: 8),
          Icon(Icons.chevron_right, size: 16, color: context.cs.onSurfaceVariant),
          const SizedBox(width: 8),
          Text('Deals', style: TextStyle(fontSize: 13, fontWeight: FontWeight.w700, color: const Color(0xFFD97706))),
        ]),
      ),
      Expanded(child: dealsAsync.when(
        loading: () => _shimmerGrid(context),
        error: (e, _) => Center(child: Text('Error: $e')),
        data: (deals) => deals.isEmpty
          ? Center(child: Column(mainAxisSize: MainAxisSize.min, children: [
              Icon(Icons.local_offer_outlined, size: 56, color: context.cs.onSurfaceVariant.withAlpha(80)),
              const SizedBox(height: 12),
              Text('No active deals', style: TextStyle(color: context.cs.onSurfaceVariant)),
            ]))
          : GridView.builder(
              padding: const EdgeInsets.all(12),
              gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
                maxCrossAxisExtent: 190, childAspectRatio: 0.82,
                crossAxisSpacing: 10, mainAxisSpacing: 10,
              ),
              itemCount: deals.length,
              itemBuilder: (_, i) => _DealCard(deal: deals[i], onTap: () => onAdd(deals[i]))
                .animate(delay: Duration(milliseconds: i * 25)).fadeIn(duration: 200.ms),
            ),
      )),
    ]);
  }

  Widget _shimmerGrid(BuildContext context) => GridView.builder(
    padding: const EdgeInsets.all(12),
    gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(maxCrossAxisExtent: 190, childAspectRatio: 0.82, crossAxisSpacing: 10, mainAxisSpacing: 10),
    itemCount: 6,
    itemBuilder: (ctx, _) => Shimmer.fromColors(
      baseColor: ctx.isDark ? const Color(0xFF1E293B) : const Color(0xFFE2E8F0),
      highlightColor: ctx.isDark ? const Color(0xFF263348) : const Color(0xFFF1F5F9),
      child: Container(decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(14))),
    ),
  );
}

class _DealCard extends ConsumerWidget {
  const _DealCard({required this.deal, required this.onTap});
  final DealRow deal;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final sym = ref.watch(settingsProvider).currencySymbol;
    final cs = context.cs;

    return GestureDetector(
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(
          color: context.cardBg,
          borderRadius: BorderRadius.circular(14),
          border: Border.all(color: const Color(0xFFD97706).withAlpha(80), width: 0.7),
        ),
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Expanded(flex: 3, child: Stack(children: [
            ClipRRect(
              borderRadius: const BorderRadius.vertical(top: Radius.circular(13)),
              child: deal.imagePath != null && deal.imagePath!.isNotEmpty
                ? Image.file(File(AppPaths.resolve(deal.imagePath!)), width: double.infinity, fit: BoxFit.cover,
                    errorBuilder: (_, __, ___) => const _DealPlaceholderImg())
                : const _DealPlaceholderImg(),
            ),
            Positioned(top: 7, left: 7, child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 7, vertical: 3),
              decoration: BoxDecoration(
                color: const Color(0xFFD97706).withAlpha(230),
                borderRadius: BorderRadius.circular(7),
              ),
              child: const Text('DEAL', style: TextStyle(color: Colors.white, fontSize: 10, fontWeight: FontWeight.w800)),
            )),
          ])),
          Expanded(flex: 2, child: Padding(
            padding: const EdgeInsets.fromLTRB(9, 7, 9, 7),
            child: Column(crossAxisAlignment: CrossAxisAlignment.start, mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
              Text(deal.name, maxLines: 2, overflow: TextOverflow.ellipsis,
                style: const TextStyle(fontSize: 12, fontWeight: FontWeight.w700, height: 1.2)),
              if (deal.description != null && deal.description!.isNotEmpty)
                Text(deal.description!, maxLines: 1, overflow: TextOverflow.ellipsis,
                  style: TextStyle(fontSize: 10, color: cs.onSurfaceVariant)),
              Row(children: [
                Text('$sym ${deal.price.toStringAsFixed(0)}',
                  style: TextStyle(fontSize: 14, fontWeight: FontWeight.w800, color: cs.primary)),
                const Spacer(),
                const Icon(Icons.add_circle_rounded, size: 18, color: Color(0xFFD97706)),
              ]),
            ]),
          )),
        ]),
      ),
    );
  }
}

class _DealPlaceholderImg extends StatelessWidget {
  const _DealPlaceholderImg();

  @override
  Widget build(BuildContext context) => Container(
    color: const Color(0xFFD97706).withAlpha(14),
    child: const Center(child: Icon(Icons.local_offer_rounded, size: 44, color: Color(0xFFD97706))),
  );
}

class _MenuGrid extends ConsumerWidget {
  const _MenuGrid({required this.groupId, required this.onAdd, required this.onBack});
  final int groupId;
  final ValueChanged<MenuItemEntity> onAdd;
  final VoidCallback onBack;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final itemsAsync = ref.watch(menuItemsByGroupProvider(groupId));
    return Column(children: [
      // Back header
      Container(
        height: 44,
        color: context.cardBg,
        child: Row(children: [
          IconButton(
            icon: const Icon(Icons.arrow_back_ios_new, size: 16),
            onPressed: onBack,
            tooltip: 'All categories',
          ),
          Text('Categories', style: TextStyle(fontSize: 12, color: context.cs.onSurfaceVariant)),
          const SizedBox(width: 8),
          Icon(Icons.chevron_right, size: 16, color: context.cs.onSurfaceVariant),
          const SizedBox(width: 8),
          Text(itemsAsync.valueOrNull != null && itemsAsync.valueOrNull!.isNotEmpty ? itemsAsync.valueOrNull!.first.groupName : '',
            style: TextStyle(fontSize: 13, fontWeight: FontWeight.w700, color: context.cs.primary)),
          const Spacer(),
        ]),
      ),
      Expanded(child: itemsAsync.when(
        loading: () => _shimmerGrid(),
        error: (e, _) => Center(child: Text('Error: $e')),
        data: (items) => items.isEmpty
          ? Center(child: Column(mainAxisSize: MainAxisSize.min, children: [
              Icon(Icons.restaurant_menu_rounded, size: 56, color: context.cs.onSurfaceVariant.withAlpha(80)),
              const SizedBox(height: 12),
              Text('No items in this group', style: TextStyle(color: context.cs.onSurfaceVariant)),
            ]))
          : GridView.builder(
              padding: const EdgeInsets.all(12),
              gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
                maxCrossAxisExtent: 170, childAspectRatio: 0.78,
                crossAxisSpacing: 10, mainAxisSpacing: 10,
              ),
              itemCount: items.length,
              itemBuilder: (_, i) => _MenuItemCard(item: items[i], onTap: () => onAdd(items[i]))
                .animate(delay: Duration(milliseconds: i * 25)).fadeIn(duration: 200.ms),
            ),
      )),
    ]);
  }

  Widget _shimmerGrid() => GridView.builder(
    padding: const EdgeInsets.all(12),
    gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(maxCrossAxisExtent: 170, childAspectRatio: 0.78, crossAxisSpacing: 10, mainAxisSpacing: 10),
    itemCount: 8,
    itemBuilder: (ctx, _) => Shimmer.fromColors(
      baseColor: ctx.isDark ? const Color(0xFF1E293B) : const Color(0xFFE2E8F0),
      highlightColor: ctx.isDark ? const Color(0xFF263348) : const Color(0xFFF1F5F9),
      child: Container(decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(14))),
    ),
  );
}

class _MenuItemCard extends ConsumerWidget {
  const _MenuItemCard({required this.item, required this.onTap});
  final MenuItemEntity item;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final sym = ref.watch(settingsProvider).currencySymbol;
    final cs = context.cs;
    final unavailable = !item.isAvailable || item.isOutOfStock;

    return GestureDetector(
      onTap: unavailable ? null : onTap,
      child: Opacity(
        opacity: unavailable ? 0.45 : 1.0,
        child: Container(
          decoration: BoxDecoration(
            color: context.cardBg,
            borderRadius: BorderRadius.circular(14),
            border: Border.all(color: context.border, width: 0.5),
          ),
          child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            // Image
            Expanded(flex: 3, child: Stack(children: [
              ClipRRect(
                borderRadius: const BorderRadius.vertical(top: Radius.circular(13)),
                child: item.hasImage
                  ? Image.file(File(AppPaths.resolve(item.imagePath!)), width: double.infinity, fit: BoxFit.cover,
                      errorBuilder: (_, __, ___) => _PlaceholderImg(item: item))
                  : _PlaceholderImg(item: item),
              ),
              if (!item.isUnlimited)
                Positioned(top: 6, right: 6, child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                  decoration: BoxDecoration(
                    color: item.isLowStock ? Colors.orange.withAlpha(230) : Colors.green.withAlpha(200),
                    borderRadius: BorderRadius.circular(6),
                  ),
                  child: Text('${item.stockCount}', style: const TextStyle(color: Colors.white, fontSize: 10, fontWeight: FontWeight.w700)),
                )),
              if (unavailable)
                Positioned.fill(child: Container(
                  decoration: BoxDecoration(
                    color: Colors.black.withAlpha(100),
                    borderRadius: const BorderRadius.vertical(top: Radius.circular(13)),
                  ),
                  child: const Center(child: Text('UNAVAILABLE', style: TextStyle(color: Colors.white, fontSize: 10, fontWeight: FontWeight.w700))),
                )),
            ])),
            // Info
            Expanded(flex: 2, child: Padding(
              padding: const EdgeInsets.fromLTRB(9, 7, 9, 7),
              child: Column(crossAxisAlignment: CrossAxisAlignment.start, mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
                Text(item.name, maxLines: 2, overflow: TextOverflow.ellipsis,
                  style: const TextStyle(fontSize: 12, fontWeight: FontWeight.w600, height: 1.2)),
                Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
                  Text('$sym ${item.price.toStringAsFixed(0)}',
                    style: TextStyle(fontSize: 13, fontWeight: FontWeight.w700, color: cs.primary)),
                  if (item.preparationMinutes > 0)
                    Row(children: [
                      Icon(Icons.timer_outlined, size: 11, color: cs.onSurfaceVariant),
                      Text(' ${item.preparationMinutes}m', style: TextStyle(fontSize: 10, color: cs.onSurfaceVariant)),
                    ]),
                ]),
              ]),
            )),
          ]),
        ),
      ),
    );
  }
}

class _PlaceholderImg extends StatelessWidget {
  const _PlaceholderImg({required this.item});
  final MenuItemEntity item;
  @override
  Widget build(BuildContext context) => Container(
    color: context.cs.primary.withAlpha(12),
    child: Center(child: Icon(Icons.restaurant_rounded, size: 44, color: context.cs.primary.withAlpha(70))),
  );
}

class _GroupGrid extends StatelessWidget {
  const _GroupGrid({required this.groups, required this.onGroupTap, required this.onDealsTap});
  final List<MenuGroupEntity> groups;
  final ValueChanged<MenuGroupEntity> onGroupTap;
  final VoidCallback onDealsTap;

  @override
  Widget build(BuildContext context) {
    if (groups.isEmpty) return Center(child: Column(mainAxisSize: MainAxisSize.min, children: [
      Icon(Icons.restaurant_menu_rounded, size: 64, color: context.cs.onSurfaceVariant.withAlpha(80)),
      const SizedBox(height: 12),
      Text('No menu categories found', style: TextStyle(color: context.cs.onSurfaceVariant)),
    ]));
    return GridView.builder(
      padding: const EdgeInsets.all(16),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 6, childAspectRatio: 0.9, crossAxisSpacing: 10, mainAxisSpacing: 10,
      ),
      itemCount: groups.length + 1,
      itemBuilder: (_, i) {
        if (i == 0) {
          // Deals card
          return GestureDetector(
            onTap: onDealsTap,
            child: Container(
              decoration: BoxDecoration(
                color: const Color(0xFFD97706).withAlpha(20),
                borderRadius: BorderRadius.circular(16),
                border: Border.all(color: const Color(0xFFD97706).withAlpha(60)),
              ),
              child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
                Icon(Icons.local_offer_rounded, size: 44, color: const Color(0xFFD97706)),
                const SizedBox(height: 8),
                Text('Deals', style: TextStyle(fontSize: 14, fontWeight: FontWeight.w700, color: const Color(0xFFD97706))),
              ]),
            ),
          );
        }
        final g = groups[i - 1];
        final color = _parseColor(g.colorHex);
        final hasIcon = g.iconPath.isNotEmpty;
        return GestureDetector(
          onTap: () => onGroupTap(g),
          child: Container(
            decoration: BoxDecoration(
              color: color.withAlpha(15),
              borderRadius: BorderRadius.circular(16),
              border: Border.all(color: color.withAlpha(50)),
            ),
            child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
              hasIcon
                ? ClipRRect(
                    borderRadius: BorderRadius.circular(12),
                    child: SizedBox(width: 90, height: 90, child: Image.file(File(AppPaths.resolve(g.iconPath)), fit: BoxFit.cover,
                      errorBuilder: (_, __, ___) => Icon(Icons.restaurant_menu_rounded, size: 48, color: color))),
                  )
                : Icon(Icons.restaurant_menu_rounded, size: 64, color: color),
              const SizedBox(height: 6),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 6),
                child: Text(g.name, maxLines: 2, textAlign: TextAlign.center, overflow: TextOverflow.ellipsis,
                  style: TextStyle(fontSize: 12, fontWeight: FontWeight.w700, color: color)),
              ),
            ]),
          ),
        );
      },
    );
  }

  Color _parseColor(String hex) {
    try { return Color(int.parse(hex.replaceFirst('#', 'FF'), radix: 16)); }
    catch (_) { return const Color(0xFF1A56DB); }
  }
}

class _SearchResults extends ConsumerWidget {
  const _SearchResults({required this.search, required this.onAdd});
  final String search;
  final ValueChanged<MenuItemEntity> onAdd;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return FutureBuilder<List<MenuItemRow>>(
      future: ref.watch(dbProvider).menuDao.search(search),
      builder: (_, snap) {
        if (!snap.hasData) return const Center(child: CircularProgressIndicator());
        final rows = snap.data!;
        if (rows.isEmpty) return Center(child: Column(mainAxisSize: MainAxisSize.min, children: [
          const Icon(Icons.search_off_rounded, size: 48),
          const SizedBox(height: 8),
          Text('No results for "$search"'),
        ]));
        return GridView.builder(
          padding: const EdgeInsets.all(12),
          gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
            maxCrossAxisExtent: 170, childAspectRatio: 0.78, crossAxisSpacing: 10, mainAxisSpacing: 10),
          itemCount: rows.length,
          itemBuilder: (_, i) {
            final item = mapMenuItemRow(rows[i], '');
            return _MenuItemCard(item: item, onTap: () => onAdd(item));
          },
        );
      },
    );
  }
}

// ── Cart Panel ────────────────────────────────────────
class _CartPanel extends ConsumerWidget {
  const _CartPanel({
    required this.order, required this.tableId,
    required this.onQtyChange, required this.onVoidItem,
    required this.onDiscount, this.onKitchen, this.onBill, this.onPay,
  });
  final OrderEntity? order;
  final int tableId;
  final void Function(int itemId, int qty) onQtyChange;
  final void Function(int itemId) onVoidItem;
  final VoidCallback onDiscount;
  final VoidCallback? onKitchen;
  final VoidCallback? onBill;
  final VoidCallback? onPay;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isDark = context.isDark;
    final settings = ref.watch(settingsProvider);
    final o = order;

    return Container(
      decoration: BoxDecoration(
        color: isDark ? AppColors.darkBg : const Color(0xFFF8FAFC),
        border: Border(left: BorderSide(color: context.border, width: 0.5)),
      ),
      child: Column(children: [
        // Cart header
        Container(
          height: 54,
          padding: const EdgeInsets.symmetric(horizontal: 14),
          color: isDark ? AppColors.darkCard : Colors.white,
          child: Row(children: [
            const Icon(Icons.shopping_cart_rounded, size: 20),
            const SizedBox(width: 8),
            Text('Order', style: context.tt.titleMedium?.copyWith(fontWeight: FontWeight.w700)),
            if (o != null) ...[
              const SizedBox(width: 8),
              Chip(label: Text('${o.totalItems} items', style: const TextStyle(fontSize: 11)), padding: EdgeInsets.zero, visualDensity: VisualDensity.compact),
            ],
            const Spacer(),
            if (o?.status == OrderStatus.hold)
              Chip(label: const Text('ON HOLD', style: TextStyle(fontSize: 11, color: Colors.orange)), padding: EdgeInsets.zero, visualDensity: VisualDensity.compact, backgroundColor: Colors.orange.withAlpha(20)),
          ]),
        ),

        // Cart items
        Expanded(
          child: o == null || o.activeItems.isEmpty
            ? Center(child: Column(mainAxisSize: MainAxisSize.min, children: [
                Icon(Icons.add_shopping_cart_rounded, size: 56, color: context.cs.onSurfaceVariant.withAlpha(80)),
                const SizedBox(height: 12),
                Text('Tap menu items to add', style: TextStyle(color: context.cs.onSurfaceVariant, fontSize: 13)),
              ]))
            : ListView.builder(
                padding: const EdgeInsets.symmetric(vertical: 6),
                itemCount: o.items.length,
                itemBuilder: (_, i) {
                  final item = o.items[i];
                  if (item.isVoided) return _VoidedItemRow(item: item);
                  return _CartItemRow(
                    item: item,
                    settings: settings,
                    onIncrement: () => onQtyChange(item.id, item.quantity + 1),
                    onDecrement: () => onQtyChange(item.id, item.quantity - 1),
                    onVoid: () => onVoidItem(item.id),
                  ).animate(delay: Duration(milliseconds: i * 20)).fadeIn();
                },
              ),
        ),

        // Order summary & actions
        if (o != null && o.activeItems.isNotEmpty) ...[
          Container(
            padding: const EdgeInsets.all(14),
            color: isDark ? AppColors.darkCard : Colors.white,
            child: Column(children: [
              // Totals
              _SummaryRow('Subtotal', o.subtotal, settings.currencySymbol),
              if (o.discountValue > 0) _SummaryRow('Discount', -o.discountValue, settings.currencySymbol, color: Colors.green),
              if (o.taxValue > 0) _SummaryRow('GST (${o.taxPercent.toStringAsFixed(0)}%)', o.taxValue, settings.currencySymbol),
              if (o.serviceChargeValue > 0) _SummaryRow('Service (${o.serviceChargePercent.toStringAsFixed(0)}%)', o.serviceChargeValue, settings.currencySymbol),
              const Divider(height: 12),
              Row(children: [
                Text('Total', style: const TextStyle(fontWeight: FontWeight.w800, fontSize: 16)),
                const Spacer(),
                Text('${settings.currencySymbol} ${o.grandTotal.toStringAsFixed(0)}',
                  style: TextStyle(fontWeight: FontWeight.w800, fontSize: 20, color: context.cs.primary)),
              ]),
              const SizedBox(height: 12),
              // Action buttons
              Row(children: [
                Expanded(child: OutlinedButton.icon(
                  icon: const Icon(Icons.discount_outlined, size: 16),
                  label: const Text('Discount'),
                  onPressed: onDiscount,
                  style: OutlinedButton.styleFrom(padding: const EdgeInsets.symmetric(vertical: 10)),
                )),
                const SizedBox(width: 8),
                Expanded(child: OutlinedButton.icon(
                  icon: const Icon(Icons.kitchen_rounded, size: 16),
                  label: Text(o.pendingKitchenItems.isEmpty ? 'Kitchen ✓' : 'Send (${o.pendingKitchenItems.length})'),
                  onPressed: onKitchen,
                  style: OutlinedButton.styleFrom(
                    padding: const EdgeInsets.symmetric(vertical: 10),
                    foregroundColor: onKitchen != null ? AppColors.orderKitchen : null,
                    side: BorderSide(color: onKitchen != null ? AppColors.orderKitchen : context.border),
                  ),
                )),
              ]),
              const SizedBox(height: 8),
              Row(children: [
                Expanded(child: OutlinedButton.icon(
                  icon: const Icon(Icons.receipt_long_rounded, size: 16),
                  label: const Text('Print Bill'),
                  onPressed: onBill,
                  style: OutlinedButton.styleFrom(padding: const EdgeInsets.symmetric(vertical: 10)),
                )),
                const SizedBox(width: 8),
                Expanded(flex: 2, child: FilledButton.icon(
                  icon: const Icon(Icons.payment_rounded, size: 18),
                  label: Text('Pay ${settings.currencySymbol} ${o.grandTotal.toStringAsFixed(0)}'),
                  onPressed: onPay,
                  style: FilledButton.styleFrom(
                    padding: const EdgeInsets.symmetric(vertical: 13),
                    textStyle: const TextStyle(fontWeight: FontWeight.w700, fontSize: 15),
                  ),
                )),
              ]),
            ]),
          ),
        ],
      ]),
    );
  }
}

class _CartItemRow extends StatelessWidget {
  const _CartItemRow({required this.item, required this.settings, required this.onIncrement, required this.onDecrement, required this.onVoid});
  final OrderItemEntity item;
  final RestaurantSettings settings;
  final VoidCallback onIncrement, onDecrement, onVoid;

  @override
  Widget build(BuildContext context) {
    final isDark = context.isDark;
    final sentToKitchen = item.status != OrderItemStatus.pending;
    final statusColor = sentToKitchen ? AppColors.orderKitchen : context.cs.onSurfaceVariant;

    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 3),
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: isDark ? AppColors.darkCard : Colors.white,
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: sentToKitchen ? AppColors.orderKitchen.withAlpha(80) : context.border, width: 0.5),
      ),
      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        Row(children: [
          if (item.isDeal) ...[
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
              decoration: BoxDecoration(
                color: const Color(0xFFD97706).withAlpha(20),
                borderRadius: BorderRadius.circular(4),
              ),
              child: const Text('DEAL', style: TextStyle(fontSize: 9, color: Color(0xFFD97706), fontWeight: FontWeight.w800)),
            ),
            const SizedBox(width: 6),
          ],
          Expanded(child: Text(item.menuItem.name,
            style: const TextStyle(fontWeight: FontWeight.w600, fontSize: 13), maxLines: 1, overflow: TextOverflow.ellipsis)),
          if (sentToKitchen)
            Icon(Icons.kitchen_rounded, size: 14, color: AppColors.orderKitchen),
          const SizedBox(width: 4),
          Text('${settings.currencySymbol} ${item.lineTotal.toStringAsFixed(0)}',
            style: TextStyle(fontWeight: FontWeight.w700, fontSize: 13, color: context.cs.primary)),
        ]),
        if (item.notes.isNotEmpty)
          Padding(
            padding: const EdgeInsets.only(top: 3),
            child: Row(children: [
              Icon(Icons.sticky_note_2_outlined, size: 12, color: context.cs.onSurfaceVariant),
              const SizedBox(width: 4),
              Expanded(child: Text(item.notes, style: TextStyle(fontSize: 11, color: context.cs.onSurfaceVariant, fontStyle: FontStyle.italic), maxLines: 1, overflow: TextOverflow.ellipsis)),
            ]),
          ),
        if (item.isDeal && item.dealItems.isNotEmpty)
          Padding(
            padding: const EdgeInsets.only(top: 4),
            child: Text(
              item.dealItems.map((d) => '${d.quantity}x ${d.name}').join('  |  '),
              style: TextStyle(fontSize: 10, color: context.cs.onSurfaceVariant),
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
            ),
          ),
        const SizedBox(height: 6),
        Row(children: [
          // Status chip
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
            decoration: BoxDecoration(
              color: statusColor.withAlpha(20), borderRadius: BorderRadius.circular(4),
            ),
            child: Text(_statusLabel(item.status), style: TextStyle(fontSize: 10, color: statusColor, fontWeight: FontWeight.w500)),
          ),
          const Spacer(),
          // Void (only if pending)
          if (!sentToKitchen)
            GestureDetector(
              onTap: onVoid,
              child: Icon(Icons.delete_outline_rounded, size: 18, color: context.cs.error),
            ),
          const SizedBox(width: 8),
          // Qty controls
          _RoundBtn(icon: Icons.remove, onTap: !sentToKitchen ? onDecrement : null),
          SizedBox(width: 32, child: Center(child: Text('${item.quantity}',
            style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w700)))),
          _RoundBtn(icon: Icons.add, onTap: onIncrement),
        ]),
      ]),
    );
  }

  String _statusLabel(OrderItemStatus s) => switch (s) {
    OrderItemStatus.pending   => 'Not sent',
    OrderItemStatus.sent      => 'In kitchen',
    OrderItemStatus.preparing => 'Preparing',
    OrderItemStatus.ready     => 'Ready',
    OrderItemStatus.served    => 'Served',
  };
}

class _VoidedItemRow extends StatelessWidget {
  const _VoidedItemRow({required this.item});
  final OrderItemEntity item;
  @override
  Widget build(BuildContext context) => Container(
    margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 2),
    padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 7),
    decoration: BoxDecoration(
      color: Colors.red.withAlpha(8),
      borderRadius: BorderRadius.circular(8),
      border: Border.all(color: Colors.red.withAlpha(40), width: 0.5),
    ),
    child: Row(children: [
      const Icon(Icons.cancel_outlined, size: 14, color: Colors.red),
      const SizedBox(width: 6),
      Expanded(child: Text('${item.quantity}x ${item.menuItem.name}',
        style: const TextStyle(fontSize: 12, color: Colors.red, decoration: TextDecoration.lineThrough))),
      const Text('VOID', style: TextStyle(fontSize: 10, color: Colors.red, fontWeight: FontWeight.w700)),
    ]),
  );
}

class _SummaryRow extends StatelessWidget {
  const _SummaryRow(this.label, this.amount, this.sym, {this.color});
  final String label, sym; final double amount; final Color? color;
  @override
  Widget build(BuildContext context) => Padding(
    padding: const EdgeInsets.symmetric(vertical: 2),
    child: Row(children: [
      Text(label, style: TextStyle(fontSize: 13, color: context.cs.onSurfaceVariant)),
      const Spacer(),
      Text('${amount < 0 ? '-' : ''}$sym ${amount.abs().toStringAsFixed(0)}',
        style: TextStyle(fontSize: 13, fontWeight: FontWeight.w500, color: color)),
    ]),
  );
}

// ── Item customization sheet ──────────────────────────
class _ItemCustomizationSheet extends StatefulWidget {
  const _ItemCustomizationSheet({required this.item, required this.onConfirm});
  final MenuItemEntity item;
  final void Function(int qty, String notes, List<OrderModifier> mods) onConfirm;
  @override State<_ItemCustomizationSheet> createState() => _ItemCustomizationSheetState();
}

class _ItemCustomizationSheetState extends State<_ItemCustomizationSheet> {
  int _qty = 1;
  final _notes = TextEditingController();
  final _selectedMods = <String>{};

  static const _presets = [
    'Extra spicy', 'Less spicy', 'No spice', 'Extra sauce',
    'No onion', 'No garlic', 'Extra cheese', 'No salt', 'Well done',
  ];

  @override void dispose() { _notes.dispose(); super.dispose(); }

  @override
  Widget build(BuildContext context) {
    final cs = context.cs;
    return Padding(
      padding: EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
      child: Container(
        padding: const EdgeInsets.fromLTRB(20, 16, 20, 24),
        child: Column(mainAxisSize: MainAxisSize.min, crossAxisAlignment: CrossAxisAlignment.start, children: [
          // Handle
          Center(child: Container(width: 40, height: 4, decoration: BoxDecoration(color: context.border, borderRadius: BorderRadius.circular(2)))),
          const SizedBox(height: 14),
          Row(children: [
            Expanded(child: Text(widget.item.name, style: const TextStyle(fontSize: 18, fontWeight: FontWeight.w700))),
            Consumer(builder: (_, ref, __) {
              final sym = ref.watch(settingsProvider).currencySymbol;
              return Text('$sym ${widget.item.price.toStringAsFixed(0)}',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.w700, color: cs.primary));
            }),
          ]),
          const SizedBox(height: 16),
          // Qty
          Row(children: [
            const Text('Quantity:', style: TextStyle(fontWeight: FontWeight.w600)),
            const Spacer(),
            _RoundBtn(icon: Icons.remove, onTap: _qty > 1 ? () => setState(() => _qty--) : null),
            SizedBox(width: 44, child: Center(child: Text('$_qty', style: const TextStyle(fontSize: 22, fontWeight: FontWeight.w800)))),
            _RoundBtn(icon: Icons.add, onTap: () => setState(() => _qty++)),
          ]),
          const SizedBox(height: 14),
          // Presets
          const Text('Special instructions:', style: TextStyle(fontWeight: FontWeight.w600)),
          const SizedBox(height: 8),
          Wrap(spacing: 6, runSpacing: 6, children: _presets.map((p) {
            final sel = _selectedMods.contains(p);
            return FilterChip(
              label: Text(p),
              selected: sel,
              onSelected: (v) {
                setState(() {
                  if (v) { _selectedMods.add(p); _notes.text = (_notes.text.isEmpty ? p : '${_notes.text}, $p'); }
                  else   { _selectedMods.remove(p); }
                });
              },
              backgroundColor: sel ? cs.primary.withAlpha(15) : null,
              selectedColor: cs.primary.withAlpha(20),
              checkmarkColor: cs.primary,
              side: BorderSide(color: sel ? cs.primary : context.border, width: sel ? 1.5 : 0.5),
              labelStyle: TextStyle(color: sel ? cs.primary : null, fontSize: 12),
            );
          }).toList()),
          const SizedBox(height: 10),
          TextField(
            controller: _notes, maxLines: 2,
            decoration: const InputDecoration(hintText: 'Custom instructions...', prefixIcon: Icon(Icons.edit_note, size: 18)),
          ),
          const SizedBox(height: 14),
          Row(children: [
            Expanded(child: OutlinedButton(onPressed: () => Navigator.pop(context), child: const Text('Cancel'))),
            const SizedBox(width: 10),
            Expanded(flex: 2, child: FilledButton(
              onPressed: () {
                widget.onConfirm(_qty, _notes.text.trim(), []);
                Navigator.pop(context);
              },
              child: Text('Add $_qty to order'),
            )),
          ]),
        ]),
      ),
    );
  }
}

// ── Payment Dialog ────────────────────────────────────
class _PaymentDialog extends ConsumerStatefulWidget {
  const _PaymentDialog({required this.order, required this.onPay});
  final OrderEntity order;
  final void Function(PaymentMethod, double, List<PaymentSplit>, String? custName, String? custPhone) onPay;
  @override ConsumerState<_PaymentDialog> createState() => _PaymentDialogState();
}

class _PaymentDialogState extends ConsumerState<_PaymentDialog> {
  PaymentMethod _method = PaymentMethod.cash;
  final _cashCtrl = TextEditingController();
  final _custNameCtrl = TextEditingController();
  final _custPhoneCtrl = TextEditingController();
  double _cashIn = 0;

  @override
  void initState() {
    super.initState();
    _cashIn = widget.order.grandTotal;
    _cashCtrl.text = widget.order.grandTotal.toStringAsFixed(0);
  }

  @override void dispose() {
    _cashCtrl.dispose();
    _custNameCtrl.dispose();
    _custPhoneCtrl.dispose();
    super.dispose();
  }

  double get _change => _cashIn - widget.order.grandTotal;
  bool get _sufficient => _cashIn >= widget.order.grandTotal;

  @override
  Widget build(BuildContext context) {
    final settings = ref.watch(settingsProvider);
    final sym = settings.currencySymbol;
    final cs = context.cs;
    final total = widget.order.grandTotal;

    return Dialog(child: Container(
      width: 480,
      padding: const EdgeInsets.all(24),
      child: Column(mainAxisSize: MainAxisSize.min, crossAxisAlignment: CrossAxisAlignment.start, children: [
        Row(children: [
          const Icon(Icons.payment_rounded, size: 24),
          const SizedBox(width: 10),
          Text('Payment', style: Theme.of(context).textTheme.headlineSmall?.copyWith(fontWeight: FontWeight.w700)),
          const Spacer(),
          IconButton(icon: const Icon(Icons.close), onPressed: () => Navigator.pop(context)),
        ]),
        const SizedBox(height: 4),
        Text('Order #${widget.order.orderNumber} · ${widget.order.tableName}',
          style: TextStyle(color: cs.onSurfaceVariant, fontSize: 13)),
        const SizedBox(height: 20),
        // Amount due
        Container(
          width: double.infinity,
          padding: const EdgeInsets.symmetric(vertical: 16),
          decoration: BoxDecoration(
            color: cs.primary.withAlpha(12),
            borderRadius: BorderRadius.circular(12),
            border: Border.all(color: cs.primary.withAlpha(40)),
          ),
          child: Column(children: [
            Text('Amount Due', style: TextStyle(fontSize: 12, color: cs.onSurfaceVariant)),
            const SizedBox(height: 4),
            Text('$sym ${total.toStringAsFixed(0)}',
              style: TextStyle(fontSize: 36, fontWeight: FontWeight.w800, color: cs.primary)),
          ]),
        ),
        const SizedBox(height: 20),
        // Method selector
        Text('Payment method', style: Theme.of(context).textTheme.titleMedium?.copyWith(fontWeight: FontWeight.w600)),
        const SizedBox(height: 10),
        Wrap(spacing: 8, runSpacing: 8, children: PaymentMethod.values.map((m) {
          final sel = m == _method;
          return GestureDetector(
            onTap: () => setState(() => _method = m),
            child: AnimatedContainer(
              duration: const Duration(milliseconds: 150),
              padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
              decoration: BoxDecoration(
                color: sel ? cs.primary : context.elevated,
                borderRadius: BorderRadius.circular(10),
                border: Border.all(color: sel ? cs.primary : context.border, width: sel ? 2 : 0.5),
              ),
              child: Row(mainAxisSize: MainAxisSize.min, children: [
                Icon(_mIcon(m), size: 16, color: sel ? Colors.white : cs.onSurface),
                const SizedBox(width: 6),
                Text(_mLabel(m), style: TextStyle(color: sel ? Colors.white : cs.onSurface, fontWeight: FontWeight.w500, fontSize: 13)),
              ]),
            ),
          );
        }).toList()),
        const SizedBox(height: 16),
        // Cash input
        if (_method == PaymentMethod.cash) ...[
          Text('Cash received', style: Theme.of(context).textTheme.titleMedium?.copyWith(fontWeight: FontWeight.w600)),
          const SizedBox(height: 8),
          TextField(
            controller: _cashCtrl,
            keyboardType: const TextInputType.numberWithOptions(decimal: true),
            inputFormatters: [FilteringTextInputFormatter.allow(RegExp(r'[\d.]'))],
            onChanged: (v) => setState(() => _cashIn = double.tryParse(v) ?? 0),
            decoration: InputDecoration(
              prefixText: '$sym ',
              suffixIcon: _change > 0 ? Padding(
                padding: const EdgeInsets.only(right: 12),
                child: Text('Change: $sym ${_change.toStringAsFixed(0)}',
                  style: const TextStyle(color: Colors.green, fontWeight: FontWeight.w600, fontSize: 13)),
              ) : null,
              suffixIconConstraints: const BoxConstraints(minWidth: 0),
            ),
          ),
          const SizedBox(height: 8),
          // Quick cash amounts
          Wrap(spacing: 8, children: _quickAmounts(total).map((a) =>
            OutlinedButton(
              onPressed: () => setState(() { _cashIn = a; _cashCtrl.text = a.toStringAsFixed(0); }),
              style: OutlinedButton.styleFrom(padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8)),
              child: Text('$sym ${a.toStringAsFixed(0)}', style: const TextStyle(fontSize: 12)),
            ),
          ).toList()),
        ],
        if (_method == PaymentMethod.credit) ...[
          const SizedBox(height: 16),
          Text('Customer Details (Credit)', style: Theme.of(context).textTheme.titleMedium?.copyWith(fontWeight: FontWeight.w600)),
          const SizedBox(height: 8),
          TextField(
            controller: _custNameCtrl,
            textCapitalization: TextCapitalization.words,
            decoration: const InputDecoration(
              labelText: 'Customer Name *',
              prefixIcon: Icon(Icons.person_outline),
            ),
            onChanged: (_) => setState(() {}),
          ),
          const SizedBox(height: 12),
          TextField(
            controller: _custPhoneCtrl,
            keyboardType: TextInputType.phone,
            decoration: const InputDecoration(
              labelText: 'Phone Number *',
              prefixIcon: Icon(Icons.phone_outlined),
            ),
            onChanged: (_) => setState(() {}),
          ),
        ],
        const SizedBox(height: 24),
        // Order summary
        Container(
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(color: context.elevated, borderRadius: BorderRadius.circular(10)),
          child: Column(children: [
            if (widget.order.discountValue > 0)
              Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
                const Text('Discount:', style: TextStyle(fontSize: 12)),
                Text('-$sym ${widget.order.discountValue.toStringAsFixed(0)}', style: const TextStyle(fontSize: 12, color: Colors.green)),
              ]),
            if (widget.order.taxValue > 0)
              Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
                Text('GST (${widget.order.taxPercent.toStringAsFixed(0)}%):', style: const TextStyle(fontSize: 12)),
                Text('$sym ${widget.order.taxValue.toStringAsFixed(0)}', style: const TextStyle(fontSize: 12)),
              ]),
          ]),
        ),
        const SizedBox(height: 20),
        Row(children: [
          Expanded(child: OutlinedButton(onPressed: () => Navigator.pop(context), child: const Text('Cancel'))),
          const SizedBox(width: 12),
          Expanded(flex: 2, child: FilledButton.icon(
            icon: const Icon(Icons.check_circle_rounded, size: 18),
            label: const Text('Confirm Payment', style: TextStyle(fontSize: 15, fontWeight: FontWeight.w700)),
            onPressed: (_method == PaymentMethod.cash && !_sufficient) ||
                       (_method == PaymentMethod.credit && (_custNameCtrl.text.trim().isEmpty || _custPhoneCtrl.text.trim().isEmpty))
                      ? null
                      : () => widget.onPay(
                          _method,
                          _method == PaymentMethod.cash ? _cashIn : total,
                          [],
                          _method == PaymentMethod.credit ? _custNameCtrl.text.trim() : null,
                          _method == PaymentMethod.credit ? _custPhoneCtrl.text.trim() : null,
                        ),
            style: FilledButton.styleFrom(padding: const EdgeInsets.symmetric(vertical: 14)),
          )),
        ]),
      ]),
    ));
  }

  List<double> _quickAmounts(double total) {
    final r = (total / 100).ceil() * 100.0;
    return [total, r, r + 100, r + 500].toSet().toList()..sort();
  }

  IconData _mIcon(PaymentMethod m) => switch (m) {
    PaymentMethod.cash   => Icons.payments_rounded,
    PaymentMethod.card   => Icons.credit_card_rounded,
    PaymentMethod.bank   => Icons.account_balance_rounded,
    PaymentMethod.wallet => Icons.account_balance_wallet_rounded,
    PaymentMethod.credit => Icons.person_rounded,
    PaymentMethod.split  => Icons.call_split_rounded,
  };

  String _mLabel(PaymentMethod m) => switch (m) {
    PaymentMethod.cash   => 'Cash',
    PaymentMethod.card   => 'Card',
    PaymentMethod.bank   => 'Bank',
    PaymentMethod.wallet => 'Wallet',
    PaymentMethod.credit => 'Credit',
    PaymentMethod.split  => 'Split',
  };
}

// ═══════════════════════════════════════════════════════
// KITCHEN SCREEN
// ═══════════════════════════════════════════════════════

part of 'main.dart';

class KitchenScreen extends ConsumerStatefulWidget {
  const KitchenScreen({super.key});
  @override ConsumerState<KitchenScreen> createState() => _KitchenScreenState();
}

class _KitchenScreenState extends ConsumerState<KitchenScreen> {
  Timer? _timer;

  @override
  void initState() {
    super.initState();
    // Auto-refresh every 15 seconds
    _timer = Timer.periodic(const Duration(seconds: 15),
        (_) => ref.read(kitchenProvider.notifier).refresh());
  }

  @override void dispose() { _timer?.cancel(); super.dispose(); }

  @override
  Widget build(BuildContext context) {
    final orders = ref.watch(kitchenProvider);
    final isDark = context.isDark;

    final pending   = orders.where((o) => o.status == OrderStatus.kitchenSent).toList();
    final preparing = orders.where((o) => o.items.any((i) => i.status == OrderItemStatus.preparing)).toList();
    final ready     = orders.where((o) => o.status == OrderStatus.ready).toList();

    return SideNav(child: Scaffold(
      appBar: AppBar(
        leading: IconButton(icon: const Icon(Icons.arrow_back), onPressed: () => context.go('/dashboard')),
        title: const Text('Kitchen Display'),
        actions: [
          _KitchenClock(),
          const SizedBox(width: 12),
          _PulseDot(),
          const Padding(padding: EdgeInsets.only(right: 16), child: Text('LIVE', style: TextStyle(fontWeight: FontWeight.w700, fontSize: 12, color: Colors.green))),
          IconButton(icon: const Icon(Icons.refresh_rounded), tooltip: 'Refresh',
              onPressed: () => ref.read(kitchenProvider.notifier).refresh()),
          const SizedBox(width: 8),
        ],
      ),
      body: orders.isEmpty
          ? Center(child: Column(mainAxisSize: MainAxisSize.min, children: [
              Icon(Icons.kitchen_rounded, size: 80, color: context.cs.onSurfaceVariant.withAlpha(60)),
              const SizedBox(height: 16),
              Text('Kitchen is clear — no pending orders', style: TextStyle(color: context.cs.onSurfaceVariant, fontSize: 16)),
            ]))
          : Row(children: [
              _KitchenColumn(title: 'New Orders', color: AppColors.orderOpen, icon: Icons.fiber_new_rounded, orders: pending, ref: ref, context: context),
              _KitchenColumn(title: 'Preparing', color: AppColors.orderKitchen, icon: Icons.outdoor_grill_rounded, orders: preparing, ref: ref, context: context),
              _KitchenColumn(title: 'Ready to Serve', color: AppColors.orderReady, icon: Icons.check_circle_rounded, orders: ready, ref: ref, context: context),
            ]),
    ));
  }
}

class _KitchenClock extends StatefulWidget {
  @override State<_KitchenClock> createState() => _KitchenClockState();
}
class _KitchenClockState extends State<_KitchenClock> {
  late Timer _t;
  @override void initState() { super.initState(); _t = Timer.periodic(const Duration(seconds: 1), (_) => setState(() {})); }
  @override void dispose() { _t.cancel(); super.dispose(); }
  @override Widget build(BuildContext context) => Text(
    DateFormat('HH:mm:ss').format(DateTime.now()),
    style: const TextStyle(fontWeight: FontWeight.w700, fontSize: 18, fontFeatures: [FontFeature.tabularFigures()]),
  );
}

class _PulseDot extends StatefulWidget {
  @override State<_PulseDot> createState() => _PulseDotState();
}
class _PulseDotState extends State<_PulseDot> with SingleTickerProviderStateMixin {
  late final AnimationController _c;
  @override void initState() { super.initState(); _c = AnimationController(vsync: this, duration: const Duration(seconds: 1))..repeat(reverse: true); }
  @override void dispose() { _c.dispose(); super.dispose(); }
  @override Widget build(BuildContext context) => FadeTransition(
    opacity: Tween(begin: 0.3, end: 1.0).animate(_c),
    child: Container(width: 8, height: 8, margin: const EdgeInsets.only(right: 4), decoration: const BoxDecoration(color: Colors.green, shape: BoxShape.circle)),
  );
}

class _KitchenColumn extends StatelessWidget {
  const _KitchenColumn({required this.title, required this.color, required this.icon, required this.orders, required this.ref, required this.context});
  final String title; final Color color; final IconData icon;
  final List<OrderEntity> orders; final WidgetRef ref; final BuildContext context;

  @override
  Widget build(BuildContext innerContext) => Expanded(child: Column(children: [
    Container(
      height: 48, margin: const EdgeInsets.all(10),
      decoration: BoxDecoration(color: color.withAlpha(20), borderRadius: BorderRadius.circular(10), border: Border.all(color: color.withAlpha(70))),
      child: Row(mainAxisAlignment: MainAxisAlignment.center, children: [
        Icon(icon, color: color, size: 18),
        const SizedBox(width: 8),
        Text(title, style: TextStyle(color: color, fontWeight: FontWeight.w700, fontSize: 14)),
        if (orders.isNotEmpty) ...[
          const SizedBox(width: 8),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
            decoration: BoxDecoration(color: color, borderRadius: BorderRadius.circular(10)),
            child: Text('${orders.length}', style: const TextStyle(color: Colors.white, fontSize: 12, fontWeight: FontWeight.w800)),
          ),
        ],
      ]),
    ),
    Expanded(child: ListView.builder(
      padding: const EdgeInsets.fromLTRB(10, 0, 10, 10),
      itemCount: orders.length,
      itemBuilder: (_, i) => _KitchenCard(order: orders[i], accentColor: color, ref: ref)
          .animate(delay: Duration(milliseconds: i * 40)).fadeIn().slideY(begin: 0.05),
    )),
  ]));
}

class _KitchenCard extends StatefulWidget {
  const _KitchenCard({required this.order, required this.accentColor, required this.ref});
  final OrderEntity order; final Color accentColor; final WidgetRef ref;
  @override State<_KitchenCard> createState() => _KitchenCardState();
}
class _KitchenCardState extends State<_KitchenCard> {
  late Timer _t;
  late Duration _elapsed;
  bool _urgent = false;

  @override
  void initState() {
    super.initState();
    _elapsed = DateTime.now().difference(widget.order.createdAt);
    _urgent = _elapsed.inMinutes >= 20;
    _t = Timer.periodic(const Duration(seconds: 1), (_) {
      if (mounted) setState(() { _elapsed = DateTime.now().difference(widget.order.createdAt); _urgent = _elapsed.inMinutes >= 20; });
    });
  }
  @override void dispose() { _t.cancel(); super.dispose(); }

  String get _timeStr {
    final m = _elapsed.inMinutes; final s = _elapsed.inSeconds % 60;
    return '${m.toString().padLeft(2,'0')}:${s.toString().padLeft(2,'0')}';
  }

  @override
  Widget build(BuildContext context) {
    final o = widget.order;
    final isDark = context.isDark;
    final color = _urgent ? Colors.red : widget.accentColor;

    return AnimatedContainer(
      duration: const Duration(milliseconds: 400),
      margin: const EdgeInsets.only(bottom: 10),
      decoration: BoxDecoration(
        color: isDark ? AppColors.darkCard : Colors.white,
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: _urgent ? Colors.red.withAlpha(180) : color.withAlpha(80), width: _urgent ? 2 : 1),
        boxShadow: _urgent ? [BoxShadow(color: Colors.red.withAlpha(50), blurRadius: 10, spreadRadius: 1)] : null,
      ),
      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        // Card header
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
          decoration: BoxDecoration(
            color: color.withAlpha(isDark ? 25 : 18),
            borderRadius: const BorderRadius.vertical(top: Radius.circular(13)),
          ),
          child: Row(children: [
            Text('#${o.orderNumber}', style: TextStyle(color: color, fontWeight: FontWeight.w800, fontSize: 15)),
            const SizedBox(width: 8),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
              decoration: BoxDecoration(color: color.withAlpha(25), borderRadius: BorderRadius.circular(6)),
              child: Text(o.tableName, style: TextStyle(color: color, fontSize: 12, fontWeight: FontWeight.w700)),
            ),
            const Spacer(),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
              decoration: BoxDecoration(
                color: _urgent ? Colors.red.withAlpha(20) : Colors.transparent,
                borderRadius: BorderRadius.circular(6),
              ),
              child: Row(children: [
                Icon(Icons.timer_rounded, size: 14, color: _urgent ? Colors.red : color),
                const SizedBox(width: 4),
                Text(_timeStr, style: TextStyle(
                  color: _urgent ? Colors.red : color, fontWeight: FontWeight.w700, fontSize: 14,
                  fontFeatures: const [FontFeature.tabularFigures()],
                )),
              ]),
            ),
          ]),
        ),
        // Waiter + guests
        Padding(
          padding: const EdgeInsets.fromLTRB(12, 8, 12, 0),
          child: Row(children: [
            Icon(Icons.person_outline, size: 13, color: context.cs.onSurfaceVariant),
            const SizedBox(width: 4),
            Text(o.waiterName, style: TextStyle(fontSize: 11, color: context.cs.onSurfaceVariant)),
            const SizedBox(width: 12),
            Icon(Icons.group_outlined, size: 13, color: context.cs.onSurfaceVariant),
            const SizedBox(width: 4),
            Text('${o.guestCount} guests', style: TextStyle(fontSize: 11, color: context.cs.onSurfaceVariant)),
          ]),
        ),
        // Items
        Padding(
          padding: const EdgeInsets.fromLTRB(12, 8, 12, 0),
          child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            ...o.items.where((i) => !i.isVoided && i.status != OrderItemStatus.served).map((item) => Padding(
              padding: const EdgeInsets.only(bottom: 8),
              child: Row(crossAxisAlignment: CrossAxisAlignment.start, children: [
                Container(
                  width: 30, height: 30,
                  decoration: BoxDecoration(
                    color: color.withAlpha(25), borderRadius: BorderRadius.circular(6),
                    border: Border.all(color: color.withAlpha(60)),
                  ),
                  child: Center(child: Text('×${item.quantity}', style: TextStyle(color: color, fontWeight: FontWeight.w800, fontSize: 12))),
                ),
                const SizedBox(width: 10),
                Expanded(child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                  Text(item.menuItem.name, style: const TextStyle(fontWeight: FontWeight.w700, fontSize: 13)),
                  if (item.notes.isNotEmpty)
                    Container(
                      margin: const EdgeInsets.only(top: 3),
                      padding: const EdgeInsets.fromLTRB(6, 3, 6, 3),
                      decoration: BoxDecoration(
                        color: Colors.orange.withAlpha(18), borderRadius: BorderRadius.circular(4),
                        border: Border(left: const BorderSide(color: Colors.orange, width: 3)),
                      ),
                      child: Text('⚠ ${item.notes}', style: const TextStyle(fontSize: 11, color: Colors.orange, fontWeight: FontWeight.w500)),
                    ),
                ])),
                // Item status toggle
                GestureDetector(
                  onTap: () {
                    if (item.status == OrderItemStatus.sent) {
                      widget.ref.read(kitchenProvider.notifier).markItemPreparing(item.id);
                    } else if (item.status == OrderItemStatus.preparing) {
                      widget.ref.read(kitchenProvider.notifier).markItemReady(item.id);
                    }
                  },
                  child: Container(
                    padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 3),
                    decoration: BoxDecoration(
                      color: _itemStatusColor(item.status).withAlpha(20), borderRadius: BorderRadius.circular(5),
                      border: Border.all(color: _itemStatusColor(item.status).withAlpha(60)),
                    ),
                    child: Text(_itemStatusLabel(item.status), style: TextStyle(fontSize: 10, color: _itemStatusColor(item.status), fontWeight: FontWeight.w600)),
                  ),
                ),
              ]),
            )),
          ]),
        ),
        // Order note
        if (o.notes.isNotEmpty)
          Container(
            margin: const EdgeInsets.fromLTRB(12, 4, 12, 0),
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: Colors.amber.withAlpha(20), borderRadius: BorderRadius.circular(8),
              border: Border.all(color: Colors.amber.withAlpha(80)),
            ),
            child: Row(children: [
              const Icon(Icons.info_outline, size: 14, color: Colors.amber),
              const SizedBox(width: 6),
              Expanded(child: Text(o.notes, style: const TextStyle(fontSize: 11, color: Colors.amber))),
            ]),
          ),
        // Actions
        Padding(
          padding: const EdgeInsets.all(10),
          child: Row(children: [
            Expanded(child: FilledButton.icon(
              icon: const Icon(Icons.check_circle_rounded, size: 16),
              label: const Text('Order Ready', style: TextStyle(fontSize: 12)),
              onPressed: () => widget.ref.read(kitchenProvider.notifier).markOrderReady(o.id),
              style: FilledButton.styleFrom(backgroundColor: AppColors.orderReady, padding: const EdgeInsets.symmetric(vertical: 10)),
            )),
          ]),
        ),
      ]),
    );
  }

  Color _itemStatusColor(OrderItemStatus s) => switch (s) {
    OrderItemStatus.pending   => AppColors.orderOpen,
    OrderItemStatus.sent      => AppColors.orderKitchen,
    OrderItemStatus.preparing => Colors.purple,
    OrderItemStatus.ready     => AppColors.orderReady,
    OrderItemStatus.served    => Colors.grey,
  };

  String _itemStatusLabel(OrderItemStatus s) => switch (s) {
    OrderItemStatus.pending   => 'Not sent',
    OrderItemStatus.sent      => 'Tap → Prep',
    OrderItemStatus.preparing => 'Tap → Done',
    OrderItemStatus.ready     => 'Ready ✓',
    OrderItemStatus.served    => 'Served',
  };
}

// ═══════════════════════════════════════════════════════
// MENU MANAGEMENT SCREEN
// ═══════════════════════════════════════════════════════
class MenuManagementScreen extends ConsumerStatefulWidget {
  const MenuManagementScreen({super.key});
  @override ConsumerState<MenuManagementScreen> createState() => _MenuManagementScreenState();
}

class _MenuManagementScreenState extends ConsumerState<MenuManagementScreen> {
  int? _selectedGroupId;
  List<MenuGroupEntity> _groups = [];

  @override
  void initState() {
    super.initState();
    _loadGroups();
  }

  Future<void> _loadGroups() async {
    final rows = await ref.read(dbProvider).menuDao.getGroups();
    if (mounted) setState(() {
      _groups = rows.map((r) => MenuGroupEntity(id: r.id, name: r.name, iconPath: r.iconPath, colorHex: r.colorHex, sortOrder: r.sortOrder)).toList();
      if (rows.isNotEmpty && _selectedGroupId == null) _selectedGroupId = rows.first.id;
    });
  }

  Color _hexColor(String hex) {
    try { return Color(int.parse(hex.replaceFirst('#', 'FF'), radix: 16)); }
    catch (_) { return const Color(0xFF1A56DB); }
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: SideNav(child: Scaffold(
        appBar: AppBar(
          leading: IconButton(icon: const Icon(Icons.arrow_back), onPressed: () => context.go('/dashboard')),
          title: const Text('Menu Management'),
          bottom: const TabBar(
            tabs: [
              Tab(text: 'Categories & Items'),
              Tab(text: 'Deals'),
            ],
          ),
        ),
        body: TabBarView(
          children: [
            // Tab 1: Categories & Items (Original)
            Scaffold(
              appBar: AppBar(
                automaticallyImplyLeading: false,
                title: const Text('Menu Categories & Items', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
                actions: [
                  FilledButton.icon(
                    icon: const Icon(Icons.add, size: 16),
                    label: const Text('Add Group'),
                    onPressed: _showAddGroupDialog,
                  ),
                  const SizedBox(width: 8),
                  if (_selectedGroupId != null)
                    OutlinedButton.icon(
                      icon: const Icon(Icons.add, size: 16),
                      label: const Text('Add Item'),
                      onPressed: _showAddItemDialog,
                    ),
                  const SizedBox(width: 12),
                ],
              ),
              body: Row(children: [
                // Groups sidebar
                SizedBox(
                  width: 220,
                  child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                    Padding(
                      padding: const EdgeInsets.all(12),
                      child: Text('Groups', style: Theme.of(context).textTheme.titleSmall?.copyWith(color: context.cs.onSurfaceVariant, fontWeight: FontWeight.w600)),
                    ),
                    Expanded(child: ListView.builder(
                      padding: const EdgeInsets.symmetric(horizontal: 8),
                      itemCount: _groups.length,
                      itemBuilder: (_, i) {
                        final g = _groups[i];
                        final sel = g.id == _selectedGroupId;
                        final color = _hexColor(g.colorHex);
                        return GestureDetector(
                          onTap: () => setState(() => _selectedGroupId = g.id),
                          child: AnimatedContainer(
                            duration: const Duration(milliseconds: 200),
                            margin: const EdgeInsets.only(bottom: 4),
                            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
                            decoration: BoxDecoration(
                              color: sel ? color.withAlpha(20) : Colors.transparent,
                              borderRadius: BorderRadius.circular(10),
                              border: Border.all(color: sel ? color : Colors.transparent),
                            ),
                            child: Row(children: [
                              Container(
                                width: 36, height: 36,
                                decoration: BoxDecoration(color: color.withAlpha(25), borderRadius: BorderRadius.circular(8)),
                                child: g.iconPath.isNotEmpty
                                  ? ClipRRect(
                                      borderRadius: BorderRadius.circular(8),
                                      child: Image.file(File(AppPaths.resolve(g.iconPath)), fit: BoxFit.cover,
                                        errorBuilder: (_, __, ___) => Icon(Icons.restaurant_menu, color: color, size: 20)),
                                    )
                                  : Icon(Icons.restaurant_menu, color: color, size: 20),
                              ),
                              const SizedBox(width: 10),
                              Expanded(child: Text(g.name, style: TextStyle(fontWeight: sel ? FontWeight.w700 : FontWeight.w500, color: sel ? color : null, fontSize: 13))),
                              PopupMenuButton(
                                iconSize: 18,
                                padding: EdgeInsets.zero,
                                itemBuilder: (_) => [
                                  const PopupMenuItem(value: 'edit', child: Text('Edit group')),
                                  PopupMenuItem(value: 'delete', child: Text('Delete', style: TextStyle(color: Colors.red))),
                                ],
                                onSelected: (v) async {
                                  if (v == 'edit') _showEditGroupDialog(g);
                                  if (v == 'delete') {
                                    final ok = await confirm(context, 'Delete group?', 'This will remove the group and all its items.', danger: true);
                                    if (ok) {
                                      await ref.read(dbProvider).menuDao.deleteGroup(g.id);
                                      await _loadGroups();
                                    }
                                  }
                                },
                              ),
                            ]),
                          ),
                        );
                      },
                    )),
                  ]),
                ),
                // Vertical divider
                VerticalDivider(width: 1, color: context.border),
                // Items grid
                Expanded(
                  child: _selectedGroupId == null
                    ? const Center(child: Text('Select or create a group'))
                    : Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                        Padding(
                          padding: const EdgeInsets.fromLTRB(16, 14, 16, 8),
                          child: Row(children: [
                            Text('Items in ${_groups.firstWhere((g) => g.id == _selectedGroupId, orElse: () => _groups.first).name}',
                              style: Theme.of(context).textTheme.titleMedium?.copyWith(fontWeight: FontWeight.w700)),
                            const Spacer(),
                            Text('Add real food photos from your device for best results',
                              style: TextStyle(fontSize: 11, color: context.cs.onSurfaceVariant, fontStyle: FontStyle.italic)),
                          ]),
                        ),
                        Expanded(child: _MenuItemsGrid(groupId: _selectedGroupId!, onEdit: _showEditItemDialog)),
                      ]),
                ),
              ]),
            ),
            // Tab 2: Deals
            const _DealsManagementTab(),
          ],
        ),
      )),
    );
  }

  void _showAddGroupDialog() {
    final nameCtrl = TextEditingController();
    String color = '#1A56DB';
    String iconPath = '';
    showDialog(context: context, builder: (_) => StatefulBuilder(builder: (ctx, ss) => AlertDialog(
      title: const Text('Add menu group'),
      content: SizedBox(width: 380, child: Column(mainAxisSize: MainAxisSize.min, children: [
        TextField(controller: nameCtrl, autofocus: true, decoration: const InputDecoration(labelText: 'Group name (e.g. Karahi, Biryani)')),
        const SizedBox(height: 12),
        // Color picker
        const Text('Group color:', style: TextStyle(fontWeight: FontWeight.w600, fontSize: 13)),
        const SizedBox(height: 8),
        Wrap(spacing: 8, children: ['#E74C3C','#2ECC71','#3498DB','#E67E22','#9B59B6','#1ABC9C','#F39C12','#E91E63','#00BCD4','#FF5722'].map((c) =>
          GestureDetector(
            onTap: () => ss(() => color = c),
            child: Container(
              width: 30, height: 30,
              decoration: BoxDecoration(
                color: Color(int.parse(c.replaceFirst('#','FF'), radix: 16)),
                shape: BoxShape.circle,
                border: color == c ? Border.all(color: Colors.white, width: 3) : null,
                boxShadow: color == c ? [const BoxShadow(color: Colors.black26, blurRadius: 4)] : null,
              ),
            ),
          ),
        ).toList()),
        const SizedBox(height: 12),
        // Icon/Image picker
        OutlinedButton.icon(
          icon: const Icon(Icons.image_outlined, size: 16),
          label: Text(iconPath.isEmpty ? 'Pick group image (optional)' : 'Image selected ✓'),
          onPressed: () async {
            final img = await ImagePicker().pickImage(source: ImageSource.gallery);
            if (img != null) {
              final savedPath = await AppPaths.copyToMedia(img.path, prefix: 'group');
              ss(() => iconPath = savedPath);
            }
          },
        ),
      ])),
      actions: [
        TextButton(onPressed: () => Navigator.pop(ctx), child: const Text('Cancel')),
        FilledButton(
          onPressed: () async {
            if (nameCtrl.text.isEmpty) return;
            await ref.read(dbProvider).menuDao.insertGroup(MenuGroupsCompanion.insert(
              name: nameCtrl.text, colorHex: Value(color), iconPath: Value(iconPath),
              sortOrder: Value(_groups.length),
            ));
            Navigator.pop(ctx);
            await _loadGroups();
          },
          child: const Text('Add group'),
        ),
      ],
    )));
  }

  void _showEditGroupDialog(MenuGroupEntity g) {
    final nameCtrl = TextEditingController(text: g.name);
    String color = g.colorHex;
    String iconPath = g.iconPath;
    showDialog(context: context, builder: (_) => StatefulBuilder(builder: (ctx, ss) => AlertDialog(
      title: Text('Edit ${g.name}'),
      content: SizedBox(width: 380, child: Column(mainAxisSize: MainAxisSize.min, children: [
        TextField(controller: nameCtrl, decoration: const InputDecoration(labelText: 'Group name')),
        const SizedBox(height: 12),
        Wrap(spacing: 8, children: ['#E74C3C','#2ECC71','#3498DB','#E67E22','#9B59B6','#1ABC9C','#F39C12','#E91E63','#00BCD4','#FF5722'].map((c) =>
          GestureDetector(onTap: () => ss(() => color = c), child: Container(
            width: 28, height: 28,
            decoration: BoxDecoration(
              color: Color(int.parse(c.replaceFirst('#','FF'), radix: 16)),
              shape: BoxShape.circle,
              border: color == c ? Border.all(color: Colors.white, width: 3) : null,
            ),
          )),
        ).toList()),
        const SizedBox(height: 10),
        OutlinedButton.icon(
          icon: const Icon(Icons.image, size: 16),
          label: Text(iconPath.isEmpty ? 'Pick group image' : 'Change image ✓'),
          onPressed: () async {
            final img = await ImagePicker().pickImage(source: ImageSource.gallery);
            if (img != null) {
              final savedPath = await AppPaths.copyToMedia(img.path, prefix: 'group');
              ss(() => iconPath = savedPath);
            }
          },
        ),
      ])),
      actions: [
        TextButton(onPressed: () => Navigator.pop(ctx), child: const Text('Cancel')),
        FilledButton(
          onPressed: () async {
            await ref.read(dbProvider).menuDao.updateGroup(MenuGroupsCompanion(
              id: Value(g.id), name: Value(nameCtrl.text), colorHex: Value(color), iconPath: Value(iconPath),
            ));
            Navigator.pop(ctx);
            await _loadGroups();
          },
          child: const Text('Save'),
        ),
      ],
    )));
  }

  void _showAddItemDialog() {
    if (_selectedGroupId == null) return;
    _showItemDialog(groupId: _selectedGroupId!);
  }

  void _showEditItemDialog(MenuItemEntity item) {
    _showItemDialog(existingItem: item, groupId: item.groupId);
  }

  void _showItemDialog({MenuItemEntity? existingItem, required int groupId}) {
    final nameCtrl    = TextEditingController(text: existingItem?.name);
    final priceCtrl   = TextEditingController(text: existingItem?.price.toStringAsFixed(0));
    final costCtrl    = TextEditingController(text: existingItem?.costPrice.toStringAsFixed(0));
    final descCtrl    = TextEditingController(text: existingItem?.description);
    final prepCtrl    = TextEditingController(text: existingItem?.preparationMinutes.toString() ?? '10');
    final stockCtrl   = TextEditingController(text: existingItem?.stockCount == -1 ? '' : existingItem?.stockCount.toString());
    bool isAvail      = existingItem?.isAvailable ?? true;
    bool trackStock   = existingItem?.stockCount != -1 ?? false;
    String imagePath  = existingItem?.imagePath ?? '';

    showDialog(context: context, builder: (_) => StatefulBuilder(builder: (ctx, ss) => AlertDialog(
      title: Text(existingItem == null ? 'Add menu item' : 'Edit ${existingItem.name}'),
      content: SizedBox(width: 520, child: SingleChildScrollView(child: Column(mainAxisSize: MainAxisSize.min, children: [
        // Image picker
        GestureDetector(
          onTap: () async {
            final img = await ImagePicker().pickImage(source: ImageSource.gallery, imageQuality: 80);
            if (img != null) {
              final savedPath = await AppPaths.copyToMedia(img.path, prefix: 'menu');
              ss(() => imagePath = savedPath);
            }
          },
          child: Container(
            height: 120, width: double.infinity,
            decoration: BoxDecoration(
              color: context.elevated, borderRadius: BorderRadius.circular(10),
              border: Border.all(color: context.border),
              image: imagePath.isNotEmpty ? DecorationImage(image: FileImage(File(AppPaths.resolve(imagePath))), fit: BoxFit.cover) : null,
            ),
            child: imagePath.isEmpty ? Column(mainAxisAlignment: MainAxisAlignment.center, children: [
              Icon(Icons.add_photo_alternate_rounded, size: 40, color: context.cs.onSurfaceVariant),
              const SizedBox(height: 6),
              Text('Tap to add food photo', style: TextStyle(color: context.cs.onSurfaceVariant, fontSize: 13)),
            ]) : Align(
              alignment: Alignment.bottomRight,
              child: Container(margin: const EdgeInsets.all(8), padding: const EdgeInsets.all(6),
                decoration: BoxDecoration(color: Colors.black54, borderRadius: BorderRadius.circular(6)),
                child: const Icon(Icons.edit, color: Colors.white, size: 16)),
            ),
          ),
        ),
        const SizedBox(height: 14),
        Row(children: [
          Expanded(flex: 3, child: TextField(controller: nameCtrl, decoration: const InputDecoration(labelText: 'Item name *'))),
          const SizedBox(width: 10),
          Expanded(flex: 2, child: TextField(controller: priceCtrl, keyboardType: TextInputType.number, decoration: const InputDecoration(labelText: 'Sale price *'))),
          const SizedBox(width: 10),
          Expanded(flex: 2, child: TextField(controller: costCtrl, keyboardType: TextInputType.number, decoration: const InputDecoration(labelText: 'Cost price'))),
        ]),
        const SizedBox(height: 10),
        Row(children: [
          Expanded(child: TextField(controller: prepCtrl, keyboardType: TextInputType.number, decoration: const InputDecoration(labelText: 'Prep time (mins)', prefixIcon: Icon(Icons.timer_outlined, size: 18)))),
          const SizedBox(width: 10),
          Expanded(child: TextField(controller: descCtrl, decoration: const InputDecoration(labelText: 'Description (optional)'))),
        ]),
        const SizedBox(height: 10),
        // Stock tracking
        Row(children: [
          Expanded(child: SwitchListTile(
            title: const Text('Track stock', style: TextStyle(fontSize: 13)),
            value: trackStock,
            onChanged: (v) => ss(() => trackStock = v),
            contentPadding: EdgeInsets.zero,
          )),
          if (trackStock)
            Expanded(child: TextField(controller: stockCtrl, keyboardType: TextInputType.number, decoration: const InputDecoration(labelText: 'Stock count'))),
        ]),
        Row(children: [
          Expanded(child: SwitchListTile(
            title: const Text('Available', style: TextStyle(fontSize: 13)),
            value: isAvail,
            onChanged: (v) => ss(() => isAvail = v),
            contentPadding: EdgeInsets.zero,
          )),
        ]),
      ]))),
      actions: [
        TextButton(onPressed: () => Navigator.pop(ctx), child: const Text('Cancel')),
        FilledButton(
          onPressed: () async {
            if (nameCtrl.text.isEmpty || priceCtrl.text.isEmpty) return;
            final price = double.tryParse(priceCtrl.text) ?? 0;
            final cost  = double.tryParse(costCtrl.text) ?? 0;
            final prep  = int.tryParse(prepCtrl.text) ?? 10;
            final stock = trackStock ? (int.tryParse(stockCtrl.text) ?? 0) : -1;

            if (existingItem == null) {
              await ref.read(dbProvider).menuDao.insertItem(MenuItemsCompanion.insert(
                groupId: groupId, name: nameCtrl.text, price: price,
                costPrice: Value(cost), description: Value(descCtrl.text.isEmpty ? null : descCtrl.text),
                imagePath: Value(imagePath.isEmpty ? null : imagePath),
                preparationMinutes: Value(prep), isAvailable: Value(isAvail), stockCount: Value(stock),
                sortOrder: Value(0),
              ));
            } else {
              await ref.read(dbProvider).menuDao.updateItem(MenuItemsCompanion(
                id: Value(existingItem.id), name: Value(nameCtrl.text), price: Value(price),
                costPrice: Value(cost), description: Value(descCtrl.text.isEmpty ? null : descCtrl.text),
                imagePath: Value(imagePath.isEmpty ? null : imagePath),
                preparationMinutes: Value(prep), isAvailable: Value(isAvail), stockCount: Value(stock),
              ));
            }
            Navigator.pop(ctx);
          },
          child: Text(existingItem == null ? 'Add item' : 'Save changes'),
        ),
      ],
    )));
  }
}

class _MenuItemsGrid extends ConsumerWidget {
  const _MenuItemsGrid({required this.groupId, required this.onEdit});
  final int groupId;
  final ValueChanged<MenuItemEntity> onEdit;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return FutureBuilder<List<MenuItemRow>>(
      future: ref.watch(dbProvider).menuDao.getByGroup(groupId),
      builder: (_, snap) {
        if (!snap.hasData) return const Center(child: CircularProgressIndicator());
        final rows = snap.data!;
        if (rows.isEmpty) return Center(child: Column(mainAxisSize: MainAxisSize.min, children: [
          Icon(Icons.add_circle_outline, size: 56, color: context.cs.onSurfaceVariant.withAlpha(80)),
          const SizedBox(height: 12),
          Text('No items yet — click "Add Item" to start', style: TextStyle(color: context.cs.onSurfaceVariant)),
        ]));
        return GridView.builder(
          padding: const EdgeInsets.all(14),
          gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
            maxCrossAxisExtent: 200, childAspectRatio: 0.75, crossAxisSpacing: 12, mainAxisSpacing: 12),
          itemCount: rows.length,
          itemBuilder: (_, i) {
            final r = rows[i];
            final item = mapMenuItemRow(r, '');
            return _ManageItemCard(item: item, ref: ref, onEdit: () => onEdit(item));
          },
        );
      },
    );
  }
}

class _ManageItemCard extends StatelessWidget {
  const _ManageItemCard({required this.item, required this.ref, required this.onEdit});
  final MenuItemEntity item; final WidgetRef ref; final VoidCallback onEdit;

  @override
  Widget build(BuildContext context) {
    final settings = ref.watch(settingsProvider);
    return AppCard(
      padding: EdgeInsets.zero,
      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        Expanded(child: Stack(children: [
          ClipRRect(
            borderRadius: const BorderRadius.vertical(top: Radius.circular(13)),
            child: item.hasImage
              ? Image.file(File(AppPaths.resolve(item.imagePath!)), width: double.infinity, fit: BoxFit.cover,
                  errorBuilder: (_, __, ___) => _PlaceholderImg(item: item))
              : _PlaceholderImg(item: item),
          ),
          // Availability toggle
          Positioned(top: 6, right: 6, child: GestureDetector(
            onTap: () => ref.read(dbProvider).menuDao.toggleAvailable(item.id, !item.isAvailable),
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 7, vertical: 3),
              decoration: BoxDecoration(
                color: item.isAvailable ? Colors.green.withAlpha(200) : Colors.red.withAlpha(200),
                borderRadius: BorderRadius.circular(6),
              ),
              child: Text(item.isAvailable ? 'ON' : 'OFF', style: const TextStyle(color: Colors.white, fontSize: 10, fontWeight: FontWeight.w800)),
            ),
          )),
        ])),
        Padding(
          padding: const EdgeInsets.fromLTRB(10, 8, 10, 8),
          child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            Text(item.name, maxLines: 1, overflow: TextOverflow.ellipsis, style: const TextStyle(fontWeight: FontWeight.w700, fontSize: 12)),
            const SizedBox(height: 3),
            Row(children: [
              Text('${settings.currencySymbol} ${item.price.toStringAsFixed(0)}',
                style: TextStyle(fontWeight: FontWeight.w700, fontSize: 13, color: context.cs.primary)),
              const Spacer(),
              Text('Cost: ${item.costPrice.toStringAsFixed(0)}',
                style: TextStyle(fontSize: 10, color: context.cs.onSurfaceVariant)),
            ]),
            Row(children: [
              Icon(Icons.timer_outlined, size: 11, color: context.cs.onSurfaceVariant),
              Text(' ${item.preparationMinutes}m', style: TextStyle(fontSize: 10, color: context.cs.onSurfaceVariant)),
              const Spacer(),
              if (!item.isUnlimited)
                Text('Stock: ${item.stockCount}', style: TextStyle(
                  fontSize: 10, fontWeight: FontWeight.w600,
                  color: item.isLowStock ? Colors.orange : Colors.green,
                )),
              GestureDetector(
                onTap: onEdit,
                child: Icon(Icons.edit_rounded, size: 16, color: context.cs.primary),
              ),
            ]),
          ]),
        ),
      ]),
    );
  }
}

// ═══════════════════════════════════════════════════════
// CUSTOMERS SCREEN
// ═══════════════════════════════════════════════════════
class CustomersScreen extends ConsumerStatefulWidget {
  const CustomersScreen({super.key});
  @override ConsumerState<CustomersScreen> createState() => _CustomersScreenState();
}

class _CustomersScreenState extends ConsumerState<CustomersScreen> {
  String _search = '';
  CustomerEntity? _selected;

  @override
  Widget build(BuildContext context) {
    final customersAsync = ref.watch(customersProvider);
    final cs = context.cs;

    return SideNav(child: Scaffold(
      appBar: AppBar(
        leading: IconButton(icon: const Icon(Icons.arrow_back), onPressed: () => context.go('/dashboard')),
        title: const Text('Customers & Credit'),
        actions: [
          FilledButton.icon(
            icon: const Icon(Icons.person_add, size: 16),
            label: const Text('Add Customer'),
            onPressed: _showAddCustomerDialog,
          ),
          const SizedBox(width: 12),
        ],
      ),
      body: Row(children: [
        // List panel
        SizedBox(width: 360, child: Column(children: [
          // Search
          Padding(
            padding: const EdgeInsets.all(12),
            child: TextField(
              onChanged: (v) => setState(() => _search = v),
              decoration: const InputDecoration(hintText: 'Search by name or phone...', prefixIcon: Icon(Icons.search, size: 18), isDense: true),
            ),
          ),
          // Stats
          customersAsync.when(
            data: (customers) => Padding(
              padding: const EdgeInsets.fromLTRB(12, 0, 12, 8),
              child: Row(children: [
                _MiniStat('Total', '${customers.length}', cs.primary),
                _MiniStat('With debt', '${customers.where((c) => c.hasDebt).length}', Colors.red),
                _MiniStat('Total debt', 'Rs ${customers.fold(0.0, (s, c) => s + c.balance).toStringAsFixed(0)}', Colors.orange),
              ]),
            ),
            loading: () => const SizedBox(), error: (_, __) => const SizedBox(),
          ),
          // List
          Expanded(child: customersAsync.when(
            loading: () => const Center(child: CircularProgressIndicator()),
            error: (e, _) => Center(child: Text('Error: $e')),
            data: (customers) {
              final filtered = _search.isEmpty ? customers : customers.where((c) =>
                c.name.toLowerCase().contains(_search.toLowerCase()) || c.phone.contains(_search)).toList();
              if (filtered.isEmpty) return const Center(child: Text('No customers found'));
              return ListView.builder(
                itemCount: filtered.length,
                padding: const EdgeInsets.symmetric(horizontal: 10),
                itemBuilder: (_, i) {
                  final c = filtered[i];
                  final isSel = c.id == _selected?.id;
                  return GestureDetector(
                    onTap: () => setState(() => _selected = c),
                    child: AnimatedContainer(
                      duration: const Duration(milliseconds: 200),
                      margin: const EdgeInsets.only(bottom: 6),
                      padding: const EdgeInsets.all(12),
                      decoration: BoxDecoration(
                        color: isSel ? cs.primary.withAlpha(15) : context.cardBg,
                        borderRadius: BorderRadius.circular(12),
                        border: Border.all(color: isSel ? cs.primary : context.border, width: isSel ? 1.5 : 0.5),
                      ),
                      child: Row(children: [
                        CircleAvatar(radius: 22, backgroundColor: cs.primary.withAlpha(20),
                          child: Text(c.name.substring(0, 1).toUpperCase(), style: TextStyle(color: cs.primary, fontWeight: FontWeight.w700, fontSize: 18))),
                        const SizedBox(width: 12),
                        Expanded(child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                          Text(c.name, style: const TextStyle(fontWeight: FontWeight.w600, fontSize: 14)),
                          Text(c.phone, style: TextStyle(fontSize: 12, color: cs.onSurfaceVariant)),
                        ])),
                        Column(crossAxisAlignment: CrossAxisAlignment.end, children: [
                          if (c.hasDebt) Text('Rs ${c.balance.toStringAsFixed(0)}',
                            style: const TextStyle(color: Colors.red, fontWeight: FontWeight.w700, fontSize: 13)),
                          if (c.loyaltyPoints > 0) Text('${c.loyaltyPoints} pts',
                            style: TextStyle(fontSize: 11, color: cs.primary)),
                        ]),
                      ]),
                    ),
                  );
                },
              );
            },
          )),
        ])),
        // Divider
        VerticalDivider(width: 1, color: context.border),
        // Detail panel
        Expanded(child: _selected == null
          ? Center(child: Column(mainAxisSize: MainAxisSize.min, children: [
              Icon(Icons.person_search_rounded, size: 64, color: cs.onSurfaceVariant.withAlpha(60)),
              const SizedBox(height: 14),
              Text('Select a customer to view details', style: TextStyle(color: cs.onSurfaceVariant)),
            ]))
          : _CustomerDetail(
              customer: _selected!,
              onRefresh: () => setState(() {}),
            ),
        ),
      ]),
    ));
  }

  void _showAddCustomerDialog() {
    final nameCtrl = TextEditingController();
    final phoneCtrl = TextEditingController();
    final addrCtrl = TextEditingController();
    final limitCtrl = TextEditingController();
    showDialog(context: context, builder: (_) => AlertDialog(
      title: const Text('Add customer'),
      content: Column(mainAxisSize: MainAxisSize.min, children: [
        TextField(controller: nameCtrl, autofocus: true, decoration: const InputDecoration(labelText: 'Full name *')),
        const SizedBox(height: 10),
        TextField(controller: phoneCtrl, keyboardType: TextInputType.phone, decoration: const InputDecoration(labelText: 'Phone number *')),
        const SizedBox(height: 10),
        TextField(controller: addrCtrl, decoration: const InputDecoration(labelText: 'Address (optional)')),
        const SizedBox(height: 10),
        TextField(controller: limitCtrl, keyboardType: TextInputType.number, decoration: const InputDecoration(labelText: 'Credit limit (optional)')),
      ]),
      actions: [
        TextButton(onPressed: () => Navigator.pop(context), child: const Text('Cancel')),
        FilledButton(
          onPressed: () async {
            if (nameCtrl.text.isEmpty || phoneCtrl.text.isEmpty) return;
            await ref.read(dbProvider).customerDao.insert_(CustomersCompanion.insert(
              name: nameCtrl.text, phone: phoneCtrl.text,
              address: Value(addrCtrl.text.isEmpty ? null : addrCtrl.text),
              creditLimit: Value(double.tryParse(limitCtrl.text) ?? 0),
            ));
            if (mounted) { Navigator.pop(context); showSuccess(context, 'Customer added'); }
          },
          child: const Text('Add'),
        ),
      ],
    ));
  }
}

class _CustomerDetail extends ConsumerWidget {
  const _CustomerDetail({required this.customer, required this.onRefresh});
  final CustomerEntity customer;
  final VoidCallback onRefresh;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final cs = context.cs;
    return SingleChildScrollView(
      padding: const EdgeInsets.all(24),
      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        // Header
        Row(children: [
          CircleAvatar(radius: 36, backgroundColor: cs.primary.withAlpha(20),
            child: Text(customer.name.substring(0,1).toUpperCase(),
              style: TextStyle(color: cs.primary, fontSize: 28, fontWeight: FontWeight.w800))),
          const SizedBox(width: 18),
          Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            Text(customer.name, style: Theme.of(context).textTheme.headlineSmall?.copyWith(fontWeight: FontWeight.w800)),
            Text(customer.phone, style: TextStyle(color: cs.onSurfaceVariant, fontSize: 15)),
            if (customer.address != null) Text(customer.address!, style: TextStyle(color: cs.onSurfaceVariant, fontSize: 13)),
          ]),
          const Spacer(),
          if (customer.hasDebt)
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(color: Colors.red.withAlpha(15), borderRadius: BorderRadius.circular(12), border: Border.all(color: Colors.red.withAlpha(60))),
              child: Column(children: [
                const Text('Outstanding', style: TextStyle(fontSize: 11, color: Colors.red)),
                Text('Rs ${customer.balance.toStringAsFixed(0)}', style: const TextStyle(color: Colors.red, fontWeight: FontWeight.w800, fontSize: 20)),
              ]),
            ),
        ]),
        const SizedBox(height: 20),
        // Stats row
        Row(children: [
          Expanded(child: AppCard(child: Column(children: [
            Text('Credit limit', style: TextStyle(fontSize: 11, color: cs.onSurfaceVariant)),
            const SizedBox(height: 4),
            Text('Rs ${customer.creditLimit.toStringAsFixed(0)}', style: const TextStyle(fontWeight: FontWeight.w700, fontSize: 18)),
          ]))),
          const SizedBox(width: 12),
          Expanded(child: AppCard(child: Column(children: [
            Text('Available credit', style: TextStyle(fontSize: 11, color: cs.onSurfaceVariant)),
            const SizedBox(height: 4),
            Text('Rs ${customer.availableCredit.toStringAsFixed(0)}',
              style: TextStyle(fontWeight: FontWeight.w700, fontSize: 18, color: customer.availableCredit > 0 ? cs.primary : Colors.red)),
          ]))),
          const SizedBox(width: 12),
          Expanded(child: AppCard(child: Column(children: [
            Text('Loyalty points', style: TextStyle(fontSize: 11, color: cs.onSurfaceVariant)),
            const SizedBox(height: 4),
            Text('${customer.loyaltyPoints}', style: TextStyle(fontWeight: FontWeight.w700, fontSize: 18, color: cs.primary)),
          ]))),
        ]),
        const SizedBox(height: 18),
        // Action buttons
        Row(children: [
          Expanded(child: FilledButton.icon(
            icon: const Icon(Icons.add_card, size: 18),
            label: const Text('Give Credit'),
            onPressed: () => _showCreditDialog(context, ref, isCredit: true),
            style: FilledButton.styleFrom(padding: const EdgeInsets.symmetric(vertical: 14)),
          )),
          const SizedBox(width: 12),
          Expanded(child: OutlinedButton.icon(
            icon: const Icon(Icons.payments_outlined, size: 18),
            label: const Text('Receive Payment'),
            onPressed: customer.hasDebt ? () => _showCreditDialog(context, ref, isCredit: false) : null,
            style: OutlinedButton.styleFrom(padding: const EdgeInsets.symmetric(vertical: 14)),
          )),
          const SizedBox(width: 12),
          OutlinedButton.icon(
            icon: const Icon(Icons.print_outlined, size: 18),
            label: const Text('Statement'),
            onPressed: () {},
          ),
        ]),
        const SizedBox(height: 20),
        // Ledger
        Text('Transaction history', style: Theme.of(context).textTheme.titleMedium?.copyWith(fontWeight: FontWeight.w700)),
        const SizedBox(height: 10),
        FutureBuilder<List<CreditLedgerRow>>(
          future: ref.watch(dbProvider).customerDao.ledger(customer.id),
          builder: (_, snap) {
            final ledger = snap.data ?? [];
            if (ledger.isEmpty) return Center(child: Padding(
              padding: const EdgeInsets.all(24),
              child: Text('No transactions yet', style: TextStyle(color: cs.onSurfaceVariant)),
            ));
            return Column(children: ledger.map((l) {
              final isDebit = l.type == 'debit';
              return Container(
                margin: const EdgeInsets.only(bottom: 6),
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: context.cardBg, borderRadius: BorderRadius.circular(10),
                  border: Border.all(color: context.border, width: 0.5),
                ),
                child: Row(children: [
                  Container(
                    width: 36, height: 36,
                    decoration: BoxDecoration(
                      color: (isDebit ? Colors.red : Colors.green).withAlpha(20), shape: BoxShape.circle,
                    ),
                    child: Icon(isDebit ? Icons.arrow_upward : Icons.arrow_downward,
                      color: isDebit ? Colors.red : Colors.green, size: 18),
                  ),
                  const SizedBox(width: 10),
                  Expanded(child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                    Text(l.description.isEmpty ? (isDebit ? 'Credit given' : 'Payment received') : l.description,
                      style: const TextStyle(fontWeight: FontWeight.w500, fontSize: 13)),
                    Text(DateFormat('dd MMM yyyy  HH:mm').format(l.createdAt),
                      style: TextStyle(fontSize: 11, color: cs.onSurfaceVariant)),
                  ])),
                  Column(crossAxisAlignment: CrossAxisAlignment.end, children: [
                    Text('${isDebit ? '+' : '-'}Rs ${l.amount.toStringAsFixed(0)}',
                      style: TextStyle(fontWeight: FontWeight.w700, fontSize: 14, color: isDebit ? Colors.red : Colors.green)),
                    Text('Bal: Rs ${l.balanceAfter.toStringAsFixed(0)}',
                      style: TextStyle(fontSize: 11, color: cs.onSurfaceVariant)),
                  ]),
                ]),
              );
            }).toList());
          },
        ),
      ]),
    );
  }

  void _showCreditDialog(BuildContext context, WidgetRef ref, {required bool isCredit}) {
    final amountCtrl = TextEditingController();
    final descCtrl = TextEditingController();
    showDialog(context: context, builder: (_) => AlertDialog(
      title: Text(isCredit ? 'Give credit to ${customer.name}' : 'Receive payment from ${customer.name}'),
      content: Column(mainAxisSize: MainAxisSize.min, children: [
        TextField(controller: amountCtrl, autofocus: true, keyboardType: TextInputType.number,
          decoration: InputDecoration(labelText: 'Amount', prefixText: 'Rs ', prefixIcon: Icon(isCredit ? Icons.add_card : Icons.payments_outlined))),
        const SizedBox(height: 10),
        TextField(controller: descCtrl, decoration: const InputDecoration(labelText: 'Note (optional)')),
      ]),
      actions: [
        TextButton(onPressed: () => Navigator.pop(context), child: const Text('Cancel')),
        FilledButton(
          onPressed: () async {
            final amount = double.tryParse(amountCtrl.text) ?? 0;
            if (amount <= 0) return;
            final db = ref.read(dbProvider);
            final newBalance = isCredit ? customer.balance + amount : customer.balance - amount;
            await db.customerDao.updateBalance(customer.id, newBalance.clamp(0, double.infinity));
            await db.customerDao.insertLedger(CreditLedgerCompanion.insert(
              customerId: customer.id,
              type: isCredit ? 'debit' : 'payment',
              amount: amount,
              balanceAfter: newBalance,
              description: Value(descCtrl.text),
            ));
            if (context.mounted) {
              Navigator.pop(context);
              showSuccess(context, isCredit ? 'Credit given' : 'Payment recorded');
              onRefresh();
            }
          },
          child: Text(isCredit ? 'Give credit' : 'Record payment'),
        ),
      ],
    ));
  }
}

class _MiniStat extends StatelessWidget {
  const _MiniStat(this.label, this.value, this.color);
  final String label, value; final Color color;
  @override
  Widget build(BuildContext context) => Expanded(child: Column(children: [
    Text(value, style: TextStyle(fontWeight: FontWeight.w700, fontSize: 15, color: color)),
    Text(label, style: TextStyle(fontSize: 11, color: context.cs.onSurfaceVariant), textAlign: TextAlign.center),
  ]));
}

// ═══════════════════════════════════════════════════════
// DEALS MANAGEMENT TAB
// ═══════════════════════════════════════════════════════

class _DealsManagementTab extends ConsumerStatefulWidget {
  const _DealsManagementTab();
  @override ConsumerState<_DealsManagementTab> createState() => _DealsManagementTabState();
}

class _DealsManagementTabState extends ConsumerState<_DealsManagementTab> {
  String _searchQuery = '';
  String _statusFilter = 'all'; // 'all', 'active', 'inactive'

  @override
  Widget build(BuildContext context) {
    final dealsAsync = ref.watch(dealsProvider);
    final settings = ref.watch(settingsProvider);

    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: const Text('Deals Management', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
        actions: [
          FilledButton.icon(
            icon: const Icon(Icons.add, size: 16),
            label: const Text('Create Deal'),
            onPressed: () => _showDealBuilderDialog(context, null),
          ),
          const SizedBox(width: 12),
        ],
      ),
      body: Column(
        children: [
          // Filter bar
          Padding(
            padding: const EdgeInsets.all(12),
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    onChanged: (v) => setState(() => _searchQuery = v),
                    decoration: const InputDecoration(
                      hintText: 'Search deals by name or code...',
                      prefixIcon: Icon(Icons.search),
                    ),
                  ),
                ),
                const SizedBox(width: 12),
                DropdownButton<String>(
                  value: _statusFilter,
                  onChanged: (v) => setState(() => _statusFilter = v!),
                  items: const [
                    DropdownMenuItem(value: 'all', child: Text('All Statuses')),
                    DropdownMenuItem(value: 'active', child: Text('Active Only')),
                    DropdownMenuItem(value: 'inactive', child: Text('Inactive Only')),
                  ],
                ),
              ],
            ),
          ),
          // Deals List Table
          Expanded(
            child: dealsAsync.when(
              loading: () => const Center(child: CircularProgressIndicator()),
              error: (e, _) => Center(child: Text('Error loading deals: $e')),
              data: (deals) {
                final filtered = deals.where((d) {
                  final matchesSearch = d.name.toLowerCase().contains(_searchQuery.toLowerCase()) ||
                      (d.code?.toLowerCase().contains(_searchQuery.toLowerCase()) ?? false);
                  final matchesStatus = _statusFilter == 'all' ||
                      (_statusFilter == 'active' && d.isActive) ||
                      (_statusFilter == 'inactive' && !d.isActive);
                  return matchesSearch && matchesStatus;
                }).toList();

                if (filtered.isEmpty) {
                  return const Center(child: Text('No deals found. Click "Create Deal" to build one!'));
                }

                return ListView.builder(
                  padding: const EdgeInsets.symmetric(horizontal: 12),
                  itemCount: filtered.length,
                  itemBuilder: (_, i) {
                    final deal = filtered[i];
                    return FutureBuilder<List<DealItem>>(
                      future: ref.read(dbProvider).dealDao.itemsForDeal(deal.id),
                      builder: (ctx, snap) {
                        final itemsCount = snap.data?.length ?? 0;
                        return AppCard(
                          margin: const EdgeInsets.only(bottom: 8),
                          child: InkWell(
                            onTap: () => _showDealDetails(context, deal, snap.data ?? []),
                            child: Row(
                              children: [
                                // Thumbnail or Icon
                                Container(
                                  width: 48,
                                  height: 48,
                                  decoration: BoxDecoration(
                                    color: context.cs.primary.withAlpha(20),
                                    borderRadius: BorderRadius.circular(8),
                                  ),
                                  child: deal.imagePath != null && deal.imagePath!.isNotEmpty
                                      ? ClipRRect(
                                          borderRadius: BorderRadius.circular(8),
                                          child: Image.file(File(AppPaths.resolve(deal.imagePath!)), fit: BoxFit.cover,
                                            errorBuilder: (_, __, ___) => Icon(Icons.shopping_bag_outlined, color: context.cs.primary)),
                                        )
                                      : Icon(Icons.shopping_bag_outlined, color: context.cs.primary),
                                ),
                                const SizedBox(width: 14),
                                // Name and Code
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text(deal.name, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 14)),
                                      if (deal.code != null && deal.code!.isNotEmpty)
                                        Text('Code: ${deal.code}', style: TextStyle(fontSize: 12, color: context.cs.onSurfaceVariant)),
                                    ],
                                  ),
                                ),
                                // Price
                                Text('${settings.currencySymbol} ${deal.price.toStringAsFixed(0)}',
                                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14, color: context.cs.primary)),
                                const SizedBox(width: 24),
                                // Items Count
                                Text('$itemsCount Items Included', style: const TextStyle(fontSize: 13)),
                                const SizedBox(width: 24),
                                // Status
                                Container(
                                  padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
                                  decoration: BoxDecoration(
                                    color: deal.isActive ? Colors.green.withAlpha(20) : Colors.red.withAlpha(20),
                                    borderRadius: BorderRadius.circular(6),
                                  ),
                                  child: Text(
                                    deal.isActive ? 'ACTIVE' : 'INACTIVE',
                                    style: TextStyle(color: deal.isActive ? Colors.green : Colors.red, fontSize: 11, fontWeight: FontWeight.bold),
                                  ),
                                ),
                                const SizedBox(width: 16),
                                // Edit & Delete Buttons
                                IconButton(
                                  icon: const Icon(Icons.edit_outlined, size: 20),
                                  tooltip: 'Edit Deal',
                                  onPressed: () => _showDealBuilderDialog(context, deal),
                                ),
                                IconButton(
                                  icon: const Icon(Icons.delete_outline, color: Colors.red, size: 20),
                                  tooltip: 'Delete Deal',
                                  onPressed: () => _deleteDeal(deal),
                                ),
                              ],
                            ),
                          ),
                        );
                      },
                    );
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  Future<void> _deleteDeal(DealRow deal) async {
    final ok = await confirm(context, 'Delete Deal?', 'This will permanently remove the "${deal.name}" deal. Menu items included will NOT be deleted.', danger: true);
    if (ok) {
      await ref.read(dbProvider).dealDao.deleteDeal(deal.id);
      ref.invalidate(dealsProvider);
      ref.invalidate(activeDealsProvider);
      if (mounted) showSuccess(context, 'Deal deleted successfully');
    }
  }

  void _showDealDetails(BuildContext context, DealRow deal, List<DealItem> items) {
    showDialog(
      context: context,
      builder: (_) => _DealDetailsDialog(deal: deal, dealItems: items, db: ref.read(dbProvider)),
    );
  }

  void _showDealBuilderDialog(BuildContext context, DealRow? deal) {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (_) => _DealBuilderDialog(deal: deal, onSaved: () {
        ref.invalidate(dealsProvider);
        ref.invalidate(activeDealsProvider);
      }),
    );
  }
}

// ── Deal Details Dialog ────────────────────────────────
class _DealDetailsDialog extends StatelessWidget {
  const _DealDetailsDialog({required this.deal, required this.dealItems, required this.db});
  final DealRow deal;
  final List<DealItem> dealItems;
  final AppDatabase db;

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(deal.name),
      content: SizedBox(
        width: 400,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            if (deal.imagePath != null && deal.imagePath!.isNotEmpty)
              Container(
                height: 120,
                width: double.infinity,
                margin: const EdgeInsets.only(bottom: 12),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  image: DecorationImage(image: FileImage(File(AppPaths.resolve(deal.imagePath!))), fit: BoxFit.cover),
                ),
              ),
            Text('Price: Rs. ${deal.price.toStringAsFixed(0)}', style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16, color: Colors.blue)),
            if (deal.code != null && deal.code!.isNotEmpty) ...[
              const SizedBox(height: 6),
              Text('Code: ${deal.code}', style: const TextStyle(fontSize: 13)),
            ],
            if (deal.description != null && deal.description!.isNotEmpty) ...[
              const SizedBox(height: 6),
              Text('Description: ${deal.description}', style: const TextStyle(fontSize: 13, fontStyle: FontStyle.italic)),
            ],
            const SizedBox(height: 16),
            const Text('Items Included:', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14)),
            const SizedBox(height: 8),
            ConstrainedBox(
              constraints: const BoxConstraints(maxHeight: 200),
              child: ListView.builder(
                shrinkWrap: true,
                itemCount: dealItems.length,
                itemBuilder: (_, i) {
                  final di = dealItems[i];
                  return FutureBuilder<MenuItemRow?>(
                    future: db.menuDao.byId(di.menuItemId),
                    builder: (ctx, snap) {
                      final name = snap.data?.name ?? 'Loading...';
                      return Padding(
                        padding: const EdgeInsets.symmetric(vertical: 3),
                        child: Row(
                          children: [
                            const Icon(Icons.check_circle_outline, size: 16, color: Colors.green),
                            const SizedBox(width: 8),
                            Text('$name (${di.quantity})'),
                          ],
                        ),
                      );
                    },
                  );
                },
              ),
            ),
          ],
        ),
      ),
      actions: [
        FilledButton(onPressed: () => Navigator.pop(context), child: const Text('Close')),
      ],
    );
  }
}

// ── Deal Builder Dialog ────────────────────────────────
class _DealBuilderDialog extends ConsumerStatefulWidget {
  const _DealBuilderDialog({this.deal, required this.onSaved});
  final DealRow? deal;
  final VoidCallback onSaved;
  @override ConsumerState<_DealBuilderDialog> createState() => _DealBuilderDialogState();
}

class _DealBuilderDialogState extends ConsumerState<_DealBuilderDialog> {
  final _nameCtrl = TextEditingController();
  final _priceCtrl = TextEditingController();
  final _codeCtrl = TextEditingController();
  final _descCtrl = TextEditingController();
  bool _isActive = true;
  String _imagePath = '';
  Map<int, (MenuItemRow, int)> _selectedItems = {}; // menuItemId -> (MenuItem, qty)
  bool _loading = false;

  @override
  void initState() {
    super.initState();
    if (widget.deal != null) {
      final d = widget.deal!;
      _nameCtrl.text = d.name;
      _priceCtrl.text = d.price.toStringAsFixed(0);
      _codeCtrl.text = d.code ?? '';
      _descCtrl.text = d.description ?? '';
      _isActive = d.isActive;
      _imagePath = d.imagePath ?? '';
      _loadDealItems();
    }
  }

  Future<void> _loadDealItems() async {
    setState(() => _loading = true);
    final db = ref.read(dbProvider);
    final items = await db.dealDao.itemsForDeal(widget.deal!.id);
    for (final di in items) {
      final mi = await db.menuDao.byId(di.menuItemId);
      if (mi != null) {
        _selectedItems[di.menuItemId] = (mi, di.quantity);
      }
    }
    setState(() => _loading = false);
  }

  @override
  void dispose() {
    _nameCtrl.dispose();
    _priceCtrl.dispose();
    _codeCtrl.dispose();
    _descCtrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(widget.deal == null ? 'Create Menu Deal' : 'Edit Deal - ${widget.deal!.name}'),
      content: SizedBox(
        width: 800,
        height: 600,
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Left: Deal configuration fields
            Expanded(
              flex: 4,
              child: SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.only(right: 16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Image upload
                      GestureDetector(
                        onTap: () async {
                          final img = await ImagePicker().pickImage(source: ImageSource.gallery, imageQuality: 80);
                          if (img != null) {
                            final saved = await AppPaths.copyToMedia(img.path, prefix: 'deal');
                            setState(() => _imagePath = saved);
                          }
                        },
                        child: Container(
                          height: 120,
                          width: double.infinity,
                          decoration: BoxDecoration(
                            color: context.elevated,
                            borderRadius: BorderRadius.circular(10),
                            border: Border.all(color: context.border),
                            image: _imagePath.isNotEmpty ? DecorationImage(image: FileImage(File(AppPaths.resolve(_imagePath))), fit: BoxFit.cover) : null,
                          ),
                          child: _imagePath.isEmpty
                              ? Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Icon(Icons.add_photo_alternate_rounded, size: 40, color: context.cs.onSurfaceVariant),
                                    const SizedBox(height: 6),
                                    const Text('Tap to add deal photo', style: TextStyle(fontSize: 13)),
                                  ],
                                )
                              : Align(
                                  alignment: Alignment.bottomRight,
                                  child: Container(
                                    margin: const EdgeInsets.all(8),
                                    padding: const EdgeInsets.all(6),
                                    decoration: BoxDecoration(color: Colors.black54, borderRadius: BorderRadius.circular(6)),
                                    child: const Icon(Icons.edit, color: Colors.white, size: 16),
                                  ),
                                ),
                        ),
                      ),
                      const SizedBox(height: 14),
                      TextField(controller: _nameCtrl, decoration: const InputDecoration(labelText: 'Deal Name *')),
                      const SizedBox(height: 10),
                      TextField(controller: _priceCtrl, keyboardType: TextInputType.number, decoration: const InputDecoration(labelText: 'Deal Price (Rs) *')),
                      const SizedBox(height: 10),
                      TextField(controller: _codeCtrl, decoration: const InputDecoration(labelText: 'Deal Code (optional)')),
                      const SizedBox(height: 10),
                      TextField(controller: _descCtrl, maxLines: 2, decoration: const InputDecoration(labelText: 'Description (optional)')),
                      const SizedBox(height: 14),
                      SwitchListTile(
                        title: const Text('Status (Active / Inactive)', style: TextStyle(fontSize: 13, fontWeight: FontWeight.bold)),
                        value: _isActive,
                        onChanged: (v) => setState(() => _isActive = v),
                        contentPadding: EdgeInsets.zero,
                      ),
                    ],
                  ),
                ),
              ),
            ),
            const VerticalDivider(),
            // Right: Deal items inclusion list
            Expanded(
              flex: 5,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text('Items Included *', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14)),
                      FilledButton.icon(
                        icon: const Icon(Icons.add, size: 14),
                        label: const Text('Add Item', style: TextStyle(fontSize: 11)),
                        onPressed: () {
                          showDialog(
                            context: context,
                            builder: (dialogCtx) => _AddDealItemDialog(
                              db: ref.read(dbProvider),
                              onItemAdded: (menuItem) {
                                setState(() {
                                  if (_selectedItems.containsKey(menuItem.id)) {
                                    final current = _selectedItems[menuItem.id]!;
                                    _selectedItems[menuItem.id] = (menuItem, current.$2 + 1);
                                  } else {
                                    _selectedItems[menuItem.id] = (menuItem, 1);
                                  }
                                });
                              },
                            ),
                          );
                        },
                      ),
                    ],
                  ),
                  const SizedBox(height: 10),
                  Expanded(
                    child: _loading
                        ? const Center(child: CircularProgressIndicator())
                        : _selectedItems.isEmpty
                            ? Center(
                                child: Text('No items in this deal.\nClick "Add Item" to add menu items.',
                                    textAlign: TextAlign.center, style: TextStyle(color: context.cs.onSurfaceVariant)),
                              )
                            : ListView.builder(
                                itemCount: _selectedItems.length,
                                itemBuilder: (_, i) {
                                  final entry = _selectedItems.entries.elementAt(i);
                                  final menuItem = entry.value.$1;
                                  final qty = entry.value.$2;
                                  return Card(
                                    margin: const EdgeInsets.only(bottom: 6),
                                    child: Padding(
                                      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                                      child: Row(
                                        children: [
                                          Expanded(
                                            child: Column(
                                              crossAxisAlignment: CrossAxisAlignment.start,
                                              children: [
                                                Text(menuItem.name, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 13)),
                                                Text('Original Price: Rs. ${menuItem.price.toStringAsFixed(0)}', style: TextStyle(fontSize: 11, color: context.cs.onSurfaceVariant)),
                                              ],
                                            ),
                                          ),
                                          // Quantity Incrementor
                                          Row(
                                            children: [
                                              IconButton(
                                                icon: const Icon(Icons.remove, size: 16),
                                                onPressed: () {
                                                  setState(() {
                                                    if (qty > 1) {
                                                      _selectedItems[menuItem.id] = (menuItem, qty - 1);
                                                    }
                                                  });
                                                },
                                              ),
                                              Text('$qty', style: const TextStyle(fontWeight: FontWeight.bold)),
                                              IconButton(
                                                icon: const Icon(Icons.add, size: 16),
                                                onPressed: () {
                                                  setState(() {
                                                    _selectedItems[menuItem.id] = (menuItem, qty + 1);
                                                  });
                                                },
                                              ),
                                            ],
                                          ),
                                          const SizedBox(width: 8),
                                          IconButton(
                                            icon: const Icon(Icons.delete_outline, color: Colors.red, size: 18),
                                            onPressed: () {
                                              setState(() {
                                                _selectedItems.remove(menuItem.id);
                                              });
                                            },
                                          ),
                                        ],
                                      ),
                                    ),
                                  );
                                },
                              ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
      actions: [
        TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancel')),
        FilledButton(
          onPressed: () async {
            if (_nameCtrl.text.isEmpty || _priceCtrl.text.isEmpty) {
              showError(context, 'Please enter name and price');
              return;
            }
            final price = double.tryParse(_priceCtrl.text) ?? 0;
            if (price <= 0) {
              showError(context, 'Please enter a valid price');
              return;
            }
            if (_selectedItems.isEmpty) {
              showError(context, 'Please add at least one item to the deal');
              return;
            }

            final db = ref.read(dbProvider);

            if (widget.deal == null) {
              final dealId = await db.dealDao.insertDeal(DealsCompanion.insert(
                name: _nameCtrl.text,
                price: price,
                code: Value(_codeCtrl.text.isEmpty ? null : _codeCtrl.text),
                description: Value(_descCtrl.text.isEmpty ? null : _descCtrl.text),
                isActive: Value(_isActive),
                imagePath: Value(_imagePath.isEmpty ? null : _imagePath),
                createdAt: Value(DateTime.now()),
              ));

              for (final entry in _selectedItems.entries) {
                await db.dealDao.insertDealItem(DealItemsCompanion.insert(
                  dealId: dealId,
                  menuItemId: entry.key,
                  quantity: entry.value.$2,
                ));
              }
            } else {
              final d = widget.deal!;
              await db.dealDao.updateDeal(DealsCompanion(
                id: Value(d.id),
                name: Value(_nameCtrl.text),
                price: Value(price),
                code: Value(_codeCtrl.text.isEmpty ? null : _codeCtrl.text),
                description: Value(_descCtrl.text.isEmpty ? null : _descCtrl.text),
                isActive: Value(_isActive),
                imagePath: Value(_imagePath.isEmpty ? null : _imagePath),
              ));

              await db.dealDao.deleteItemsForDeal(d.id);
              for (final entry in _selectedItems.entries) {
                await db.dealDao.insertDealItem(DealItemsCompanion.insert(
                  dealId: d.id,
                  menuItemId: entry.key,
                  quantity: entry.value.$2,
                ));
              }
            }

            widget.onSaved();
            if (mounted) {
              Navigator.pop(context);
              showSuccess(context, 'Deal saved successfully');
            }
          },
          child: Text(widget.deal == null ? 'Create Deal' : 'Save Changes'),
        ),
      ],
    );
  }
}

// ── Add Deal Item Dialog (Selecting Item for Deal) ──────
class _AddDealItemDialog extends StatefulWidget {
  const _AddDealItemDialog({required this.db, required this.onItemAdded});
  final AppDatabase db;
  final ValueChanged<MenuItemRow> onItemAdded;
  @override State<_AddDealItemDialog> createState() => _AddDealItemDialogState();
}

class _AddDealItemDialogState extends State<_AddDealItemDialog> {
  int? _selectedGroupId;
  List<MenuGroupRow> _groups = [];
  List<MenuItemRow> _items = [];
  bool _loading = true;

  @override
  void initState() {
    super.initState();
    _load();
  }

  Future<void> _load() async {
    final groups = await widget.db.menuDao.getGroups();
    setState(() {
      _groups = groups;
      if (groups.isNotEmpty) {
        _selectedGroupId = groups.first.id;
        _loadItems(groups.first.id);
      } else {
        _loading = false;
      }
    });
  }

  Future<void> _loadItems(int groupId) async {
    setState(() => _loading = true);
    final items = await widget.db.menuDao.getByGroup(groupId);
    setState(() {
      _items = items;
      _loading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('Add Menu Item to Deal'),
      content: SizedBox(
        width: 600,
        height: 450,
        child: _groups.isEmpty
            ? const Center(child: Text('No categories found. Create menu groups first.'))
            : Row(
                children: [
                  // Groups sidebar
                  SizedBox(
                    width: 180,
                    child: ListView.builder(
                      itemCount: _groups.length,
                      itemBuilder: (_, i) {
                        final g = _groups[i];
                        final sel = g.id == _selectedGroupId;
                        return ListTile(
                          title: Text(g.name, style: TextStyle(fontWeight: sel ? FontWeight.bold : FontWeight.normal, fontSize: 13)),
                          selected: sel,
                          onTap: () {
                            setState(() => _selectedGroupId = g.id);
                            _loadItems(g.id);
                          },
                        );
                      },
                    ),
                  ),
                  const VerticalDivider(),
                  // Items list
                  Expanded(
                    child: _loading
                        ? const Center(child: CircularProgressIndicator())
                        : _items.isEmpty
                            ? const Center(child: Text('No items in this category'))
                            : GridView.builder(
                                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                                  crossAxisCount: 2, childAspectRatio: 1.3, crossAxisSpacing: 8, mainAxisSpacing: 8),
                                itemCount: _items.length,
                                itemBuilder: (_, i) {
                                  final item = _items[i];
                                  return InkWell(
                                    onTap: () {
                                      widget.onItemAdded(item);
                                      Navigator.pop(context);
                                    },
                                    child: Card(
                                      child: Padding(
                                        padding: const EdgeInsets.all(8),
                                        child: Column(
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          mainAxisAlignment: MainAxisAlignment.center,
                                          children: [
                                            Text(item.name, maxLines: 2, overflow: TextOverflow.ellipsis, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 12)),
                                            const SizedBox(height: 4),
                                            Text('Rs. ${item.price.toStringAsFixed(0)}', style: const TextStyle(fontSize: 12, color: Colors.blue, fontWeight: FontWeight.bold)),
                                          ],
                                        ),
                                      ),
                                    ),
                                  );
                                },
                              ),
                  ),
                ],
              ),
      ),
      actions: [
        TextButton(onPressed: () => Navigator.pop(context), child: const Text('Close')),
      ],
    );
  }
}

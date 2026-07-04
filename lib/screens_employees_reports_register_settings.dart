// ═══════════════════════════════════════════════════════
// EMPLOYEES SCREEN — Staff, attendance, salaries
// ═══════════════════════════════════════════════════════

part of 'main.dart';

class EmployeesScreen extends ConsumerStatefulWidget {
  const EmployeesScreen({super.key});
  @override ConsumerState<EmployeesScreen> createState() => _EmployeesScreenState();
}

class _EmployeesScreenState extends ConsumerState<EmployeesScreen>
    with SingleTickerProviderStateMixin {
  late final TabController _tab;

  @override
  void initState() {
    super.initState();
    _tab = TabController(length: 3, vsync: this);
  }

  @override
  void dispose() { _tab.dispose(); super.dispose(); }

  @override
  Widget build(BuildContext context) {
    return SideNav(child: Scaffold(
      appBar: AppBar(
        leading: IconButton(icon: const Icon(Icons.arrow_back), onPressed: () => context.go('/dashboard')),
        title: const Text('Staff Management'),
        actions: [
          FilledButton.icon(
            icon: const Icon(Icons.person_add, size: 16),
            label: const Text('Add Staff'),
            onPressed: _showAddStaffDialog,
          ),
          const SizedBox(width: 12),
        ],
        bottom: TabBar(
          controller: _tab,
          tabs: const [Tab(text: 'Staff List'), Tab(text: 'Attendance Today'), Tab(text: 'Salary Payments')],
        ),
      ),
      body: TabBarView(controller: _tab, children: [
        _StaffListTab(onEdit: _showEditStaffDialog),
        const _AttendanceTab(),
        const _SalaryTab(),
      ]),
    ));
  }

  void _showAddStaffDialog() => _showStaffDialog();
  void _showEditStaffDialog(UserEntity user) => _showStaffDialog(existing: user);

  void _showStaffDialog({UserEntity? existing}) {
    final nameCtrl  = TextEditingController(text: existing?.name);
    final emailCtrl = TextEditingController(
      text: existing != null && !_isInternalStaffUsername(existing.email) ? existing.email : '',
    );
    final passCtrl  = TextEditingController();
    final phoneCtrl = TextEditingController(text: existing?.phone);
    final salCtrl   = TextEditingController(text: existing?.salary.toStringAsFixed(0));
    var role = existing?.role ?? UserRole.waiter;
    var wageType = existing?.wageType ?? WageType.monthly;
    String? photoPath = existing?.photoPath;

    showDialog(context: context, builder: (_) => StatefulBuilder(builder: (ctx, ss) => AlertDialog(
      title: Text(existing == null ? 'Add staff member' : 'Edit ${existing.name}'),
      content: SizedBox(width: 480, child: SingleChildScrollView(child: Column(mainAxisSize: MainAxisSize.min, children: [
        // Staff Photo Picker
        Center(
          child: GestureDetector(
            onTap: () async {
              final img = await ImagePicker().pickImage(source: ImageSource.gallery, imageQuality: 80);
              if (img != null) {
                final savedPath = await AppPaths.copyToMedia(img.path, prefix: 'user');
                ss(() => photoPath = savedPath);
              }
            },
            child: CircleAvatar(
              radius: 36,
              backgroundColor: context.cs.primary.withAlpha(15),
              backgroundImage: photoPath != null && photoPath!.isNotEmpty
                  ? FileImage(File(AppPaths.resolve(photoPath!)))
                  : null,
              child: photoPath == null || photoPath!.isEmpty
                  ? Icon(Icons.add_a_photo_rounded, size: 24, color: context.cs.primary)
                  : null,
            ),
          ),
        ),
        const SizedBox(height: 16),
        DropdownButtonFormField<UserRole>(
          value: role,
          decoration: const InputDecoration(labelText: 'Role'),
          items: UserRole.values
            .map((r) => DropdownMenuItem(value: r, child: Text(r.name.toUpperCase()))).toList(),
          onChanged: (v) => ss(() => role = v!),
        ),
        const SizedBox(height: 12),
        Row(children: [
          Expanded(child: TextField(controller: nameCtrl, autofocus: true,
            decoration: const InputDecoration(labelText: 'Full name *'))),
          const SizedBox(width: 10),
          Expanded(child: TextField(controller: phoneCtrl,
            decoration: const InputDecoration(labelText: 'Phone'))),
        ]),
        if (_roleUsesLogin(role)) ...[
          const SizedBox(height: 10),
          Row(children: [
            Expanded(child: TextField(controller: emailCtrl,
              decoration: const InputDecoration(labelText: 'Username *'))),
            const SizedBox(width: 10),
            Expanded(child: TextField(controller: passCtrl, obscureText: true,
              decoration: InputDecoration(
                labelText: existing == null || _isInternalStaffUsername(existing.email)
                  ? 'Password *'
                  : 'New password',
              ))),
          ]),
        ],
        const SizedBox(height: 10),
        Row(children: [
          Expanded(child: TextField(controller: salCtrl, keyboardType: TextInputType.number,
            decoration: const InputDecoration(labelText: 'Salary / Wage amount'))),
          const SizedBox(width: 10),
          Expanded(child: DropdownButtonFormField<WageType>(
            value: wageType,
            decoration: const InputDecoration(labelText: 'Wage type'),
            items: const [
              DropdownMenuItem(value: WageType.monthly, child: Text('Monthly')),
              DropdownMenuItem(value: WageType.daily,   child: Text('Daily wages')),
              DropdownMenuItem(value: WageType.hourly,  child: Text('Hourly')),
            ],
            onChanged: (v) => ss(() => wageType = v!),
          )),
        ]),
      ]))),
      actions: [
        TextButton(onPressed: () => Navigator.pop(ctx), child: const Text('Cancel')),
        FilledButton(
          onPressed: () async {
            final usesLogin = _roleUsesLogin(role);
            final needsPassword = usesLogin &&
                (existing == null || _isInternalStaffUsername(existing.email));
            if (nameCtrl.text.trim().isEmpty) return;
            if (usesLogin && emailCtrl.text.trim().isEmpty) return;
            if (needsPassword && passCtrl.text.isEmpty) return;
            final db = ref.read(dbProvider);
            if (existing == null) {
              final username = usesLogin
                  ? emailCtrl.text.trim().toLowerCase()
                  : _internalStaffUsername();
              final password = usesLogin ? passCtrl.text : _internalStaffPassword();
              final hash = sha256.convert(utf8.encode(password)).toString();
              await db.userDao.insert_(UsersCompanion.insert(
                name: nameCtrl.text.trim(), email: username,
                passwordHash: hash, role: role.name,
                phone: Value(phoneCtrl.text.isEmpty ? null : phoneCtrl.text),
                salary: Value(double.tryParse(salCtrl.text) ?? 0),
                wageType: Value(wageType.name),
                photoPath: Value(photoPath),
              ));
            } else {
              final Value<String> updatedUsername = usesLogin
                  ? Value(emailCtrl.text.trim().toLowerCase())
                  : Value(_isInternalStaffUsername(existing.email)
                      ? existing.email
                      : _internalStaffUsername(existing.id));
              final Value<String> updatedPassword = passCtrl.text.isEmpty
                  ? const Value<String>.absent()
                  : Value(sha256.convert(utf8.encode(passCtrl.text)).toString());
              await db.userDao.update_(UsersCompanion(
                id: Value(existing.id), name: Value(nameCtrl.text.trim()),
                email: updatedUsername,
                passwordHash: updatedPassword,
                phone: Value(phoneCtrl.text.isEmpty ? null : phoneCtrl.text),
                salary: Value(double.tryParse(salCtrl.text) ?? 0),
                wageType: Value(wageType.name), role: Value(role.name),
                photoPath: Value(photoPath),
              ));
            }
            if (ctx.mounted) { Navigator.pop(ctx); showSuccess(ctx, existing == null ? 'Staff added' : 'Updated'); }
          },
          child: Text(existing == null ? 'Add staff' : 'Save'),
        ),
      ],
    )));
  }
}

bool _roleUsesLogin(UserRole role) => role == UserRole.owner || role == UserRole.manager;

bool _isInternalStaffUsername(String value) =>
    value.startsWith('staff_') && value.endsWith('@attendance.local');

String _internalStaffUsername([int? id]) {
  final suffix = id?.toString() ?? DateTime.now().microsecondsSinceEpoch.toString();
  return 'staff_$suffix@attendance.local';
}

String _internalStaffPassword() => DateTime.now().microsecondsSinceEpoch.toString();

class _StaffListTab extends ConsumerWidget {
  const _StaffListTab({required this.onEdit});
  final ValueChanged<UserEntity> onEdit;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final staffAsync = ref.watch(staffProvider);
    return staffAsync.when(
      loading: () => const Center(child: CircularProgressIndicator()),
      error: (e, _) => Center(child: Text('Error: $e')),
      data: (staff) => ListView.builder(
        padding: const EdgeInsets.all(16),
        itemCount: staff.length,
        itemBuilder: (_, i) {
          final u = staff[i];
          return AppCard(
            margin: const EdgeInsets.only(bottom: 10),
            child: Row(children: [
              CircleAvatar(
                radius: 26, backgroundColor: context.cs.primary.withAlpha(20),
                child: u.photoPath != null && u.photoPath!.isNotEmpty
                  ? ClipRRect(borderRadius: BorderRadius.circular(26), child: Image.file(File(AppPaths.resolve(u.photoPath!)), fit: BoxFit.cover))
                  : Text(u.name.substring(0,1).toUpperCase(),
                      style: TextStyle(color: context.cs.primary, fontWeight: FontWeight.w700, fontSize: 20)),
              ),
              const SizedBox(width: 14),
              Expanded(child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                Row(children: [
                  Text(u.name, style: const TextStyle(fontWeight: FontWeight.w700, fontSize: 15)),
                  const SizedBox(width: 8),
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 7, vertical: 2),
                    decoration: BoxDecoration(color: context.cs.primary.withAlpha(20), borderRadius: BorderRadius.circular(5)),
                    child: Text(u.role.name.toUpperCase(), style: TextStyle(fontSize: 10, color: context.cs.primary, fontWeight: FontWeight.w700)),
                  ),
                ]),
                if (!_isInternalStaffUsername(u.email))
                  Text(u.email, style: TextStyle(fontSize: 12, color: context.cs.onSurfaceVariant)),
                if (u.phone != null) Text(u.phone!, style: TextStyle(fontSize: 12, color: context.cs.onSurfaceVariant)),
              ])),
              Column(crossAxisAlignment: CrossAxisAlignment.end, children: [
                Text('Rs ${u.salary.toStringAsFixed(0)}', style: const TextStyle(fontWeight: FontWeight.w700, fontSize: 14)),
                Text(u.wageType.name, style: TextStyle(fontSize: 11, color: context.cs.onSurfaceVariant)),
              ]),
              const SizedBox(width: 10),
              Column(children: [
                IconButton(icon: const Icon(Icons.edit_rounded, size: 18), onPressed: () => onEdit(u)),
                IconButton(
                  icon: const Icon(Icons.person_off_rounded, size: 18, color: Colors.red),
                  onPressed: () async {
                    final ok = await confirm(context, 'Deactivate ${u.name}?', 'This will prevent them from logging in.', danger: true);
                    if (ok) {
                      await ref.read(dbProvider).userDao.update_(UsersCompanion(id: Value(u.id), isActive: const Value(false)));
                    }
                  },
                ),
              ]),
            ]),
          );
        },
      ),
    );
  }
}

class _AttendanceTab extends ConsumerWidget {
  const _AttendanceTab();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final attendAsync = ref.watch(todayAttendanceProvider);
    final staffAsync  = ref.watch(staffProvider);

    return Column(children: [
      // Action bar
      Container(
        padding: const EdgeInsets.all(14),
        color: context.isDark ? AppColors.darkCard : Colors.white,
        child: Row(children: [
          Text('Today: ${DateFormat('dd MMM yyyy').format(DateTime.now())}',
            style: const TextStyle(fontWeight: FontWeight.w600)),
          const Spacer(),
          FilledButton.icon(
            icon: const Icon(Icons.login_rounded, size: 16),
            label: const Text('Check In Staff'),
            onPressed: () => _showCheckInDialog(context, ref, staffAsync.valueOrNull ?? []),
          ),
        ]),
      ),
      // Attendance list
      Expanded(child: attendAsync.when(
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (e, _) => Center(child: Text('Error: $e')),
        data: (records) => records.isEmpty
          ? Center(child: Column(mainAxisSize: MainAxisSize.min, children: [
              Icon(Icons.people_outline, size: 64, color: context.cs.onSurfaceVariant.withAlpha(60)),
              const SizedBox(height: 12),
              Text('No attendance records today', style: TextStyle(color: context.cs.onSurfaceVariant)),
            ]))
          : ListView.builder(
              padding: const EdgeInsets.all(14),
              itemCount: records.length,
              itemBuilder: (_, i) {
                final r = records[i];
                final checkedOut = r.isCheckedOut;
                final worked = r.workedDuration;
                return AppCard(
                  margin: const EdgeInsets.only(bottom: 8),
                  child: Row(children: [
                    Container(
                      width: 44, height: 44,
                      decoration: BoxDecoration(
                        color: (checkedOut ? Colors.grey : Colors.green).withAlpha(20),
                        shape: BoxShape.circle,
                      ),
                      child: Icon(checkedOut ? Icons.check_circle_rounded : Icons.radio_button_checked_rounded,
                        color: checkedOut ? Colors.grey : Colors.green, size: 22),
                    ),
                    const SizedBox(width: 14),
                    Expanded(child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                      Text(r.userName, style: const TextStyle(fontWeight: FontWeight.w700, fontSize: 14)),
                      Text('In: ${DateFormat('HH:mm').format(r.checkIn)}${r.checkOut != null ? '  Out: ${DateFormat('HH:mm').format(r.checkOut!)}' : '  — working'}',
                        style: TextStyle(fontSize: 12, color: context.cs.onSurfaceVariant)),
                    ])),
                    Column(crossAxisAlignment: CrossAxisAlignment.end, children: [
                      Text('${worked.inHours}h ${worked.inMinutes % 60}m',
                        style: const TextStyle(fontWeight: FontWeight.w700, fontSize: 14)),
                      if (r.dailyWage > 0)
                        Text('Rs ${r.dailyWage.toStringAsFixed(0)}',
                          style: TextStyle(fontSize: 12, color: context.cs.primary, fontWeight: FontWeight.w600)),
                    ]),
                    const SizedBox(width: 10),
                    if (!checkedOut)
                      FilledButton(
                        onPressed: () async {
                          await ref.read(dbProvider).hRDao.checkOut(r.id, DateTime.now());
                          showSuccess(context, '${r.userName} checked out');
                        },
                        style: FilledButton.styleFrom(backgroundColor: Colors.orange, padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8)),
                        child: const Text('Check Out', style: TextStyle(fontSize: 12)),
                      ),
                  ]),
                );
              },
            ),
      )),
    ]);
  }

  void _showCheckInDialog(BuildContext context, WidgetRef ref, List<UserEntity> staff) {
    UserEntity? selected;
    showDialog(context: context, builder: (_) => StatefulBuilder(builder: (ctx, ss) => AlertDialog(
      title: const Text('Staff Check-In'),
      content: SizedBox(width: 320, child: Column(mainAxisSize: MainAxisSize.min, children: [
        DropdownButtonFormField<UserEntity>(
          decoration: const InputDecoration(labelText: 'Select staff member'),
          items: staff.map((u) => DropdownMenuItem(value: u, child: Text('${u.name} (${u.role.name})'))).toList(),
          onChanged: (v) => ss(() => selected = v),
        ),
        if (selected != null && selected!.wageType == WageType.daily) ...[
          const SizedBox(height: 8),
          Text('Daily wage: Rs ${selected!.salary.toStringAsFixed(0)}',
            style: TextStyle(color: context.cs.primary, fontWeight: FontWeight.w600)),
        ],
      ])),
      actions: [
        TextButton(onPressed: () => Navigator.pop(ctx), child: const Text('Cancel')),
        FilledButton(
          onPressed: selected == null ? null : () async {
            final db = ref.read(dbProvider);
            // Check if already checked in
            final existing = await db.hRDao.activeForUser(selected!.id);
            if (existing != null) {
              if (ctx.mounted) { Navigator.pop(ctx); showError(ctx, '${selected!.name} is already checked in'); }
              return;
            }
            await db.hRDao.checkIn(AttendanceCompanion.insert(
              userId: selected!.id, userName: selected!.name,
              checkIn: DateTime.now(),
              dailyWage: Value(selected!.wageType == WageType.daily ? selected!.salary : 0),
            ));
            if (ctx.mounted) { Navigator.pop(ctx); showSuccess(ctx, '${selected!.name} checked in'); }
          },
          child: const Text('Check In'),
        ),
      ],
    )));
  }
}

class _SalaryTab extends ConsumerStatefulWidget {
  const _SalaryTab();
  @override ConsumerState<_SalaryTab> createState() => _SalaryTabState();
}

class _SalaryTabState extends ConsumerState<_SalaryTab> {
  final _now = DateTime.now();

  @override
  Widget build(BuildContext context) {
    final staffAsync = ref.watch(staffProvider);

    return staffAsync.when(
      loading: () => const Center(child: CircularProgressIndicator()),
      error: (e, _) => Center(child: Text('Error: $e')),
      data: (staff) => ListView.builder(
        padding: const EdgeInsets.all(16),
        itemCount: staff.length,
        itemBuilder: (_, i) {
          final u = staff[i];
          if (u.salary <= 0) return const SizedBox.shrink();
          return AppCard(
            margin: const EdgeInsets.only(bottom: 10),
            child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              Row(children: [
                CircleAvatar(radius: 20, backgroundColor: context.cs.primary.withAlpha(20),
                  child: Text(u.name.substring(0,1).toUpperCase(), style: TextStyle(color: context.cs.primary, fontWeight: FontWeight.w700))),
                const SizedBox(width: 12),
                Expanded(child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                  Text(u.name, style: const TextStyle(fontWeight: FontWeight.w700, fontSize: 14)),
                  Text('${u.role.name} · ${u.wageType.name}', style: TextStyle(fontSize: 12, color: context.cs.onSurfaceVariant)),
                ])),
                Column(crossAxisAlignment: CrossAxisAlignment.end, children: [
                  Text('Rs ${u.salary.toStringAsFixed(0)}', style: const TextStyle(fontWeight: FontWeight.w800, fontSize: 16)),
                  Text('per ${u.wageType.name}', style: TextStyle(fontSize: 11, color: context.cs.onSurfaceVariant)),
                ]),
                const SizedBox(width: 12),
                FilledButton(
                  onPressed: () => _showPaySalaryDialog(u),
                  style: FilledButton.styleFrom(padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8)),
                  child: const Text('Pay', style: TextStyle(fontSize: 13)),
                ),
              ]),
              // Salary history
              FutureBuilder<List<SalaryPaymentRow>>(
                future: ref.watch(dbProvider).hRDao.salaryForUser(u.id),
                builder: (_, snap) {
                  final payments = snap.data ?? [];
                  if (payments.isEmpty) return const SizedBox.shrink();
                  final recent = payments.take(3).toList();
                  return Column(children: [
                    const Divider(height: 16),
                    ...recent.map((p) => Padding(
                      padding: const EdgeInsets.symmetric(vertical: 2),
                      child: Row(children: [
                        Icon(Icons.payments_rounded, size: 14, color: Colors.green),
                        const SizedBox(width: 6),
                        Text('${p.month}/${p.year}', style: const TextStyle(fontSize: 12)),
                        const Spacer(),
                        Text('Rs ${p.amount.toStringAsFixed(0)}',
                          style: const TextStyle(fontSize: 12, fontWeight: FontWeight.w600, color: Colors.green)),
                        const SizedBox(width: 8),
                        Text(DateFormat('dd MMM').format(p.paidAt), style: TextStyle(fontSize: 11, color: context.cs.onSurfaceVariant)),
                      ]),
                    )),
                  ]);
                },
              ),
            ]),
          );
        },
      ),
    );
  }

  void _showPaySalaryDialog(UserEntity u) {
    final amtCtrl = TextEditingController(text: u.salary.toStringAsFixed(0));
    final noteCtrl = TextEditingController();
    showDialog(context: context, builder: (_) => AlertDialog(
      title: Text('Pay salary — ${u.name}'),
      content: Column(mainAxisSize: MainAxisSize.min, children: [
        Text('${_now.year}/${_now.month} — ${u.wageType.name}',
          style: TextStyle(color: context.cs.onSurfaceVariant)),
        const SizedBox(height: 12),
        TextField(controller: amtCtrl, keyboardType: TextInputType.number,
          decoration: const InputDecoration(labelText: 'Amount', prefixText: 'Rs ')),
        const SizedBox(height: 10),
        TextField(controller: noteCtrl, decoration: const InputDecoration(labelText: 'Note (optional)')),
      ]),
      actions: [
        TextButton(onPressed: () => Navigator.pop(context), child: const Text('Cancel')),
        FilledButton(
          onPressed: () async {
            final amount = double.tryParse(amtCtrl.text) ?? 0;
            if (amount <= 0) return;
            await ref.read(dbProvider).hRDao.paySalary(SalaryPaymentsCompanion.insert(
              userId: u.id, userName: u.name,
              month: _now.month, year: _now.year, amount: amount,
              notes: Value(noteCtrl.text.isEmpty ? null : noteCtrl.text),
            ));
            if (mounted) { Navigator.pop(context); showSuccess(context, 'Salary paid to ${u.name}'); setState(() {}); }
          },
          child: const Text('Confirm payment'),
        ),
      ],
    ));
  }
}

// ═══════════════════════════════════════════════════════
// REPORTS SCREEN — Sales analytics, X & Z reports
// ═══════════════════════════════════════════════════════
class ReportsScreen extends ConsumerStatefulWidget {
  const ReportsScreen({super.key});
  @override ConsumerState<ReportsScreen> createState() => _ReportsScreenState();
}

class _ReportsScreenState extends ConsumerState<ReportsScreen>
    with SingleTickerProviderStateMixin {
  late final TabController _tab;
  DateTimeRange _range = DateTimeRange(
    start: DateTime(DateTime.now().year, DateTime.now().month, DateTime.now().day),
    end: DateTime.now(),
  );

  @override
  void initState() { super.initState(); _tab = TabController(length: 3, vsync: this); }
  @override void dispose() { _tab.dispose(); super.dispose(); }

  @override
  Widget build(BuildContext context) {
    return SideNav(child: Scaffold(
      appBar: AppBar(
        leading: IconButton(icon: const Icon(Icons.arrow_back), onPressed: () => context.go('/dashboard')),
        title: const Text('Reports & Analytics'),
        actions: [
          // Date range picker
          OutlinedButton.icon(
            icon: const Icon(Icons.date_range_rounded, size: 16),
            label: Text('${DateFormat('dd MMM').format(_range.start)} — ${DateFormat('dd MMM').format(_range.end)}'),
            onPressed: _pickDateRange,
          ),
          const SizedBox(width: 8),
          // Quick presets
          PopupMenuButton<String>(
            initialValue: 'today',
            onSelected: (v) => setState(() {
              final now = DateTime.now();
              final today = DateTime(now.year, now.month, now.day);
              _range = switch(v) {
                'today'   => DateTimeRange(start: today, end: now),
                'week'    => DateTimeRange(start: today.subtract(const Duration(days: 7)), end: now),
                'month'   => DateTimeRange(start: DateTime(now.year, now.month, 1), end: now),
                'year'    => DateTimeRange(start: DateTime(now.year, 1, 1), end: now),
                _         => DateTimeRange(start: today, end: now),
              };
            }),
            itemBuilder: (_) => const [
              PopupMenuItem(value: 'today',  child: Text('Today')),
              PopupMenuItem(value: 'week',   child: Text('Last 7 days')),
              PopupMenuItem(value: 'month',  child: Text('This month')),
              PopupMenuItem(value: 'year',   child: Text('This year')),
            ],
            child: const Padding(
              padding: EdgeInsets.symmetric(horizontal: 6),
              child: Icon(Icons.keyboard_arrow_down),
            ),
          ),
          const SizedBox(width: 8),
        ],
        bottom: TabBar(
          controller: _tab,
          tabs: const [Tab(text: 'Sales Summary'), Tab(text: 'X Report'), Tab(text: 'Z Report')],
        ),
      ),
      body: TabBarView(controller: _tab, children: [
        _SalesSummaryTab(range: _range),
        _XReportTab(range: _range),
        _ZReportTab(),
      ]),
    ));
  }

  Future<void> _pickDateRange() async {
    final picked = await showDateRangePicker(
      context: context,
      firstDate: DateTime(2020),
      lastDate: DateTime.now(),
      initialDateRange: _range,
    );
    if (picked != null) setState(() => _range = DateTimeRange(start: picked.start, end: picked.end.add(const Duration(hours: 23, minutes: 59))));
  }
}

class _SalesSummaryTab extends ConsumerWidget {
  const _SalesSummaryTab({required this.range});
  final DateTimeRange range;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final sym = ref.watch(settingsProvider).currencySymbol;
    return FutureBuilder<List<InvoiceRow>>(
      future: ref.watch(dbProvider).invoiceDao.forPeriod(range.start, range.end),
      builder: (_, snap) {
        if (!snap.hasData) return const Center(child: CircularProgressIndicator());
        final invoices = snap.data!;
        final totalSales    = invoices.fold(0.0, (s, i) => s + i.grandTotal);
        final totalDiscount = invoices.fold(0.0, (s, i) => s + i.discountValue);
        final totalTax      = invoices.fold(0.0, (s, i) => s + i.taxValue);
        final totalCash     = invoices.where((i) => i.paymentMethod == 'cash').fold(0.0, (s, i) => s + i.grandTotal);
        final totalCard     = invoices.where((i) => i.paymentMethod == 'card').fold(0.0, (s, i) => s + i.grandTotal);
        final totalWallet   = invoices.where((i) => i.paymentMethod == 'wallet').fold(0.0, (s, i) => s + i.grandTotal);
        final totalCredit   = invoices.where((i) => i.paymentMethod == 'credit').fold(0.0, (s, i) => s + i.grandTotal);
        final count = invoices.length;
        final avg = count > 0 ? totalSales / count : 0.0;

        return SingleChildScrollView(
          padding: const EdgeInsets.all(20),
          child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            // KPI grid
            GridView.count(
              shrinkWrap: true, physics: const NeverScrollableScrollPhysics(),
              crossAxisCount: 4, childAspectRatio: 2.2,
              crossAxisSpacing: 12, mainAxisSpacing: 12,
              children: [
                _ReportKPI('Total sales', '$sym ${totalSales.toStringAsFixed(0)}', Icons.trending_up, AppColors.orderOpen),
                _ReportKPI('Total orders', '$count', Icons.receipt_long, AppColors.orderKitchen),
                _ReportKPI('Avg. order', '$sym ${avg.toStringAsFixed(0)}', Icons.equalizer, AppColors.orderReady),
                _ReportKPI('Tax collected', '$sym ${totalTax.toStringAsFixed(0)}', Icons.percent, const Color(0xFF7C3AED)),
                _ReportKPI('Cash', '$sym ${totalCash.toStringAsFixed(0)}', Icons.payments, AppColors.orderOpen),
                _ReportKPI('Card', '$sym ${totalCard.toStringAsFixed(0)}', Icons.credit_card, AppColors.orderKitchen),
                _ReportKPI('Wallet', '$sym ${totalWallet.toStringAsFixed(0)}', Icons.account_balance_wallet, const Color(0xFF0EA5E9)),
                _ReportKPI('Credit', '$sym ${totalCredit.toStringAsFixed(0)}', Icons.person, const Color(0xFFDB2777)),
              ],
            ),
            const SizedBox(height: 20),
            // Payment breakdown chart
            if (totalSales > 0) AppCard(
              child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                Text('Payment breakdown', style: context.tt.titleMedium?.copyWith(fontWeight: FontWeight.w700)),
                const SizedBox(height: 16),
                SizedBox(height: 200, child: BarChart(BarChartData(
                  alignment: BarChartAlignment.spaceAround,
                  barGroups: [
                    _bar(0, totalCash,   AppColors.orderOpen),
                    _bar(1, totalCard,   AppColors.orderKitchen),
                    _bar(2, totalWallet, const Color(0xFF0EA5E9)),
                    _bar(3, totalCredit, const Color(0xFFDB2777)),
                  ],
                  titlesData: FlTitlesData(
                    topTitles: const AxisTitles(sideTitles: SideTitles(showTitles: false)),
                    rightTitles: const AxisTitles(sideTitles: SideTitles(showTitles: false)),
                    leftTitles: AxisTitles(sideTitles: SideTitles(
                      showTitles: true, reservedSize: 50,
                      getTitlesWidget: (v, _) => Text(v >= 1000 ? '${(v/1000).toStringAsFixed(0)}k' : v.toStringAsFixed(0), style: const TextStyle(fontSize: 10)),
                    )),
                    bottomTitles: AxisTitles(sideTitles: SideTitles(
                      showTitles: true, reservedSize: 22,
                      getTitlesWidget: (v, _) {
                        const labels = ['Cash', 'Card', 'Wallet', 'Credit'];
                        return Text(labels[v.toInt()], style: const TextStyle(fontSize: 11));
                      },
                    )),
                  ),
                  gridData: FlGridData(show: true, drawVerticalLine: false),
                  borderData: FlBorderData(show: false),
                ))),
              ]),
            ),
            const SizedBox(height: 16),
            // Invoice list
            Text('Invoices (${invoices.length})', style: context.tt.titleMedium?.copyWith(fontWeight: FontWeight.w700)),
            const SizedBox(height: 10),
            if (invoices.isEmpty)
              Center(child: Padding(
                padding: const EdgeInsets.all(24),
                child: Text('No invoices in this period', style: TextStyle(color: context.cs.onSurfaceVariant)),
              ))
            else
              ...invoices.take(50).map((inv) => Container(
                margin: const EdgeInsets.only(bottom: 6),
                padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
                decoration: BoxDecoration(color: context.cardBg, borderRadius: BorderRadius.circular(10), border: Border.all(color: context.border, width: 0.5)),
                child: Row(children: [
                  Text(inv.invoiceNumber, style: const TextStyle(fontWeight: FontWeight.w600, fontSize: 13)),
                  const SizedBox(width: 12),
                  Text(inv.tableNameCol, style: TextStyle(color: context.cs.onSurfaceVariant, fontSize: 12)),
                  const SizedBox(width: 8),
                  Text(inv.waiterName, style: TextStyle(color: context.cs.onSurfaceVariant, fontSize: 12)),
                  const Spacer(),
                  Text(DateFormat('dd/MM HH:mm').format(inv.createdAt), style: TextStyle(fontSize: 11, color: context.cs.onSurfaceVariant)),
                  const SizedBox(width: 14),
                  Text('$sym ${inv.grandTotal.toStringAsFixed(0)}', style: TextStyle(fontWeight: FontWeight.w700, fontSize: 14, color: context.cs.primary)),
                  const SizedBox(width: 10),
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 7, vertical: 2),
                    decoration: BoxDecoration(color: Colors.green.withAlpha(20), borderRadius: BorderRadius.circular(5)),
                    child: Text(inv.paymentMethod.toUpperCase(), style: const TextStyle(fontSize: 10, color: Colors.green, fontWeight: FontWeight.w700)),
                  ),
                ]),
              )),
          ]),
        );
      },
    );
  }

  BarChartGroupData _bar(int x, double y, Color color) => BarChartGroupData(x: x, barRods: [
    BarChartRodData(toY: y, color: color, width: 36, borderRadius: const BorderRadius.vertical(top: Radius.circular(5))),
  ]);
}

class _ReportKPI extends StatelessWidget {
  const _ReportKPI(this.label, this.value, this.icon, this.color);
  final String label, value; final IconData icon; final Color color;
  @override
  Widget build(BuildContext context) => Container(
    padding: const EdgeInsets.all(14),
    decoration: BoxDecoration(color: context.cardBg, borderRadius: BorderRadius.circular(12), border: Border.all(color: context.border, width: 0.5)),
    child: Row(children: [
      Icon(icon, color: color, size: 22),
      const SizedBox(width: 10),
      Expanded(child: Column(crossAxisAlignment: CrossAxisAlignment.start, mainAxisAlignment: MainAxisAlignment.center, children: [
        Text(value, style: const TextStyle(fontWeight: FontWeight.w800, fontSize: 16), overflow: TextOverflow.ellipsis),
        Text(label, style: TextStyle(fontSize: 11, color: context.cs.onSurfaceVariant)),
      ])),
    ]),
  );
}

class _XReportTab extends ConsumerWidget {
  const _XReportTab({required this.range});
  final DateTimeRange range;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final register = ref.watch(registerProvider);
    final sym = ref.watch(settingsProvider).currencySymbol;

    if (register == null) return Center(child: Column(mainAxisSize: MainAxisSize.min, children: [
      const Icon(Icons.lock_clock_rounded, size: 64, color: Colors.orange),
      const SizedBox(height: 14),
      const Text('No open register', style: TextStyle(fontWeight: FontWeight.w700, fontSize: 16)),
      const SizedBox(height: 6),
      Text('Open the cash register first', style: TextStyle(color: context.cs.onSurfaceVariant)),
      const SizedBox(height: 20),
      FilledButton(onPressed: () => context.go('/cash-register'), child: const Text('Go to register')),
    ]));

    return SingleChildScrollView(
      padding: const EdgeInsets.all(20),
      child: Center(child: ConstrainedBox(
        constraints: const BoxConstraints(maxWidth: 600),
        child: AppCard(
          child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            // Header
            Row(children: [
              Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                Text('X REPORT — Current Shift', style: context.tt.titleLarge?.copyWith(fontWeight: FontWeight.w800)),
                Text('No reset · reads current totals', style: TextStyle(color: context.cs.onSurfaceVariant, fontSize: 12)),
              ]),
              const Spacer(),
              FilledButton.icon(
                icon: const Icon(Icons.print_rounded, size: 16),
                label: const Text('Print X Report'),
                onPressed: () => PrintService.instance.printXReport(register),
              ),
            ]),
            const Divider(height: 28),
            _XRow('Shift opened', DateFormat('dd/MM/yyyy HH:mm').format(register.openedAt)),
            _XRow('Opened by', register.openedBy),
            _XRow('Report time', DateFormat('dd/MM/yyyy HH:mm').format(DateTime.now())),
            const Divider(height: 20),
            _XSection('SALES', [
              ('Total orders', '${register.totalOrders}'),
              ('Total sales', '$sym ${register.totalSales.toStringAsFixed(0)}'),
              ('Cash sales', '$sym ${register.totalCashSales.toStringAsFixed(0)}'),
              ('Card sales', '$sym ${register.totalCardSales.toStringAsFixed(0)}'),
              ('Wallet sales', '$sym ${register.totalWalletSales.toStringAsFixed(0)}'),
              ('Credit sales', '$sym ${register.totalCreditSales.toStringAsFixed(0)}'),
            ]),
            const SizedBox(height: 14),
            _XSection('DEDUCTIONS', [
              ('Total discounts', '$sym ${register.totalDiscounts.toStringAsFixed(0)}'),
              ('Tax collected', '$sym ${register.totalTax.toStringAsFixed(0)}'),
              ('Total expenses', '$sym ${register.totalExpenses.toStringAsFixed(0)}'),
              ('Void orders', '${register.totalVoids}'),
            ]),
            const SizedBox(height: 14),
            _XSection('KITCHEN', [
              ('Kitchen tickets printed', '${register.totalKitchenTickets}'),
            ]),
            const SizedBox(height: 14),
            _XSection('CASH DRAWER', [
              ('Opening cash', '$sym ${register.openingCash.toStringAsFixed(0)}'),
              ('Cash in', '$sym ${register.cashIn.toStringAsFixed(0)}'),
              ('Cash out', '$sym ${register.cashOut.toStringAsFixed(0)}'),
              ('Expected cash', '$sym ${register.expectedCash.toStringAsFixed(0)}'),
            ]),
          ]),
        ),
      )),
    );
  }
}

class _XRow extends StatelessWidget {
  const _XRow(this.label, this.value);
  final String label, value;
  @override
  Widget build(BuildContext context) => Padding(
    padding: const EdgeInsets.symmetric(vertical: 3),
    child: Row(children: [
      Text(label, style: TextStyle(fontSize: 13, color: context.cs.onSurfaceVariant)),
      const Spacer(),
      Text(value, style: const TextStyle(fontSize: 13, fontWeight: FontWeight.w600)),
    ]),
  );
}

class _XSection extends StatelessWidget {
  const _XSection(this.title, this.rows);
  final String title;
  final List<(String, String)> rows;
  @override
  Widget build(BuildContext context) => Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
    Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
      decoration: BoxDecoration(color: context.cs.primary.withAlpha(18), borderRadius: BorderRadius.circular(6)),
      child: Text(title, style: TextStyle(fontSize: 11, fontWeight: FontWeight.w700, color: context.cs.primary, letterSpacing: 0.6)),
    ),
    const SizedBox(height: 6),
    ...rows.map((r) => _XRow(r.$1, r.$2)),
  ]);
}

class _ZReportTab extends ConsumerStatefulWidget {
  @override ConsumerState<_ZReportTab> createState() => _ZReportTabState();
}

class _ZReportTabState extends ConsumerState<_ZReportTab> {
  final _closingCashCtrl = TextEditingController();
  bool _closing = false;

  @override void dispose() { _closingCashCtrl.dispose(); super.dispose(); }

  @override
  Widget build(BuildContext context) {
    final register = ref.watch(registerProvider);
    final user = ref.watch(authProvider).user;
    final sym = ref.watch(settingsProvider).currencySymbol;

    if (register == null) return Center(child: Column(mainAxisSize: MainAxisSize.min, children: [
      const Icon(Icons.check_circle_rounded, size: 64, color: Colors.green),
      const SizedBox(height: 14),
      const Text('Register is already closed', style: TextStyle(fontWeight: FontWeight.w700, fontSize: 16)),
      const SizedBox(height: 6),
      Text('Open a new shift from the Cash Register screen', style: TextStyle(color: context.cs.onSurfaceVariant)),
      const SizedBox(height: 20),
      FilledButton(onPressed: () => context.go('/cash-register'), child: const Text('Go to register')),
    ]));

    _closingCashCtrl.text = _closingCashCtrl.text.isEmpty
        ? register.expectedCash.toStringAsFixed(0)
        : _closingCashCtrl.text;

    final closingCash = double.tryParse(_closingCashCtrl.text) ?? 0;
    final diff = closingCash - register.expectedCash;

    return SingleChildScrollView(
      padding: const EdgeInsets.all(20),
      child: Center(child: ConstrainedBox(
        constraints: const BoxConstraints(maxWidth: 600),
        child: Column(children: [
          // Warning banner
          Container(
            padding: const EdgeInsets.all(14),
            margin: const EdgeInsets.only(bottom: 16),
            decoration: BoxDecoration(
              color: Colors.red.withAlpha(15), borderRadius: BorderRadius.circular(12),
              border: Border.all(color: Colors.red.withAlpha(60)),
            ),
            child: Row(children: [
              const Icon(Icons.warning_amber_rounded, color: Colors.red, size: 22),
              const SizedBox(width: 10),
              Expanded(child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                const Text('Z Report — End of Day Closing', style: TextStyle(fontWeight: FontWeight.w700, color: Colors.red)),
                Text('Running this will close the shift and reset all counters.', style: TextStyle(fontSize: 12, color: context.cs.onSurfaceVariant)),
              ])),
            ]),
          ),
          AppCard(child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            Text('Day Closing Summary', style: context.tt.titleLarge?.copyWith(fontWeight: FontWeight.w800)),
            const Divider(height: 24),
            _XSection('SALES', [
              ('Total orders', '${register.totalOrders}'),
              ('Total sales', '$sym ${register.totalSales.toStringAsFixed(0)}'),
              ('Discounts given', '$sym ${register.totalDiscounts.toStringAsFixed(0)}'),
              ('Tax collected', '$sym ${register.totalTax.toStringAsFixed(0)}'),
            ]),
            const SizedBox(height: 14),
            _XSection('PAYMENT BREAKDOWN', [
              ('Cash', '$sym ${register.totalCashSales.toStringAsFixed(0)}'),
              ('Card', '$sym ${register.totalCardSales.toStringAsFixed(0)}'),
              ('Wallet', '$sym ${register.totalWalletSales.toStringAsFixed(0)}'),
              ('Credit', '$sym ${register.totalCreditSales.toStringAsFixed(0)}'),
            ]),
            const SizedBox(height: 14),
            _XSection('KITCHEN & VOIDS', [
              ('Kitchen tickets printed', '${register.totalKitchenTickets}'),
              ('Void transactions', '${register.totalVoids}'),
            ]),
            const SizedBox(height: 14),
            _XSection('CASH RECONCILIATION', [
              ('Opening cash', '$sym ${register.openingCash.toStringAsFixed(0)}'),
              ('Cash sales', '$sym ${register.totalCashSales.toStringAsFixed(0)}'),
              ('Cash in', '$sym ${register.cashIn.toStringAsFixed(0)}'),
              ('Cash out', '$sym ${register.cashOut.toStringAsFixed(0)}'),
              ('Expenses', '$sym ${register.totalExpenses.toStringAsFixed(0)}'),
              ('Expected in drawer', '$sym ${register.expectedCash.toStringAsFixed(0)}'),
            ]),
            const Divider(height: 24),
            // Closing cash input
            Text('Enter actual cash in drawer:', style: context.tt.titleMedium?.copyWith(fontWeight: FontWeight.w600)),
            const SizedBox(height: 8),
            TextField(
              controller: _closingCashCtrl,
              keyboardType: TextInputType.number,
              inputFormatters: [FilteringTextInputFormatter.allow(RegExp(r'[\d.]'))],
              onChanged: (_) => setState(() {}),
              decoration: InputDecoration(
                prefixText: '$sym ',
                helperText: 'Expected: $sym ${register.expectedCash.toStringAsFixed(0)}',
                suffixIcon: Padding(
                  padding: const EdgeInsets.only(right: 12),
                  child: Text(
                    '${diff >= 0 ? '+' : ''}$sym ${diff.toStringAsFixed(0)}',
                    style: TextStyle(fontWeight: FontWeight.w700, color: diff.abs() < 50 ? Colors.green : Colors.red),
                  ),
                ),
                suffixIconConstraints: const BoxConstraints(minWidth: 0),
              ),
            ),
            const SizedBox(height: 20),
            Row(children: [
              Expanded(child: OutlinedButton.icon(
                icon: const Icon(Icons.print_rounded, size: 16),
                label: const Text('Preview Z Report'),
                onPressed: () => PrintService.instance.printZReport(register, closingCash),
              )),
              const SizedBox(width: 12),
              Expanded(child: FilledButton.icon(
                icon: _closing ? const SizedBox(width: 16, height: 16, child: CircularProgressIndicator(strokeWidth: 2, color: Colors.white)) : const Icon(Icons.lock_rounded, size: 16),
                label: const Text('Close Shift & Run Z Report', style: TextStyle(fontWeight: FontWeight.w700)),
                onPressed: _closing ? null : () => _runZReport(register, user?.name ?? 'System', closingCash),
                style: FilledButton.styleFrom(backgroundColor: Colors.red, padding: const EdgeInsets.symmetric(vertical: 14)),
              )),
            ]),
          ])),
        ]),
      )),
    );
  }

  Future<void> _runZReport(CashRegisterEntity reg, String closedBy, double closingCash) async {
    final ok = await confirm(
      context, 'Close shift?',
      'This will print the Z report and close the current shift. All counters will be reset.',
      danger: true,
    );
    if (!ok) return;
    setState(() => _closing = true);

    // Print first
    await PrintService.instance.printZReport(reg, closingCash);
    // Then close
    await ref.read(registerProvider.notifier).closeRegister(closedBy, closingCash);

    if (mounted) {
      setState(() => _closing = false);
      showSuccess(context, 'Shift closed. Z Report printed.');
      context.go('/dashboard');
    }
  }
}

// ═══════════════════════════════════════════════════════
// EXPENSE TRACKER SCREEN
// ═══════════════════════════════════════════════════════
class ExpenseTrackerScreen extends ConsumerStatefulWidget {
  const ExpenseTrackerScreen({super.key});

  @override
  ConsumerState<ExpenseTrackerScreen> createState() => _ExpenseTrackerScreenState();
}

class _ExpenseTrackerScreenState extends ConsumerState<ExpenseTrackerScreen> {
  late DateTimeRange _range;

  static const _categories = [
    'General',
    'Rent',
    'Utilities',
    'Supplies',
    'Groceries',
    'Maintenance',
    'Fuel',
    'Staff meal',
    'Delivery',
    'Marketing',
    'Other',
  ];

  @override
  void initState() {
    super.initState();
    final now = DateTime.now();
    final start = DateTime(now.year, now.month, 1);
    _range = DateTimeRange(start: start, end: now);
  }

  @override
  Widget build(BuildContext context) {
    final sym = ref.watch(settingsProvider).currencySymbol;

    return SideNav(child: Scaffold(
      appBar: AppBar(
        leading: IconButton(icon: const Icon(Icons.arrow_back), onPressed: () => context.go('/dashboard')),
        title: const Text('Expense Tracker'),
        actions: [
          OutlinedButton.icon(
            icon: const Icon(Icons.date_range_rounded, size: 16),
            label: Text('${DateFormat('dd MMM').format(_range.start)} - ${DateFormat('dd MMM').format(_range.end)}'),
            onPressed: _pickDateRange,
          ),
          const SizedBox(width: 8),
          FilledButton.icon(
            icon: const Icon(Icons.add_rounded, size: 18),
            label: const Text('Add Expense'),
            onPressed: _showAddExpenseDialog,
          ),
          const SizedBox(width: 12),
        ],
      ),
      body: FutureBuilder<List<ExpenseRow>>(
        future: ref.watch(dbProvider).registerDao.expensesForPeriod(_range.start, _range.end),
        builder: (_, snap) {
          if (!snap.hasData) return const Center(child: CircularProgressIndicator());
          final expenses = snap.data!;
          final total = expenses.fold(0.0, (sum, e) => sum + e.amount);
          final byCategory = <String, double>{};
          for (final expense in expenses) {
            byCategory[expense.category] = (byCategory[expense.category] ?? 0) + expense.amount;
          }
          final categoryRows = byCategory.entries.toList()
            ..sort((a, b) => b.value.compareTo(a.value));

          return SingleChildScrollView(
            padding: const EdgeInsets.all(20),
            child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              GridView.count(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                crossAxisCount: 4,
                childAspectRatio: 2.3,
                crossAxisSpacing: 12,
                mainAxisSpacing: 12,
                children: [
                  _ReportKPI('Total expenses', '$sym ${total.toStringAsFixed(0)}', Icons.receipt_long, AppColors.error),
                  _ReportKPI('Records', '${expenses.length}', Icons.list_alt_rounded, AppColors.orderOpen),
                  _ReportKPI('Categories', '${byCategory.length}', Icons.category_rounded, AppColors.orderKitchen),
                  _ReportKPI('Highest category', categoryRows.isEmpty ? '-' : categoryRows.first.key, Icons.trending_up_rounded, AppColors.warning),
                ],
              ),
              const SizedBox(height: 18),
              Row(crossAxisAlignment: CrossAxisAlignment.start, children: [
                Expanded(
                  flex: 3,
                  child: AppCard(child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                    Text('Expenses', style: context.tt.titleMedium?.copyWith(fontWeight: FontWeight.w800)),
                    const SizedBox(height: 12),
                    if (expenses.isEmpty)
                      Padding(
                        padding: const EdgeInsets.all(24),
                        child: Center(child: Text('No expenses in this period', style: TextStyle(color: context.cs.onSurfaceVariant))),
                      )
                    else
                      ...expenses.map((expense) => _ExpenseRowTile(expense: expense, sym: sym)),
                  ])),
                ),
                const SizedBox(width: 16),
                Expanded(
                  flex: 2,
                  child: AppCard(child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                    Text('By category', style: context.tt.titleMedium?.copyWith(fontWeight: FontWeight.w800)),
                    const SizedBox(height: 12),
                    if (categoryRows.isEmpty)
                      Text('No category data', style: TextStyle(color: context.cs.onSurfaceVariant))
                    else
                      ...categoryRows.map((entry) => Padding(
                        padding: const EdgeInsets.symmetric(vertical: 6),
                        child: Row(children: [
                          Container(width: 8, height: 8, decoration: BoxDecoration(color: _categoryColor(entry.key), shape: BoxShape.circle)),
                          const SizedBox(width: 8),
                          Expanded(child: Text(entry.key, style: const TextStyle(fontWeight: FontWeight.w600, fontSize: 13))),
                          Text('$sym ${entry.value.toStringAsFixed(0)}', style: const TextStyle(fontWeight: FontWeight.w800, fontSize: 13)),
                        ]),
                      )),
                  ])),
                ),
              ]),
            ]),
          );
        },
      ),
    ));
  }

  Future<void> _pickDateRange() async {
    final picked = await showDateRangePicker(
      context: context,
      firstDate: DateTime(2020),
      lastDate: DateTime.now(),
      initialDateRange: _range,
    );
    if (picked != null) {
      setState(() => _range = DateTimeRange(
        start: picked.start,
        end: picked.end.add(const Duration(hours: 23, minutes: 59)),
      ));
    }
  }

  void _showAddExpenseDialog() {
    final amountCtrl = TextEditingController();
    final descCtrl = TextEditingController();
    final categoryCtrl = TextEditingController(text: _categories.first);
    bool saving = false;

    showDialog(context: context, builder: (_) => StatefulBuilder(builder: (ctx, ss) => AlertDialog(
      title: const Text('Add Expense'),
      content: SizedBox(width: 420, child: Column(mainAxisSize: MainAxisSize.min, children: [
        TextField(
          controller: categoryCtrl,
          decoration: const InputDecoration(labelText: 'Expense type'),
        ),
        const SizedBox(height: 8),
        Align(
          alignment: Alignment.centerLeft,
          child: Wrap(
            spacing: 6,
            runSpacing: 6,
            children: _categories.map((category) => ActionChip(
              label: Text(category),
              visualDensity: VisualDensity.compact,
              onPressed: () => ss(() => categoryCtrl.text = category),
            )).toList(),
          ),
        ),
        const SizedBox(height: 12),
        TextField(
          controller: amountCtrl,
          autofocus: true,
          keyboardType: TextInputType.number,
          inputFormatters: [FilteringTextInputFormatter.allow(RegExp(r'[\d.]'))],
          decoration: InputDecoration(labelText: 'Amount', prefixText: '${ref.read(settingsProvider).currencySymbol} '),
        ),
        const SizedBox(height: 12),
        TextField(
          controller: descCtrl,
          minLines: 2,
          maxLines: 3,
          decoration: const InputDecoration(labelText: 'Description / note'),
        ),
      ])),
      actions: [
        TextButton(onPressed: saving ? null : () => Navigator.pop(ctx), child: const Text('Cancel')),
        FilledButton.icon(
          icon: saving
              ? const SizedBox(width: 16, height: 16, child: CircularProgressIndicator(strokeWidth: 2, color: Colors.white))
              : const Icon(Icons.save_rounded, size: 16),
          label: Text(saving ? 'Saving...' : 'Save Expense'),
          onPressed: saving ? null : () async {
            final amount = double.tryParse(amountCtrl.text) ?? 0;
            final category = categoryCtrl.text.trim();
            if (category.isEmpty) return;
            if (amount <= 0) return;
            ss(() => saving = true);
            await _saveExpense(category, amount, descCtrl.text.trim());
            if (ctx.mounted) Navigator.pop(ctx);
          },
        ),
      ],
    )));
  }

  Future<void> _saveExpense(String category, double amount, String description) async {
    final db = ref.read(dbProvider);
    final user = ref.read(authProvider).user;
    final register = await db.registerDao.openRegister();

    await db.registerDao.addExpense(ExpensesCompanion.insert(
      category: category,
      amount: amount,
      description: description.isEmpty ? category : description,
      paidBy: user?.name ?? 'System',
      registerId: Value(register?.id),
    ));

    if (register != null) {
      await db.registerDao.update_(register.id, CashRegistersCompanion(
        totalExpenses: Value(register.totalExpenses + amount),
      ));
      ref.invalidate(registerProvider);
    }

    if (mounted) {
      setState(() {});
      showSuccess(context, 'Expense saved');
    }
  }

  Color _categoryColor(String category) {
    final colors = [
      AppColors.error,
      AppColors.orderOpen,
      AppColors.orderKitchen,
      AppColors.orderReady,
      const Color(0xFF7C3AED),
      const Color(0xFF0EA5E9),
      const Color(0xFFDB2777),
    ];
    return colors[category.hashCode.abs() % colors.length];
  }
}

class _ExpenseRowTile extends StatelessWidget {
  const _ExpenseRowTile({required this.expense, required this.sym});
  final ExpenseRow expense;
  final String sym;

  @override
  Widget build(BuildContext context) => Container(
    margin: const EdgeInsets.only(bottom: 8),
    padding: const EdgeInsets.all(12),
    decoration: BoxDecoration(
      color: context.bg,
      borderRadius: BorderRadius.circular(10),
      border: Border.all(color: context.border, width: 0.5),
    ),
    child: Row(children: [
      Container(
        width: 38,
        height: 38,
        decoration: BoxDecoration(color: AppColors.error.withAlpha(18), shape: BoxShape.circle),
        child: const Icon(Icons.receipt_long_rounded, color: AppColors.error, size: 20),
      ),
      const SizedBox(width: 12),
      Expanded(child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        Row(children: [
          Text(expense.category, style: const TextStyle(fontWeight: FontWeight.w800, fontSize: 13)),
          const SizedBox(width: 8),
          Text(DateFormat('dd/MM/yyyy HH:mm').format(expense.createdAt), style: TextStyle(fontSize: 11, color: context.cs.onSurfaceVariant)),
        ]),
        const SizedBox(height: 3),
        Text(expense.description, style: TextStyle(fontSize: 12, color: context.cs.onSurfaceVariant), maxLines: 2, overflow: TextOverflow.ellipsis),
        const SizedBox(height: 3),
        Text('Paid by ${expense.paidBy}', style: TextStyle(fontSize: 11, color: context.cs.onSurfaceVariant)),
      ])),
      const SizedBox(width: 12),
      Text('$sym ${expense.amount.toStringAsFixed(0)}', style: const TextStyle(fontWeight: FontWeight.w900, fontSize: 15, color: AppColors.error)),
    ]),
  );
}

// ═══════════════════════════════════════════════════════
// CASH REGISTER SCREEN
// ═══════════════════════════════════════════════════════
class CashRegisterScreen extends ConsumerStatefulWidget {
  const CashRegisterScreen({super.key});
  @override ConsumerState<CashRegisterScreen> createState() => _CashRegisterScreenState();
}

class _CashRegisterScreenState extends ConsumerState<CashRegisterScreen> {
  final _openCashCtrl = TextEditingController(text: '0');

  @override void dispose() { _openCashCtrl.dispose(); super.dispose(); }

  @override
  Widget build(BuildContext context) {
    final register = ref.watch(registerProvider);
    final user = ref.watch(authProvider).user;
    final sym = ref.watch(settingsProvider).currencySymbol;

    return SideNav(child: Scaffold(
      appBar: AppBar(
        leading: IconButton(icon: const Icon(Icons.arrow_back), onPressed: () => context.go('/dashboard')),
        title: const Text('Cash Register'),
      ),
      body: register == null ? _OpenRegisterView(ctrl: _openCashCtrl, user: user, sym: sym) : _OpenRegisterPanel(register: register, user: user, sym: sym),
    ));
  }
}

class _OpenRegisterView extends ConsumerWidget {
  const _OpenRegisterView({required this.ctrl, required this.user, required this.sym});
  final TextEditingController ctrl; final UserEntity? user; final String sym;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Center(child: AppCard(
      padding: const EdgeInsets.all(32),
      child: SizedBox(width: 380, child: Column(mainAxisSize: MainAxisSize.min, crossAxisAlignment: CrossAxisAlignment.center, children: [
        Container(
          width: 80, height: 80,
          decoration: BoxDecoration(color: Colors.green.withAlpha(20), shape: BoxShape.circle),
          child: const Icon(Icons.point_of_sale_rounded, color: Colors.green, size: 44),
        ),
        const SizedBox(height: 20),
        const Text('Open Cash Register', style: TextStyle(fontSize: 22, fontWeight: FontWeight.w800)),
        const SizedBox(height: 6),
        Text('Enter the opening cash amount to start the shift', style: TextStyle(color: context.cs.onSurfaceVariant, fontSize: 13)),
        const SizedBox(height: 24),
        TextField(
          controller: ctrl,
          keyboardType: TextInputType.number,
          inputFormatters: [FilteringTextInputFormatter.allow(RegExp(r'[\d.]'))],
          decoration: InputDecoration(labelText: 'Opening cash amount', prefixText: '$sym ', prefixIcon: const Icon(Icons.payments_rounded)),
          style: const TextStyle(fontSize: 18, fontWeight: FontWeight.w700),
          textAlign: TextAlign.center,
        ),
        const SizedBox(height: 24),
        SizedBox(
          width: double.infinity,
          child: FilledButton.icon(
            icon: const Icon(Icons.lock_open_rounded, size: 20),
            label: const Text('Open Register', style: TextStyle(fontSize: 16, fontWeight: FontWeight.w700)),
            onPressed: () async {
              final amount = double.tryParse(ctrl.text) ?? 0;
              await ref.read(registerProvider.notifier).openRegister(user?.name ?? 'Unknown', amount);
              if (context.mounted) showSuccess(context, 'Register opened');
            },
            style: FilledButton.styleFrom(backgroundColor: Colors.green, padding: const EdgeInsets.symmetric(vertical: 14)),
          ),
        ),
      ])),
    ));
  }
}

class _OpenRegisterPanel extends ConsumerWidget {
  const _OpenRegisterPanel({required this.register, required this.user, required this.sym});
  final CashRegisterEntity register; final UserEntity? user; final String sym;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(20),
      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        // Register status
        Row(children: [
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
            decoration: BoxDecoration(color: Colors.green.withAlpha(20), borderRadius: BorderRadius.circular(10), border: Border.all(color: Colors.green.withAlpha(60))),
            child: Row(children: [
              Container(width: 8, height: 8, decoration: const BoxDecoration(color: Colors.green, shape: BoxShape.circle)),
              const SizedBox(width: 8),
              Text('Register OPEN since ${DateFormat('HH:mm').format(register.openedAt)}',
                style: const TextStyle(color: Colors.green, fontWeight: FontWeight.w700)),
            ]),
          ),
          const Spacer(),
          OutlinedButton.icon(
            icon: const Icon(Icons.bar_chart_rounded, size: 16),
            label: const Text('View Reports'),
            onPressed: () => context.go('/reports'),
          ),
          const SizedBox(width: 8),
          FilledButton.icon(
            icon: const Icon(Icons.lock_rounded, size: 16),
            label: const Text('Close Register (Z Report)'),
            onPressed: () => context.go('/reports'),
            style: FilledButton.styleFrom(backgroundColor: Colors.red),
          ),
        ]),
        const SizedBox(height: 20),
        // Stats grid
        GridView.count(
          shrinkWrap: true, physics: const NeverScrollableScrollPhysics(),
          crossAxisCount: 4, childAspectRatio: 2.2,
          crossAxisSpacing: 12, mainAxisSpacing: 12,
          children: [
            _ReportKPI('Total sales', '$sym ${register.totalSales.toStringAsFixed(0)}', Icons.trending_up, AppColors.orderOpen),
            _ReportKPI('Total orders', '${register.totalOrders}', Icons.receipt_long, AppColors.orderKitchen),
            _ReportKPI('Kitchen tickets', '${register.totalKitchenTickets}', Icons.kitchen, const Color(0xFF7C3AED)),
            _ReportKPI('Expected cash', '$sym ${register.expectedCash.toStringAsFixed(0)}', Icons.payments, Colors.green),
          ],
        ),
        const SizedBox(height: 20),
        Row(crossAxisAlignment: CrossAxisAlignment.start, children: [
          // Cash operations
          Expanded(child: AppCard(child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            Text('Cash operations', style: context.tt.titleMedium?.copyWith(fontWeight: FontWeight.w700)),
            const SizedBox(height: 14),
            _CashOpRow(label: 'Cash In', icon: Icons.add_circle_rounded, color: Colors.green,
              onTap: () => _showCashOpDialog(context, ref, 'in')),
            const Divider(height: 1),
            _CashOpRow(label: 'Cash Out', icon: Icons.remove_circle_rounded, color: Colors.red,
              onTap: () => _showCashOpDialog(context, ref, 'out')),
            const Divider(height: 1),
            _CashOpRow(label: 'Add Expense', icon: Icons.money_off_rounded, color: Colors.orange,
              onTap: () => _showExpenseDialog(context, ref)),
          ]))),
          const SizedBox(width: 16),
          // Today's breakdown
          Expanded(child: AppCard(child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            Text('Today\'s breakdown', style: context.tt.titleMedium?.copyWith(fontWeight: FontWeight.w700)),
            const SizedBox(height: 12),
            _XRow('Opening cash', '$sym ${register.openingCash.toStringAsFixed(0)}'),
            _XRow('Cash sales',   '$sym ${register.totalCashSales.toStringAsFixed(0)}'),
            _XRow('Card sales',   '$sym ${register.totalCardSales.toStringAsFixed(0)}'),
            _XRow('Wallet',       '$sym ${register.totalWalletSales.toStringAsFixed(0)}'),
            _XRow('Cash in',      '$sym ${register.cashIn.toStringAsFixed(0)}'),
            _XRow('Cash out',     '-$sym ${register.cashOut.toStringAsFixed(0)}'),
            _XRow('Expenses',     '-$sym ${register.totalExpenses.toStringAsFixed(0)}'),
            const Divider(height: 12),
            Row(children: [
              const Text('Expected cash', style: TextStyle(fontWeight: FontWeight.w700)),
              const Spacer(),
              Text('$sym ${register.expectedCash.toStringAsFixed(0)}',
                style: const TextStyle(fontWeight: FontWeight.w800, fontSize: 16, color: Colors.green)),
            ]),
          ]))),
          const SizedBox(width: 16),
          // Expenses list
          Expanded(child: AppCard(child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            Text('Expenses today', style: context.tt.titleMedium?.copyWith(fontWeight: FontWeight.w700)),
            const SizedBox(height: 10),
            FutureBuilder<List<ExpenseRow>>(
              future: ref.watch(dbProvider).registerDao.expensesForRegister(register.id),
              builder: (_, snap) {
                final expenses = snap.data ?? [];
                if (expenses.isEmpty) return Padding(
                  padding: const EdgeInsets.all(12),
                  child: Text('No expenses recorded', style: TextStyle(color: context.cs.onSurfaceVariant, fontSize: 13)),
                );
                return Column(children: expenses.map((e) => Padding(
                  padding: const EdgeInsets.symmetric(vertical: 4),
                  child: Row(children: [
                    Icon(Icons.receipt_outlined, size: 14, color: Colors.orange),
                    const SizedBox(width: 6),
                    Expanded(child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                      Text(e.category, style: const TextStyle(fontWeight: FontWeight.w500, fontSize: 12)),
                      Text(e.description, style: TextStyle(fontSize: 11, color: context.cs.onSurfaceVariant), maxLines: 1, overflow: TextOverflow.ellipsis),
                    ])),
                    Text('$sym ${e.amount.toStringAsFixed(0)}', style: const TextStyle(fontSize: 13, fontWeight: FontWeight.w600, color: Colors.orange)),
                  ]),
                )).toList());
              },
            ),
          ]))),
        ]),
      ]),
    );
  }

  void _showCashOpDialog(BuildContext context, WidgetRef ref, String type) {
    final ctrl = TextEditingController();
    showDialog(context: context, builder: (_) => AlertDialog(
      title: Text(type == 'in' ? 'Cash In' : 'Cash Out'),
      content: TextField(controller: ctrl, autofocus: true, keyboardType: TextInputType.number,
        decoration: InputDecoration(labelText: 'Amount', prefixText: '$sym ')),
      actions: [
        TextButton(onPressed: () => Navigator.pop(context), child: const Text('Cancel')),
        FilledButton(
          onPressed: () async {
            final amount = double.tryParse(ctrl.text) ?? 0;
            if (amount <= 0) return;
            if (type == 'in') await ref.read(registerProvider.notifier).cashIn(amount, user?.name ?? 'System');
            else await ref.read(registerProvider.notifier).cashOut(amount, user?.name ?? 'System');
            if (context.mounted) { Navigator.pop(context); showSuccess(context, 'Done'); }
          },
          child: Text(type == 'in' ? 'Add cash' : 'Remove cash'),
        ),
      ],
    ));
  }

  void _showExpenseDialog(BuildContext context, WidgetRef ref) {
    final amtCtrl  = TextEditingController();
    final descCtrl = TextEditingController();
    String category = 'General';
    showDialog(context: context, builder: (_) => StatefulBuilder(builder: (ctx, ss) => AlertDialog(
      title: const Text('Add expense'),
      content: Column(mainAxisSize: MainAxisSize.min, children: [
        DropdownButtonFormField<String>(
          value: category,
          decoration: const InputDecoration(labelText: 'Category'),
          items: ['General', 'Utilities', 'Staff meal', 'Supplies', 'Rent', 'Maintenance', 'Other'].map((c) => DropdownMenuItem(value: c, child: Text(c))).toList(),
          onChanged: (v) => ss(() => category = v!),
        ),
        const SizedBox(height: 10),
        TextField(controller: amtCtrl, autofocus: true, keyboardType: TextInputType.number,
          decoration: InputDecoration(labelText: 'Amount', prefixText: '$sym ')),
        const SizedBox(height: 10),
        TextField(controller: descCtrl, decoration: const InputDecoration(labelText: 'Description')),
      ]),
      actions: [
        TextButton(onPressed: () => Navigator.pop(ctx), child: const Text('Cancel')),
        FilledButton(
          onPressed: () async {
            final amount = double.tryParse(amtCtrl.text) ?? 0;
            if (amount <= 0) return;
            await ref.read(registerProvider.notifier).addExpense(category, amount, descCtrl.text, user?.name ?? 'System');
            if (ctx.mounted) { Navigator.pop(ctx); showSuccess(ctx, 'Expense recorded'); }
          },
          child: const Text('Add expense'),
        ),
      ],
    )));
  }
}

class _CashOpRow extends StatelessWidget {
  const _CashOpRow({required this.label, required this.icon, required this.color, required this.onTap});
  final String label; final IconData icon; final Color color; final VoidCallback onTap;
  @override
  Widget build(BuildContext context) => ListTile(
    leading: Icon(icon, color: color),
    title: Text(label, style: const TextStyle(fontWeight: FontWeight.w600)),
    trailing: const Icon(Icons.chevron_right_rounded),
    onTap: onTap,
    contentPadding: const EdgeInsets.symmetric(horizontal: 4, vertical: 2),
  );
}

// ═══════════════════════════════════════════════════════
// SETTINGS SCREEN
// ═══════════════════════════════════════════════════════
class SettingsScreen extends ConsumerStatefulWidget {
  const SettingsScreen({super.key});
  @override ConsumerState<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends ConsumerState<SettingsScreen> {
  int _section = 0;

  static const _sections = [
    (Icons.store_outlined, 'Restaurant Info'),
    (Icons.receipt_long_outlined, 'Receipt & Tax'),
    (Icons.palette_outlined, 'Theme'),
    (Icons.backup_outlined, 'Backup'),
    (Icons.people_outlined, 'User Accounts'),
  ];

  @override
  Widget build(BuildContext context) {
    final settings = ref.watch(settingsProvider);
    return SideNav(child: Scaffold(
      appBar: AppBar(
        leading: IconButton(icon: const Icon(Icons.arrow_back), onPressed: () => context.go('/dashboard')),
        title: const Text('Settings'),
      ),
      body: Row(children: [
        // Sidebar
        SizedBox(
          width: 220,
          child: ListView.builder(
            padding: const EdgeInsets.all(8),
            itemCount: _sections.length,
            itemBuilder: (_, i) {
              final (icon, label) = _sections[i];
              final sel = i == _section;
              return GestureDetector(
                onTap: () => setState(() => _section = i),
                child: AnimatedContainer(
                  duration: const Duration(milliseconds: 200),
                  margin: const EdgeInsets.only(bottom: 4),
                  padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
                  decoration: BoxDecoration(
                    color: sel ? context.cs.primary.withAlpha(20) : Colors.transparent,
                    borderRadius: BorderRadius.circular(10),
                    border: Border.all(color: sel ? context.cs.primary : Colors.transparent),
                  ),
                  child: Row(children: [
                    Icon(icon, size: 20, color: sel ? context.cs.primary : context.cs.onSurfaceVariant),
                    const SizedBox(width: 10),
                    Text(label, style: TextStyle(fontWeight: sel ? FontWeight.w700 : FontWeight.w400, color: sel ? context.cs.primary : null, fontSize: 13)),
                  ]),
                ),
              );
            },
          ),
        ),
        VerticalDivider(width: 1, color: context.border),
        // Content
        Expanded(child: [
          _RestaurantInfoSettings(settings: settings),
          _ReceiptTaxSettings(settings: settings),
          _ThemeSettings(),
          _BackupSettings(),
          _UserAccountsSettings(),
        ][_section]),
      ]),
    ));
  }
}

class _RestaurantInfoSettings extends ConsumerStatefulWidget {
  const _RestaurantInfoSettings({required this.settings});
  final RestaurantSettings settings;
  @override ConsumerState<_RestaurantInfoSettings> createState() => _RestaurantInfoSettingsState();
}

class _RestaurantInfoSettingsState extends ConsumerState<_RestaurantInfoSettings> {
  late TextEditingController _name, _address, _phone, _email, _taxNum, _footer;

  @override
  void initState() {
    super.initState();
    _name    = TextEditingController(text: widget.settings.name);
    _address = TextEditingController(text: widget.settings.address);
    _phone   = TextEditingController(text: widget.settings.phone);
    _email   = TextEditingController(text: widget.settings.email);
    _taxNum  = TextEditingController(text: widget.settings.taxNumber);
    _footer  = TextEditingController(text: widget.settings.footerMessage);
  }

  @override void dispose() { _name.dispose(); _address.dispose(); _phone.dispose(); _email.dispose(); _taxNum.dispose(); _footer.dispose(); super.dispose(); }

  @override
  Widget build(BuildContext context) => SingleChildScrollView(
    padding: const EdgeInsets.all(24),
    child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      Text('Restaurant Information', style: Theme.of(context).textTheme.headlineSmall?.copyWith(fontWeight: FontWeight.w700)),
      Text('Appears on all receipts and invoices', style: TextStyle(color: context.cs.onSurfaceVariant, fontSize: 13)),
      const SizedBox(height: 24),
      // Logo
      AppCard(child: Row(children: [
        Container(
          width: 80, height: 80,
          decoration: BoxDecoration(color: context.cs.primary.withAlpha(15), borderRadius: BorderRadius.circular(12), border: Border.all(color: context.border)),
          child: widget.settings.logoPath != null && widget.settings.logoPath!.isNotEmpty
            ? ClipRRect(borderRadius: BorderRadius.circular(12), child: Image.file(File(AppPaths.resolve(widget.settings.logoPath!)), fit: BoxFit.cover))
            : Icon(Icons.restaurant_rounded, size: 40, color: context.cs.primary.withAlpha(100)),
        ),
        const SizedBox(width: 18),
        Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          FilledButton.icon(
            icon: const Icon(Icons.upload_rounded, size: 16),
            label: const Text('Upload Logo'),
            onPressed: () async {
              final img = await ImagePicker().pickImage(source: ImageSource.gallery, imageQuality: 90);
              if (img != null) {
                final savedPath = await AppPaths.copyToMedia(img.path, prefix: 'logo');
                await ref.read(settingsProvider.notifier).save(widget.settings.copyWith(logoPath: savedPath));
              }
            },
          ),
          const SizedBox(height: 6),
          Text('PNG or JPG · shown on receipts', style: TextStyle(fontSize: 12, color: context.cs.onSurfaceVariant)),
        ]),
      ])),
      const SizedBox(height: 16),
      AppCard(child: Column(children: [
        TextField(controller: _name, decoration: const InputDecoration(labelText: 'Restaurant name *')),
        const SizedBox(height: 10),
        TextField(controller: _address, maxLines: 2, decoration: const InputDecoration(labelText: 'Address')),
        const SizedBox(height: 10),
        Row(children: [
          Expanded(child: TextField(controller: _phone, decoration: const InputDecoration(labelText: 'Phone'))),
          const SizedBox(width: 10),
          Expanded(child: TextField(controller: _email, decoration: const InputDecoration(labelText: 'Email'))),
        ]),
        const SizedBox(height: 10),
        TextField(controller: _taxNum, decoration: const InputDecoration(labelText: 'NTN / Tax number')),
        const SizedBox(height: 10),
        TextField(controller: _footer, maxLines: 2, decoration: const InputDecoration(labelText: 'Receipt footer message')),
      ])),
      const SizedBox(height: 20),
      FilledButton.icon(
        icon: const Icon(Icons.save_rounded, size: 16),
        label: const Text('Save restaurant info'),
        onPressed: () async {
          await ref.read(settingsProvider.notifier).save(widget.settings.copyWith(
            name: _name.text, address: _address.text, phone: _phone.text,
            email: _email.text, taxNumber: _taxNum.text, footerMessage: _footer.text,
          ));
          if (mounted) showSuccess(context, 'Saved');
        },
      ),
    ]),
  );
}

class _ReceiptTaxSettings extends ConsumerStatefulWidget {
  const _ReceiptTaxSettings({required this.settings});
  final RestaurantSettings settings;
  @override ConsumerState<_ReceiptTaxSettings> createState() => _ReceiptTaxSettingsState();
}

class _ReceiptTaxSettingsState extends ConsumerState<_ReceiptTaxSettings> {
  late TextEditingController _tax, _svc, _sym;
  late int _width;
  late bool _autoKitchen, _autoPrint;

  @override
  void initState() {
    super.initState();
    _tax  = TextEditingController(text: widget.settings.taxPercent.toStringAsFixed(0));
    _svc  = TextEditingController(text: widget.settings.serviceChargePercent.toStringAsFixed(0));
    _sym  = TextEditingController(text: widget.settings.currencySymbol);
    _width = widget.settings.receiptWidth;
    _autoKitchen = widget.settings.autoKitchenPrint;
    _autoPrint   = widget.settings.autoPrintBillOnPay;
  }

  @override void dispose() { _tax.dispose(); _svc.dispose(); _sym.dispose(); super.dispose(); }

  @override
  Widget build(BuildContext context) => SingleChildScrollView(
    padding: const EdgeInsets.all(24),
    child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      Text('Receipt & Tax Settings', style: Theme.of(context).textTheme.headlineSmall?.copyWith(fontWeight: FontWeight.w700)),
      const SizedBox(height: 24),
      AppCard(child: Column(children: [
        Row(children: [
          Expanded(child: TextField(controller: _tax, keyboardType: TextInputType.number, decoration: const InputDecoration(labelText: 'GST / Tax %', suffixText: '%'))),
          const SizedBox(width: 12),
          Expanded(child: TextField(controller: _svc, keyboardType: TextInputType.number, decoration: const InputDecoration(labelText: 'Service charge %', suffixText: '%'))),
          const SizedBox(width: 12),
          Expanded(child: TextField(controller: _sym, decoration: const InputDecoration(labelText: 'Currency symbol (e.g. Rs)'))),
        ]),
        const SizedBox(height: 14),
        // Receipt width
        Row(children: [
          const Text('Receipt width:', style: TextStyle(fontWeight: FontWeight.w600)),
          const SizedBox(width: 16),
          ...[58, 80].map((w) => Padding(
            padding: const EdgeInsets.only(right: 12),
            child: GestureDetector(
              onTap: () => setState(() => _width = w),
              child: Row(children: [
                Radio<int>(value: w, groupValue: _width, onChanged: (v) => setState(() => _width = v!)),
                Text('${w}mm'),
              ]),
            ),
          )),
        ]),
        const Divider(height: 20),
        SwitchListTile(
          title: const Text('Auto-print kitchen ticket when order sent'),
          value: _autoKitchen,
          onChanged: (v) => setState(() => _autoKitchen = v),
          contentPadding: EdgeInsets.zero,
        ),
        SwitchListTile(
          title: const Text('Auto-print receipt after payment'),
          value: _autoPrint,
          onChanged: (v) => setState(() => _autoPrint = v),
          contentPadding: EdgeInsets.zero,
        ),
      ])),
      const SizedBox(height: 20),
      FilledButton.icon(
        icon: const Icon(Icons.save_rounded, size: 16),
        label: const Text('Save settings'),
        onPressed: () async {
          await ref.read(settingsProvider.notifier).save(widget.settings.copyWith(
            taxPercent: double.tryParse(_tax.text) ?? 17,
            serviceChargePercent: double.tryParse(_svc.text) ?? 10,
            currencySymbol: _sym.text,
            receiptWidth: _width,
            autoKitchenPrint: _autoKitchen,
            autoPrintBillOnPay: _autoPrint,
          ));
          if (mounted) showSuccess(context, 'Saved');
        },
      ),
    ]),
  );
}

class _ThemeSettings extends ConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final mode = ref.watch(themeModeProvider);
    return Padding(
      padding: const EdgeInsets.all(24),
      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        Text('Theme & Appearance', style: Theme.of(context).textTheme.headlineSmall?.copyWith(fontWeight: FontWeight.w700)),
        const SizedBox(height: 24),
        AppCard(child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          const Text('Color theme', style: TextStyle(fontWeight: FontWeight.w600)),
          const SizedBox(height: 14),
          SegmentedButton<ThemeMode>(
            segments: const [
              ButtonSegment(value: ThemeMode.dark, icon: Icon(Icons.dark_mode_rounded), label: Text('Dark')),
              ButtonSegment(value: ThemeMode.light, icon: Icon(Icons.light_mode_rounded), label: Text('Light')),
              ButtonSegment(value: ThemeMode.system, icon: Icon(Icons.devices_rounded), label: Text('System')),
            ],
            selected: {mode},
            onSelectionChanged: (s) => ref.read(themeModeProvider.notifier).set(s.first),
          ),
        ])),
      ]),
    );
  }
}

class _BackupSettings extends ConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Padding(
      padding: const EdgeInsets.all(24),
      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        Text('Backup & Restore', style: Theme.of(context).textTheme.headlineSmall?.copyWith(fontWeight: FontWeight.w700)),
        Text('Keep your restaurant data safe and easily migrate between laptops', style: TextStyle(color: context.cs.onSurfaceVariant, fontSize: 13)),
        const SizedBox(height: 24),
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Backup Card
            Expanded(
              child: AppCard(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Icon(Icons.cloud_upload_rounded, color: context.cs.primary, size: 24),
                        const SizedBox(width: 10),
                        const Text('Export Backup Archive', style: TextStyle(fontWeight: FontWeight.w700, fontSize: 16)),
                      ],
                    ),
                    const SizedBox(height: 12),
                    Text(
                      'Creates a secure ZIP archive containing all database transactions, restaurant settings, menu items (with photos), and user accounts details.',
                      style: TextStyle(color: context.cs.onSurfaceVariant, fontSize: 13, height: 1.4),
                    ),
                    const SizedBox(height: 24),
                    Row(
                      children: [
                        FilledButton.icon(
                          icon: const Icon(Icons.backup_rounded, size: 16),
                          label: const Text('Export Backup Now'),
                          onPressed: () async {
                            try {
                              final ts = DateFormat('yyyy-MM-dd_HH-mm-ss').format(DateTime.now());
                              final defaultFileName = 'restaurant_pos_backup_$ts.zip';

                              final destPath = await FilePicker.platform.saveFile(
                                dialogTitle: 'Save Backup Archive',
                                fileName: defaultFileName,
                                type: FileType.custom,
                                allowedExtensions: ['zip'],
                              );

                              if (destPath == null) return;

                              if (context.mounted) {
                                showDialog(
                                  context: context,
                                  barrierDismissible: false,
                                  builder: (ctx) => const Center(child: Card(child: Padding(padding: EdgeInsets.all(24), child: Column(mainAxisSize: MainAxisSize.min, children: [CircularProgressIndicator(), SizedBox(height: 16), Text('Creating backup archive...'),],),),),),
                                );
                              }

                              await BackupService.createBackup(destPath);

                              if (context.mounted) {
                                Navigator.of(context).pop(); // close dialog
                                showSuccess(context, 'Backup successfully saved to:\n$destPath');
                              }
                            } catch (e) {
                              if (context.mounted) {
                                if (Navigator.canPop(context)) Navigator.of(context).pop();
                                showError(context, 'Backup failed: $e');
                              }
                            }
                          },
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(width: 20),
            // Restore Card
            Expanded(
              child: AppCard(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        const Icon(Icons.cloud_download_rounded, color: Colors.orange, size: 24),
                        const SizedBox(width: 10),
                        const Text('Restore Backup Archive', style: TextStyle(fontWeight: FontWeight.w700, fontSize: 16)),
                      ],
                    ),
                    const SizedBox(height: 12),
                    Text(
                      'Restore everything from a previously exported backup file. WARNING: This will overwrite all your current local data and images.',
                      style: TextStyle(color: context.cs.onSurfaceVariant, fontSize: 13, height: 1.4),
                    ),
                    const SizedBox(height: 24),
                    Row(
                      children: [
                        FilledButton.icon(
                          style: FilledButton.styleFrom(
                            backgroundColor: Colors.orange,
                            foregroundColor: Colors.white,
                          ),
                          icon: const Icon(Icons.settings_backup_restore_rounded, size: 16),
                          label: const Text('Restore Backup Now'),
                          onPressed: () async {
                            final confirm = await showDialog<bool>(
                              context: context,
                              builder: (ctx) => AlertDialog(
                                title: const Text('Confirm Restore'),
                                content: const Text('This will overwrite all existing local data. Are you sure you want to proceed?'),
                                actions: [
                                  TextButton(onPressed: () => Navigator.pop(ctx, false), child: const Text('Cancel')),
                                  FilledButton(
                                    style: FilledButton.styleFrom(backgroundColor: Colors.orange),
                                    onPressed: () => Navigator.pop(ctx, true),
                                    child: const Text('Yes, Overwrite & Restore'),
                                  ),
                                ],
                              ),
                            );

                            if (confirm != true) return;

                            try {
                              final result = await FilePicker.platform.pickFiles(
                                type: FileType.custom,
                                allowedExtensions: ['zip', 'rpb'],
                              );
                              if (result == null || result.files.single.path == null) return;

                              final path = result.files.single.path!;

                              if (context.mounted) {
                                showDialog(
                                  context: context,
                                  barrierDismissible: false,
                                  builder: (ctx) => const Center(child: Card(child: Padding(padding: EdgeInsets.all(24), child: Column(mainAxisSize: MainAxisSize.min, children: [CircularProgressIndicator(), SizedBox(height: 16), Text('Restoring backup, please wait...'),],),),),),
                                );
                              }

                              final success = await BackupService.restoreBackup(
                                path,
                                onBeforeRestore: () async {
                                  await ref.read(dbProvider).close();
                                },
                              );

                              if (context.mounted) {
                                Navigator.of(context).pop(); // close dialog
                              }

                              if (success) {
                                ref.invalidate(dbProvider);
                                ref.invalidate(settingsProvider);
                                ref.invalidate(initProvider);

                                if (context.mounted) {
                                  showSuccess(context, 'Backup restored successfully!');
                                }
                              } else {
                                if (context.mounted) {
                                  showError(context, 'Failed to restore backup.');
                                }
                              }
                            } catch (e) {
                              if (context.mounted) {
                                if (Navigator.canPop(context)) Navigator.of(context).pop();
                                showError(context, 'Restore failed: $e');
                              }
                            }
                          },
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ]),
    );
  }
}

// Stub for openAppFile
Future<void> openAppFile(String path) async {
  // Uses open_filex package in real implementation
}

class _UserAccountsSettings extends ConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final staffAsync = ref.watch(staffProvider);
    return Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      Padding(
        padding: const EdgeInsets.fromLTRB(24, 24, 24, 0),
        child: Text('User Accounts', style: Theme.of(context).textTheme.headlineSmall?.copyWith(fontWeight: FontWeight.w700)),
      ),
      const SizedBox(height: 8),
      Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24),
        child: Text('Manage login credentials and roles', style: TextStyle(color: context.cs.onSurfaceVariant, fontSize: 13)),
      ),
      const SizedBox(height: 16),
      Expanded(child: staffAsync.when(
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (e, _) => Center(child: Text('Error: $e')),
        data: (staff) => ListView.builder(
          padding: const EdgeInsets.symmetric(horizontal: 24),
          itemCount: staff.length,
          itemBuilder: (_, i) {
            final u = staff[i];
            return AppCard(
              margin: const EdgeInsets.only(bottom: 8),
              child: Row(children: [
                CircleAvatar(radius: 18, backgroundColor: context.cs.primary.withAlpha(20),
                  child: Text(u.name.substring(0,1).toUpperCase(), style: TextStyle(color: context.cs.primary, fontWeight: FontWeight.w700))),
                const SizedBox(width: 12),
                Expanded(child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                  Text(u.name, style: const TextStyle(fontWeight: FontWeight.w600, fontSize: 13)),
                  Text(
                    _roleUsesLogin(u.role) && !_isInternalStaffUsername(u.email)
                        ? u.email
                        : 'Attendance and salary only',
                    style: TextStyle(fontSize: 11, color: context.cs.onSurfaceVariant),
                  ),
                ])),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 7, vertical: 2),
                  decoration: BoxDecoration(color: context.cs.primary.withAlpha(15), borderRadius: BorderRadius.circular(5)),
                  child: Text(u.role.name.toUpperCase(), style: TextStyle(fontSize: 10, color: context.cs.primary, fontWeight: FontWeight.w700)),
                ),
                const SizedBox(width: 8),
                if (_roleUsesLogin(u.role) && !_isInternalStaffUsername(u.email))
                  IconButton(
                    icon: Icon(Icons.key_rounded, size: 18, color: context.cs.onSurfaceVariant),
                    tooltip: 'Reset password',
                    onPressed: () => _resetPassword(context, ref, u),
                  ),
              ]),
            );
          },
        ),
      )),
    ]);
  }

  void _resetPassword(BuildContext context, WidgetRef ref, UserEntity u) {
    final ctrl = TextEditingController();
    showDialog(context: context, builder: (_) => AlertDialog(
      title: Text('Reset password — ${u.name}'),
      content: TextField(controller: ctrl, obscureText: true, autofocus: true, decoration: const InputDecoration(labelText: 'New password')),
      actions: [
        TextButton(onPressed: () => Navigator.pop(context), child: const Text('Cancel')),
        FilledButton(
          onPressed: () async {
            if (ctrl.text.isEmpty) return;
            final hash = sha256.convert(utf8.encode(ctrl.text)).toString();
            await ref.read(dbProvider).userDao.update_(UsersCompanion(id: Value(u.id), passwordHash: Value(hash)));
            if (context.mounted) { Navigator.pop(context); showSuccess(context, 'Password reset'); }
          },
          child: const Text('Reset'),
        ),
      ],
    ));
  }
}

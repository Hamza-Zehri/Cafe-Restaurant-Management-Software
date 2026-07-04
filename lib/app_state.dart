// ═══════════════════════════════════════════════════════
// APP STATE — All Riverpod providers
// ═══════════════════════════════════════════════════════

import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:uuid/uuid.dart';
import 'package:crypto/crypto.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:drift/drift.dart';

import '../data/datasources/database.dart';
import '../domain/entities.dart';

// ── Database singleton ────────────────────────────────
final dbProvider = Provider<AppDatabase>((ref) {
  final db = AppDatabase();
  ref.onDispose(() => db.close());
  return db;
});

// ── Initialization state ──────────────────────────────
class InitState {
  const InitState({this.isLoading = true, this.hasAdmin = false});
  final bool isLoading;
  final bool hasAdmin;
}

class InitNotifier extends StateNotifier<InitState> {
  InitNotifier(this._db, this._settings) : super(const InitState()) { _check(); }
  final AppDatabase _db;
  final SettingsNotifier _settings;

  Future<void> _check() async {
    try {
      final hasAdmin = await _db.userDao.hasAdmin();
      state = InitState(isLoading: false, hasAdmin: hasAdmin);
    } catch (e) {
      state = const InitState(isLoading: false, hasAdmin: false);
    }
  }

  Future<void> completeSetup({
    required String resName, required String resPhone, required String resEmail,
    required String resAddress, required String resTaxNumber, required String? resLogo,
    required String adminName, required String adminUsername, required String adminPassword,
  }) async {
    // 1. Save settings
    final s = _settings.state;
    await _settings.save(s.copyWith(
      name: resName, phone: resPhone, email: resEmail,
      address: resAddress, taxNumber: resTaxNumber, logoPath: resLogo,
    ));

    // 2. Create admin
    final hash = sha256.convert(utf8.encode(adminPassword)).toString();
    await _db.userDao.insert_(UsersCompanion.insert(
      name: adminName, email: adminUsername.trim().toLowerCase(),
      passwordHash: hash, role: 'owner',
    ));

    // 3. Update state
    await _check();
  }
}

final initProvider = StateNotifierProvider<InitNotifier, InitState>(
  (ref) => InitNotifier(ref.watch(dbProvider), ref.watch(settingsProvider.notifier)));

// ── Auth state ────────────────────────────────────────
class AuthState {
  const AuthState({this.user, this.isLoading = false, this.error});
  final UserEntity? user;
  final bool isLoading;
  final String? error;
  bool get isLoggedIn => user != null;
  AuthState copyWith({UserEntity? user, bool? isLoading, String? error}) =>
    AuthState(user: user ?? this.user, isLoading: isLoading ?? this.isLoading, error: error);
}

class AuthNotifier extends StateNotifier<AuthState> {
  AuthNotifier(this._db) : super(const AuthState()) { _restoreSession(); }
  final AppDatabase _db;
  final _storage = const FlutterSecureStorage();
  static const _key = 'session_user_id';

  Future<void> _restoreSession() async {
    final idStr = await _storage.read(key: _key);
    if (idStr == null) return;
    final row = await _db.userDao.byId(int.tryParse(idStr) ?? 0);
    if (row != null) state = AuthState(user: _map(row));
  }

  Future<bool> login(String email, String password) async {
    state = state.copyWith(isLoading: true, error: null);
    final hash = sha256.convert(utf8.encode(password)).toString();
    final row = await _db.userDao.byEmail(email.trim().toLowerCase());
    if (row == null || row.passwordHash != hash || !row.isActive) {
      state = state.copyWith(isLoading: false, error: 'Invalid email or password');
      return false;
    }
    await _storage.write(key: _key, value: row.id.toString());
    state = AuthState(user: _map(row));
    return true;
  }

  Future<void> logout() async {
    await _storage.delete(key: _key);
    state = const AuthState();
  }

  UserEntity _map(UserRow r) => UserEntity(
    id: r.id, name: r.name, email: r.email, role: _role(r.role),
    phone: r.phone, photoPath: r.photoPath, salary: r.salary,
    wageType: r.wageType == 'daily' ? WageType.daily : r.wageType == 'hourly' ? WageType.hourly : WageType.monthly,
    isActive: r.isActive, createdAt: r.createdAt,
  );
  UserRole _role(String s) => UserRole.values.firstWhere((r) => r.name == s, orElse: () => UserRole.waiter);
}

final authProvider = StateNotifierProvider<AuthNotifier, AuthState>(
  (ref) => AuthNotifier(ref.watch(dbProvider)));

// ── Settings ──────────────────────────────────────────
class SettingsNotifier extends StateNotifier<RestaurantSettings> {
  SettingsNotifier(this._db) : super(const RestaurantSettings()) { _load(); }
  final AppDatabase _db;

  Future<void> _load() async {
    final s = await _db.settingsDao.getAll();
    state = RestaurantSettings(
      name: s['restaurant_name'] ?? 'My Restaurant',
      address: s['restaurant_address'] ?? '',
      phone: s['restaurant_phone'] ?? '',
      email: s['restaurant_email'] ?? '',
      taxNumber: s['restaurant_tax_number'] ?? '',
      footerMessage: s['receipt_footer'] ?? 'Thank you for dining with us!',
      logoPath: s['logo_path'],
      taxPercent: double.tryParse(s['tax_percent'] ?? '') ?? 17.0,
      serviceChargePercent: double.tryParse(s['service_charge_percent'] ?? '') ?? 10.0,
      currencySymbol: s['currency_symbol'] ?? 'Rs',
      receiptWidth: int.tryParse(s['receipt_width'] ?? '') ?? 80,
      autoKitchenPrint: s['auto_kitchen_print'] != 'false',
      autoPrintBillOnPay: s['auto_print_bill_on_pay'] != 'false',
      autoBackupEnabled: s['auto_backup_enabled'] == 'true',
      autoBackupInterval: s['auto_backup_interval'] ?? 'Every 24 Hours',
      autoBackupDestFolder: s['auto_backup_dest_folder'] ?? '',
      autoBackupLastTime: s['auto_backup_last_time'] ?? '',
      autoBackupNextTime: s['auto_backup_next_time'] ?? '',
      autoBackupStatus: s['auto_backup_status'] ?? 'Idle',
    );
  }

  Future<void> save(RestaurantSettings s) async {
    await _db.settingsDao.set('restaurant_name', s.name);
    await _db.settingsDao.set('restaurant_address', s.address);
    await _db.settingsDao.set('restaurant_phone', s.phone);
    await _db.settingsDao.set('restaurant_email', s.email);
    await _db.settingsDao.set('restaurant_tax_number', s.taxNumber);
    await _db.settingsDao.set('receipt_footer', s.footerMessage);
    if (s.logoPath != null) await _db.settingsDao.set('logo_path', s.logoPath!);
    await _db.settingsDao.set('tax_percent', s.taxPercent.toString());
    await _db.settingsDao.set('service_charge_percent', s.serviceChargePercent.toString());
    await _db.settingsDao.set('currency_symbol', s.currencySymbol);
    await _db.settingsDao.set('receipt_width', s.receiptWidth.toString());
    await _db.settingsDao.set('auto_kitchen_print', s.autoKitchenPrint.toString());
    await _db.settingsDao.set('auto_print_bill_on_pay', s.autoPrintBillOnPay.toString());
    await _db.settingsDao.set('auto_backup_enabled', s.autoBackupEnabled.toString());
    await _db.settingsDao.set('auto_backup_interval', s.autoBackupInterval);
    await _db.settingsDao.set('auto_backup_dest_folder', s.autoBackupDestFolder);
    await _db.settingsDao.set('auto_backup_last_time', s.autoBackupLastTime);
    await _db.settingsDao.set('auto_backup_next_time', s.autoBackupNextTime);
    await _db.settingsDao.set('auto_backup_status', s.autoBackupStatus);
    state = s;
  }
}

final settingsProvider = StateNotifierProvider<SettingsNotifier, RestaurantSettings>(
  (ref) => SettingsNotifier(ref.watch(dbProvider)));

// ── Theme ─────────────────────────────────────────────
final themeModeProvider = StateNotifierProvider<ThemeModeNotifier, ThemeMode>(
  (ref) => ThemeModeNotifier());

class ThemeModeNotifier extends StateNotifier<ThemeMode> {
  ThemeModeNotifier() : super(ThemeMode.dark) { _load(); }
  final _s = const FlutterSecureStorage();
  Future<void> _load() async {
    final v = await _s.read(key: 'theme_mode');
    state = v == 'light' ? ThemeMode.light : ThemeMode.dark;
  }
  Future<void> toggle() async {
    state = state == ThemeMode.dark ? ThemeMode.light : ThemeMode.dark;
    await _s.write(key: 'theme_mode', value: state == ThemeMode.dark ? 'dark' : 'light');
  }
  Future<void> set(ThemeMode m) async {
    state = m;
    await _s.write(key: 'theme_mode', value: m.name);
  }
}

// ── Menu state ────────────────────────────────────────
final menuGroupsProvider = StreamProvider<List<MenuGroupEntity>>((ref) {
  return ref.watch(dbProvider).menuDao.watchGroups().map((rows) =>
    rows.map((r) => MenuGroupEntity(id: r.id, name: r.name, iconPath: r.iconPath, colorHex: r.colorHex, sortOrder: r.sortOrder, isActive: r.isActive)).toList());
});

final menuItemsByGroupProvider = StreamProvider.family<List<MenuItemEntity>, int>((ref, groupId) {
  return ref.watch(dbProvider).menuDao.watchByGroup(groupId).asyncMap((rows) async {
    final db = ref.watch(dbProvider);
    final groups = await db.menuDao.getGroups();
    return rows.map((r) {
      final g = groups.firstWhere((g) => g.id == r.groupId, orElse: () => groups.first);
      return mapMenuItemRow(r, g.name);
    }).toList();
  });
});

MenuItemEntity mapMenuItemRow(MenuItemRow r, String groupName) => MenuItemEntity(
  id: r.id, groupId: r.groupId, groupName: groupName, name: r.name,
  price: r.price, costPrice: r.costPrice, description: r.description,
  imagePath: r.imagePath, preparationMinutes: r.preparationMinutes,
  isAvailable: r.isAvailable, stockCount: r.stockCount, taxPercent: r.taxPercent, sortOrder: r.sortOrder,
);

final dealsProvider = StreamProvider<List<DealRow>>((ref) {
  return ref.watch(dbProvider).dealDao.watchAll();
});

final activeDealsProvider = FutureProvider<List<DealRow>>((ref) async {
  return ref.watch(dbProvider).dealDao.getActiveDeals();
});

final dealItemsProvider = FutureProvider.family<List<DealItemRow>, int>((ref, dealId) async {
  return ref.watch(dbProvider).dealDao.itemsForDeal(dealId);
});

final backupHistoryProvider = FutureProvider<List<BackupHistoryRow>>((ref) async {
  return ref.watch(dbProvider).dealDao.getBackupHistory();
});

// ── Tables state ──────────────────────────────────────
final tablesProvider = StreamProvider<List<TableEntity>>((ref) {
  return ref.watch(dbProvider).tableDao.watchAll().map((rows) =>
    rows.map(_mapTable).toList());
});

final floorTablesProvider = StreamProvider.family<List<TableEntity>, int>((ref, floorId) {
  return ref.watch(dbProvider).tableDao.watchByFloor(floorId).map((rows) =>
    rows.map(_mapTable).toList());
});

final floorsProvider = FutureProvider<List<FloorEntity>>((ref) async {
  final rows = await ref.watch(dbProvider).tableDao.allFloors();
  return rows.map((r) => FloorEntity(id: r.id, name: r.name, sortOrder: r.sortOrder)).toList();
});

TableEntity _mapTable(RestaurantTableRow r) => TableEntity(
  id: r.id, floorId: r.floorId, name: r.name, capacity: r.capacity,
  shape: r.shape, posX: r.posX, posY: r.posY, width: r.width, height: r.height,
  status: _tableStatus(r.status), activeOrderId: r.activeOrderId,
  waiterName: r.waiterName, guestCount: r.guestCount,
  runningTotal: r.runningTotal, orderStartTime: r.orderStartTime,
);
TableStatus _tableStatus(String s) => TableStatus.values.firstWhere((t) => t.name == s, orElse: () => TableStatus.available);

// ── Active Orders ─────────────────────────────────────
final activeOrdersProvider = StreamProvider<List<OrderEntity>>((ref) {
  return ref.watch(dbProvider).orderDao.watchActive().asyncMap((rows) async {
    return Future.wait(rows.map((r) => _buildOrder(ref.watch(dbProvider), r)));
  });
});

final orderForTableProvider = FutureProvider.family<OrderEntity?, int>((ref, tableId) async {
  final db = ref.watch(dbProvider);
  final row = await db.orderDao.activeForTable(tableId);
  if (row == null) return null;
  return _buildOrder(db, row);
});

Future<OrderEntity> _buildOrder(AppDatabase db, OrderRow r) async {
  final itemRows = await db.orderDao.itemsForOrder(r.id);
  final items = itemRows.map((i) {
    List<OrderModifier> mods = [];
    try {
      final decoded = jsonDecode(i.modifiersJson) as List;
      mods = decoded.map((m) => OrderModifier(name: m['name'], price: (m['price'] as num).toDouble())).toList();
    } catch (_) {}
    return OrderItemEntity(
      id: i.id, orderId: i.orderId,
      menuItem: MenuItemEntity(id: i.menuItemId, groupId: 0, groupName: '', name: i.menuItemName, price: i.unitPrice),
      quantity: i.quantity, unitPrice: i.unitPrice, notes: i.notes,
      status: _itemStatus(i.status), modifiers: mods, isVoided: i.isVoided,
      sentToKitchenAt: i.sentToKitchenAt,
      dealId: i.dealId,
      dealItemsJson: i.dealItemsJson,
    );
  }).toList();
  return OrderEntity(
    id: r.id, orderNumber: r.orderNumber, tableId: r.tableId, tableName: r.tableNameCol,
    waiterId: r.waiterId, waiterName: r.waiterName, items: items,
    status: _orderStatus(r.status), discountPercent: r.discountPercent,
    discountAmount: r.discountAmount, taxPercent: r.taxPercent,
    serviceChargePercent: r.serviceChargePercent, notes: r.notes,
    kitchenTicketCount: r.kitchenTicketCount, guestCount: r.guestCount,
    createdAt: r.createdAt, paidAt: r.paidAt,
  );
}
OrderStatus _orderStatus(String s) => OrderStatus.values.firstWhere((o) => o.name == s, orElse: () => OrderStatus.open);
OrderItemStatus _itemStatus(String s) => OrderItemStatus.values.firstWhere((o) => o.name == s, orElse: () => OrderItemStatus.pending);

// ── Order terminal (per-table order management) ─────────────────
class POSNotifier extends StateNotifier<AsyncValue<OrderEntity?>> {
  POSNotifier(this._db, this._tableId, this._currentUser, this._ref)
    : super(const AsyncValue.loading()) { _load(); }

  final AppDatabase _db;
  final int _tableId;
  final UserEntity _currentUser;
  final Ref _ref;
  static const _uuid = Uuid();

  OrderEntity? get order => state.valueOrNull;

  Future<void> _load() async {
    final row = await _db.orderDao.activeForTable(_tableId);
    if (row != null) {
      final o = await _buildOrder(_db, row);
      state = AsyncValue.data(o);
    } else {
      state = const AsyncValue.data(null);
    }
  }

  // ── Create new order ─────────────────────────────
  Future<OrderEntity> _ensureOrder(int guestCount, {String? waiterName}) async {
    if (order != null) return order!;
    final settings = await _db.settingsDao.getAll();
    final now = DateTime.now();
    final num = '${now.hour.toString().padLeft(2,'0')}${now.minute.toString().padLeft(2,'0')}-${now.millisecond % 1000}';
    final resolvedWaiterName = (waiterName != null && waiterName.trim().isNotEmpty)
        ? waiterName.trim()
        : _currentUser.name;

    final tableRow = await _db.tableDao.byId(_tableId);
    final id = await _db.orderDao.insertOrder(OrdersCompanion.insert(
      orderNumber: num,
      tableId: _tableId,
      tableNameCol: tableRow?.name ?? 'T$_tableId',
      waiterId: _currentUser.id,
      waiterName: resolvedWaiterName,
      guestCount: Value(guestCount),
      taxPercent: Value(double.tryParse(settings['tax_percent'] ?? '') ?? 17.0),
      serviceChargePercent: Value(double.tryParse(settings['service_charge_percent'] ?? '') ?? 10.0),
    ));

    await _db.tableDao.setStatus(_tableId, 'occupied',
      orderId: id, waiterName: resolvedWaiterName, guestCount: guestCount, orderStartTime: now);

    await _load();
    return order!;
  }

  Future<void> openTableWithWaiter(int guestCount, {String? waiterName}) async {
    await _ensureOrder(guestCount, waiterName: waiterName);
  }

  // ── Add item to order ─────────────────────────────
  Future<void> addItem(MenuItemEntity item, {int qty = 1, String notes = '', List<OrderModifier> mods = const []}) async {
    final o = await _ensureOrder(1);
    final modJson = jsonEncode(mods.map((m) => {'name': m.name, 'price': m.price}).toList());

    // Check if same item+notes already in order (no sent yet)
    final existing = o.items.where((i) =>
      i.menuItem.id == item.id && i.notes == notes && !i.isVoided && i.status == OrderItemStatus.pending).toList();

    if (existing.isNotEmpty) {
      final e = existing.first;
      await _db.orderDao.updateItem(OrderItemsCompanion(
        id: Value(e.id), quantity: Value(e.quantity + qty),
      ));
    } else {
      await _db.orderDao.insertItem(OrderItemsCompanion.insert(
        orderId: o.id, menuItemId: item.id, menuItemName: item.name,
        unitPrice: item.price, quantity: qty,
        notes: Value(notes), modifiersJson: Value(modJson),
      ));
    }
    await _refreshRunningTotal();
    await _load();
  }

  // ── Add deal to order ─────────────────────────────
  Future<void> addDeal(DealRow deal, List<DealItemRow> dealItems, List<MenuItemRow> menuItems) async {
    final o = await _ensureOrder(1);
    final list = dealItems.map((di) {
      final mi = menuItems.firstWhere((m) => m.id == di.menuItemId);
      return {
        'id': mi.id,
        'name': mi.name,
        'quantity': di.quantity,
      };
    }).toList();
    final dealItemsJsonStr = jsonEncode(list);
    final firstMenuItemId = dealItems.isNotEmpty ? dealItems.first.menuItemId : 0;

    await _db.orderDao.insertItem(OrderItemsCompanion.insert(
      orderId: o.id,
      menuItemId: firstMenuItemId,
      menuItemName: deal.name,
      unitPrice: deal.price,
      quantity: 1,
      dealId: Value(deal.id),
      dealItemsJson: Value(dealItemsJsonStr),
    ));
    await _refreshRunningTotal();
    await _load();
  }

  // ── Change quantity ───────────────────────────────
  Future<void> setQty(int itemId, int qty) async {
    if (qty <= 0) {
      await removeItem(itemId);
    } else {
      await _db.orderDao.updateItem(OrderItemsCompanion(id: Value(itemId), quantity: Value(qty)));
      await _refreshRunningTotal();
      await _load();
    }
  }

  // ── Remove item ───────────────────────────────────
  Future<void> removeItem(int itemId) async {
    await _db.orderDao.removeItem(itemId);
    await _refreshRunningTotal();
    await _load();
  }

  // ── Void item (keeps in list, marks voided) ───────
  Future<void> voidItem(int itemId) async {
    await _db.orderDao.updateItem(OrderItemsCompanion(id: Value(itemId), isVoided: const Value(true)));
    await _refreshRunningTotal();
    await _load();
  }

  // ── Send to kitchen ───────────────────────────────
  Future<void> sendToKitchen() async {
    final o = order;
    if (o == null) return;
    final now = DateTime.now();
    final pendingItems = o.items.where((i) => !i.isVoided && i.status == OrderItemStatus.pending).toList();
    if (pendingItems.isEmpty) return;

    for (final item in pendingItems) {
      await _db.orderDao.updateItem(OrderItemsCompanion(
        id: Value(item.id),
        status: const Value('sent'),
        sentToKitchenAt: Value(now),
      ));
    }

    // Increment kitchen ticket count
    await _db.orderDao.updateOrder(OrdersCompanion(
      id: Value(o.id),
      status: const Value('kitchenSent'),
      kitchenTicketCount: Value(o.kitchenTicketCount + 1),
    ));

    // Update register kitchen ticket count
    final reg = await _db.registerDao.openRegister();
    if (reg != null) {
      await _db.registerDao.update_(reg.id, CashRegistersCompanion(
        totalKitchenTickets: Value(reg.totalKitchenTickets + 1),
      ));
    }

    await _load();
  }

  // ── Apply discount ────────────────────────────────
  Future<void> applyDiscount({double percent = 0, double amount = 0}) async {
    final o = order;
    if (o == null) return;
    await _db.orderDao.updateOrder(OrdersCompanion(
      id: Value(o.id),
      discountPercent: Value(percent),
      discountAmount: Value(amount),
    ));
    await _refreshRunningTotal();
    await _load();
  }

  // ── Hold order ────────────────────────────────────
  Future<void> holdOrder() async {
    final o = order;
    if (o == null) return;
    await _db.orderDao.updateOrder(OrdersCompanion(id: Value(o.id), status: const Value('hold')));
    await _load();
  }

  // ── Resume hold ───────────────────────────────────
  Future<void> resumeOrder() async {
    final o = order;
    if (o == null) return;
    await _db.orderDao.updateOrder(OrdersCompanion(id: Value(o.id), status: const Value('open')));
    await _load();
  }

  // ── Print proforma bill ───────────────────────────
  Future<void> printProformaBill() async {
    final o = order;
    if (o == null) return;
    await _db.orderDao.updateOrder(OrdersCompanion(id: Value(o.id), status: const Value('billPrinted')));
    await _load();
  }

  // ── Process payment ───────────────────────────────
  Future<InvoiceEntity?> processPayment({
    required PaymentMethod method,
    required double amountPaid,
    List<PaymentSplit> splits = const [],
    int? customerId,
    String? customerName,
    String? customerPhone,
  }) async {
    final o = order;
    if (o == null) return null;

    final now = DateTime.now();
    final invNum = 'INV-${now.year}${now.month.toString().padLeft(2,'0')}${now.day.toString().padLeft(2,'0')}-${o.orderNumber}';
    final splitsJson = jsonEncode(splits.map((s) => {'method': s.method.name, 'amount': s.amount}).toList());
    final change = amountPaid - o.grandTotal;

    int? resolvedCustomerId = customerId;

    if (method == PaymentMethod.credit && customerName != null && customerName.isNotEmpty) {
      final trimmedPhone = customerPhone?.trim() ?? '';
      CustomerRow? existingCustomer;
      if (trimmedPhone.isNotEmpty) {
        existingCustomer = await _db.customerDao.byPhone(trimmedPhone);
      }
      if (existingCustomer != null) {
        resolvedCustomerId = existingCustomer.id;
        final newBal = existingCustomer.balance + o.grandTotal;
        await _db.customerDao.updateBalance(resolvedCustomerId, newBal);
        await _db.customerDao.insertLedger(CreditLedgerCompanion.insert(
          customerId: resolvedCustomerId,
          type: 'debit',
          amount: o.grandTotal,
          balanceAfter: newBal,
          description: Value('Purchase - Invoice $invNum'),
          invoiceId: Value(o.id),
        ));
      } else {
        final newId = await _db.customerDao.insert_(CustomersCompanion.insert(
          name: customerName.trim(),
          phone: trimmedPhone,
          balance: Value(o.grandTotal),
        ));
        resolvedCustomerId = newId;
        await _db.customerDao.insertLedger(CreditLedgerCompanion.insert(
          customerId: resolvedCustomerId,
          type: 'debit',
          amount: o.grandTotal,
          balanceAfter: o.grandTotal,
          description: Value('First Purchase & Credit - Invoice $invNum'),
          invoiceId: Value(o.id),
        ));
      }
    }

    final invId = await _db.invoiceDao.insert_(InvoicesCompanion.insert(
      invoiceNumber: invNum, orderId: o.id, orderNumber: o.orderNumber,
      tableNameCol: o.tableName, waiterName: o.waiterName,
      subtotal: o.subtotal, discountValue: Value(o.discountValue),
      taxValue: Value(o.taxValue), serviceChargeValue: Value(o.serviceChargeValue),
      grandTotal: o.grandTotal, amountPaid: amountPaid,
      changeAmount: Value(change > 0 ? change : 0),
      paymentMethod: Value(method.name),
      paymentSplitsJson: Value(splitsJson),
      status: const Value('final'),
      customerId: Value(resolvedCustomerId),
    ));

    // Deduct stock for all order items:
    for (final item in o.activeItems) {
      if (item.dealId != null) {
        // It's a deal! Deduct stock of all included items
        for (final di in item.dealItems) {
          final mi = await _db.menuDao.byId(di.id);
          if (mi != null && mi.stockCount != -1) {
            final newStock = mi.stockCount - (di.quantity * item.quantity);
            await _db.menuDao.updateItem(MenuItemsCompanion(
              id: Value(mi.id),
              stockCount: Value(newStock < 0 ? 0 : newStock),
            ));
          }
        }
      } else {
        // Normal item! Deduct stock
        final mi = await _db.menuDao.byId(item.menuItem.id);
        if (mi != null && mi.stockCount != -1) {
          final newStock = mi.stockCount - item.quantity;
          await _db.menuDao.updateItem(MenuItemsCompanion(
            id: Value(mi.id),
            stockCount: Value(newStock < 0 ? 0 : newStock),
          ));
        }
      }
    }

    // Mark order paid
    await _db.orderDao.updateOrder(OrdersCompanion(
      id: Value(o.id), status: const Value('paid'), paidAt: Value(now),
    ));

    // Free the table
    await _db.tableDao.freeTable(_tableId);

    // Update register
    final reg = await _db.registerDao.openRegister();
    if (reg != null) {
      final cashAmt   = method == PaymentMethod.cash   ? o.grandTotal : (splits.where((s) => s.method == PaymentMethod.cash).fold(0.0, (a, s) => a + s.amount));
      final cardAmt   = method == PaymentMethod.card   ? o.grandTotal : (splits.where((s) => s.method == PaymentMethod.card).fold(0.0, (a, s) => a + s.amount));
      final walletAmt = method == PaymentMethod.wallet ? o.grandTotal : (splits.where((s) => s.method == PaymentMethod.wallet).fold(0.0, (a, s) => a + s.amount));
      final creditAmt = method == PaymentMethod.credit ? o.grandTotal : (splits.where((s) => s.method == PaymentMethod.credit).fold(0.0, (a, s) => a + s.amount));

      await _db.registerDao.update_(reg.id, CashRegistersCompanion(
        totalCashSales:   Value(reg.totalCashSales + cashAmt),
        totalCardSales:   Value(reg.totalCardSales + cardAmt),
        totalWalletSales: Value(reg.totalWalletSales + walletAmt),
        totalCreditSales: Value(reg.totalCreditSales + creditAmt),
        totalOrders:      Value(reg.totalOrders + 1),
        totalDiscounts:   Value(reg.totalDiscounts + o.discountValue),
        totalTax:         Value(reg.totalTax + o.taxValue),
      ));
      
      // Refresh register provider so dashboard updates!
      _ref.read(registerProvider.notifier)._load();
    }

    state = const AsyncValue.data(null);

    return InvoiceEntity(
      id: invId, invoiceNumber: invNum, orderId: o.id, orderNumber: o.orderNumber,
      tableName: o.tableName, waiterName: o.waiterName, items: o.activeItems,
      subtotal: o.subtotal, discountValue: o.discountValue, taxValue: o.taxValue,
      serviceChargeValue: o.serviceChargeValue, grandTotal: o.grandTotal,
      amountPaid: amountPaid, changeAmount: change > 0 ? change : 0,
      paymentMethod: method, status: BillStatus.final_,
      createdAt: now, customerId: resolvedCustomerId, paymentSplits: splits,
    );
  }

  // ── Void entire order ─────────────────────────────
  Future<void> voidOrder() async {
    final o = order;
    if (o == null) return;
    await _db.orderDao.updateOrder(OrdersCompanion(id: Value(o.id), status: const Value('cancelled')));
    await _db.tableDao.freeTable(_tableId);
    final reg = await _db.registerDao.openRegister();
    if (reg != null) {
      await _db.registerDao.update_(reg.id, CashRegistersCompanion(totalVoids: Value(reg.totalVoids + 1)));
      // Refresh register provider so dashboard updates!
      _ref.read(registerProvider.notifier)._load();
    }
    state = const AsyncValue.data(null);
  }

  Future<void> _refreshRunningTotal() async {
    final o = order;
    if (o == null) return;
    final itemRows = await _db.orderDao.itemsForOrder(o.id);
    double total = 0;
    for (final i in itemRows) {
      if (!i.isVoided) total += i.unitPrice * i.quantity;
    }
    await _db.tableDao.updateRunningTotal(_tableId, total);
  }

  Future<void> setGuestCount(int count) async {
    final o = order;
    if (o == null) return;
    await _db.orderDao.updateOrder(OrdersCompanion(id: Value(o.id), guestCount: Value(count)));
    await _db.tableDao.setStatus(_tableId, 'occupied', guestCount: count);
    await _load();
  }
}

final posProvider = StateNotifierProvider.family<POSNotifier, AsyncValue<OrderEntity?>, int>(
  (ref, tableId) {
    final db = ref.watch(dbProvider);
    final user = ref.watch(authProvider).user!;
    return POSNotifier(db, tableId, user, ref);
  }
);

// ── Kitchen state ─────────────────────────────────────
class KitchenNotifier extends StateNotifier<List<OrderEntity>> {
  KitchenNotifier(this._db) : super([]) { _load(); }
  final AppDatabase _db;

  Future<void> _load() async {
    final rows = await _db.orderDao.kitchenPending();
    final orders = await Future.wait(rows.map((r) => _buildOrder(_db, r)));
    state = orders;
  }

  Future<void> markItemPreparing(int itemId) async {
    await _db.orderDao.updateItem(OrderItemsCompanion(id: Value(itemId), status: const Value('preparing')));
    await _load();
  }

  Future<void> markItemReady(int itemId) async {
    await _db.orderDao.updateItem(OrderItemsCompanion(id: Value(itemId), status: const Value('ready')));
    await _load();
  }

  Future<void> markOrderReady(int orderId) async {
    await _db.orderDao.updateOrder(OrdersCompanion(id: Value(orderId), status: const Value('ready')));
    await _load();
  }

  void refresh() => _load();
}

final kitchenProvider = StateNotifierProvider<KitchenNotifier, List<OrderEntity>>(
  (ref) => KitchenNotifier(ref.watch(dbProvider)));

// ── Cash Register ─────────────────────────────────────
class RegisterNotifier extends StateNotifier<CashRegisterEntity?> {
  RegisterNotifier(this._db) : super(null) { _load(); }
  final AppDatabase _db;

  Future<void> _load() async {
    final row = await _db.registerDao.openRegister();
    if (row == null) { state = null; return; }
    state = _map(row);
  }

  Future<void> openRegister(String openedBy, double openingCash) async {
    await _db.registerDao.open(CashRegistersCompanion.insert(
      openedBy: openedBy, openingCash: openingCash,
    ));
    await _load();
  }

  Future<CashRegisterEntity?> closeRegister(String closedBy, double closingCash) async {
    final reg = state;
    if (reg == null) return null;
    await _db.registerDao.update_(reg.id, CashRegistersCompanion(
      status: const Value('closed'), closedBy: Value(closedBy),
      closedAt: Value(DateTime.now()), closingCash: Value(closingCash),
    ));
    final closed = state!.copyWith(closingCash);
    state = null;
    return closed;
  }

  Future<void> addExpense(String category, double amount, String desc, String paidBy) async {
    final reg = state;
    if (reg == null) return;
    await _db.registerDao.addExpense(ExpensesCompanion.insert(
      category: category, amount: amount, description: desc,
      paidBy: paidBy, registerId: Value(reg.id),
    ));
    await _db.registerDao.update_(reg.id, CashRegistersCompanion(
      totalExpenses: Value(reg.totalExpenses + amount),
    ));
    await _load();
  }

  Future<void> cashIn(double amount, String by) async {
    final reg = state;
    if (reg == null) return;
    await _db.registerDao.update_(reg.id, CashRegistersCompanion(cashIn: Value(reg.cashIn + amount)));
    await _load();
  }

  Future<void> cashOut(double amount, String by) async {
    final reg = state;
    if (reg == null) return;
    await _db.registerDao.update_(reg.id, CashRegistersCompanion(cashOut: Value(reg.cashOut + amount)));
    await _load();
  }

  CashRegisterEntity _map(CashRegisterRow r) => CashRegisterEntity(
    id: r.id, openedBy: r.openedBy, openingCash: r.openingCash,
    openedAt: r.openedAt, status: r.status == 'open' ? RegisterStatus.open : RegisterStatus.closed,
    closedAt: r.closedAt, closedBy: r.closedBy, closingCash: r.closingCash,
    totalCashSales: r.totalCashSales, totalCardSales: r.totalCardSales,
    totalWalletSales: r.totalWalletSales, totalCreditSales: r.totalCreditSales,
    totalExpenses: r.totalExpenses, cashIn: r.cashIn, cashOut: r.cashOut,
    totalOrders: r.totalOrders, totalKitchenTickets: r.totalKitchenTickets,
    totalDiscounts: r.totalDiscounts, totalTax: r.totalTax, totalVoids: r.totalVoids,
  );
}

extension RegCopyWith on CashRegisterEntity {
  CashRegisterEntity copyWith(double closingCash) => CashRegisterEntity(
    id: id, openedBy: openedBy, openingCash: openingCash, openedAt: openedAt,
    status: RegisterStatus.closed, closedAt: DateTime.now(), closedBy: closedBy,
    closingCash: closingCash, totalCashSales: totalCashSales, totalCardSales: totalCardSales,
    totalWalletSales: totalWalletSales, totalCreditSales: totalCreditSales,
    totalExpenses: totalExpenses, cashIn: cashIn, cashOut: cashOut,
    totalOrders: totalOrders, totalKitchenTickets: totalKitchenTickets,
    totalDiscounts: totalDiscounts, totalTax: totalTax, totalVoids: totalVoids,
  );
}

final registerProvider = StateNotifierProvider<RegisterNotifier, CashRegisterEntity?>(
  (ref) => RegisterNotifier(ref.watch(dbProvider)));

// ── Customers ─────────────────────────────────────────
final customersProvider = StreamProvider<List<CustomerEntity>>((ref) {
  return ref.watch(dbProvider).customerDao.watchAll().map((rows) => rows.map((r) => CustomerEntity(
    id: r.id, name: r.name, phone: r.phone, address: r.address,
    creditLimit: r.creditLimit, balance: r.balance, loyaltyPoints: r.loyaltyPoints,
    createdAt: r.createdAt,
  )).toList());
});

// ── HR / Attendance ───────────────────────────────────
final todayAttendanceProvider = StreamProvider<List<AttendanceEntity>>((ref) {
  return ref.watch(dbProvider).hRDao.watchToday().map((rows) => rows.map((r) => AttendanceEntity(
    id: r.id, userId: r.userId, userName: r.userName,
    checkIn: r.checkIn, checkOut: r.checkOut, dailyWage: r.dailyWage,
  )).toList());
});

final staffProvider = StreamProvider<List<UserEntity>>((ref) {
  return ref.watch(dbProvider).userDao.watchAll().map((rows) => rows.map((r) => UserEntity(
    id: r.id, name: r.name, email: r.email,
    role: UserRole.values.firstWhere((u) => u.name == r.role, orElse: () => UserRole.waiter),
    phone: r.phone, photoPath: r.photoPath, salary: r.salary,
    wageType: r.wageType == 'daily' ? WageType.daily : WageType.monthly,
    isActive: r.isActive, createdAt: r.createdAt,
  )).toList());
});

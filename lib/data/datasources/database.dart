// ═══════════════════════════════════════════════════════
// COMPLETE DATABASE — All tables, DAOs, seed data
// ═══════════════════════════════════════════════════════

import 'dart:io';
import 'dart:convert';
import 'package:drift/drift.dart';
import 'package:drift/native.dart';
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart' as p;
import 'package:crypto/crypto.dart';

part 'database.g.dart';

class VoidedKitchenItem {
  final String itemName;
  final int quantity;
  final String orderNumber;
  final String tableName;
  final int ticketNumber;
  final String waiterName;
  final DateTime sentAt;
  const VoidedKitchenItem({
    required this.itemName, required this.quantity,
    required this.orderNumber, required this.tableName,
    required this.ticketNumber, required this.waiterName,
    required this.sentAt,
  });
}

// Typedef aliases to bridge generated Drift class names with codebase references
typedef UserRow = User;
typedef FloorRow = Floor;
typedef RestaurantTableRow = RestaurantTable;
typedef MenuGroupRow = MenuGroup;
typedef MenuItemRow = MenuItem;
typedef OrderRow = Order;
typedef OrderItemRow = OrderItem;
typedef InvoiceRow = Invoice;
typedef CustomerRow = Customer;
typedef CreditLedgerRow = CreditLedgerData;
typedef ExpenseRow = Expense;
typedef CashRegisterRow = CashRegister;
typedef ShiftAuditLogRow = ShiftAuditLog;
typedef AttendanceRow = AttendanceData;
typedef SalaryPaymentRow = SalaryPayment;
typedef DealRow = Deal;
typedef DealItemRow = DealItem;
typedef BackupHistoryRow = BackupHistory;

// ── TABLE DEFINITIONS ────────────────────────────────

class Users extends Table {
  IntColumn get id => integer().autoIncrement()();
  TextColumn get name => text()();
  TextColumn get email => text().unique()();
  TextColumn get passwordHash => text()();
  TextColumn get role => text()();
  TextColumn get phone => text().nullable()();
  TextColumn get photoPath => text().nullable()();
  RealColumn get salary => real().withDefault(const Constant(0.0))();
  TextColumn get wageType => text().withDefault(const Constant('monthly'))();
  BoolColumn get isActive => boolean().withDefault(const Constant(true))();
  TextColumn get permissionsJson => text().withDefault(const Constant('{}'))();
  DateTimeColumn get createdAt => dateTime().withDefault(currentDateAndTime)();
}

class Floors extends Table {
  IntColumn get id => integer().autoIncrement()();
  TextColumn get name => text()();
  TextColumn get prefix => text().withDefault(const Constant('T'))();
  IntColumn get sortOrder => integer().withDefault(const Constant(0))();
}

class RestaurantTables extends Table {
  IntColumn get id => integer().autoIncrement()();
  IntColumn get floorId => integer().references(Floors, #id)();
  TextColumn get name => text()();
  IntColumn get capacity => integer().withDefault(const Constant(4))();
  TextColumn get shape => text().withDefault(const Constant('rectangle'))();
  RealColumn get posX => real().withDefault(const Constant(50.0))();
  RealColumn get posY => real().withDefault(const Constant(50.0))();
  RealColumn get width => real().withDefault(const Constant(120.0))();
  RealColumn get height => real().withDefault(const Constant(90.0))();
  TextColumn get status => text().withDefault(const Constant('available'))();
  IntColumn get activeOrderId => integer().nullable()();
  TextColumn get waiterName => text().nullable()();
  IntColumn get guestCount => integer().withDefault(const Constant(0))();
  RealColumn get runningTotal => real().withDefault(const Constant(0.0))();
  DateTimeColumn get orderStartTime => dateTime().nullable()();
}

class MenuGroups extends Table {
  IntColumn get id => integer().autoIncrement()();
  TextColumn get name => text()();
  TextColumn get iconPath => text().withDefault(const Constant(''))();
  TextColumn get colorHex => text().withDefault(const Constant('#1A56DB'))();
  IntColumn get sortOrder => integer().withDefault(const Constant(0))();
  BoolColumn get isActive => boolean().withDefault(const Constant(true))();
}

class MenuItems extends Table {
  IntColumn get id => integer().autoIncrement()();
  IntColumn get groupId => integer().references(MenuGroups, #id)();
  TextColumn get name => text()();
  RealColumn get price => real()();
  RealColumn get costPrice => real().withDefault(const Constant(0.0))();
  TextColumn get description => text().nullable()();
  TextColumn get imagePath => text().nullable()();
  IntColumn get preparationMinutes => integer().withDefault(const Constant(10))();
  BoolColumn get isAvailable => boolean().withDefault(const Constant(true))();
  IntColumn get stockCount => integer().withDefault(const Constant(-1))();
  RealColumn get taxPercent => real().withDefault(const Constant(0.0))();
  IntColumn get sortOrder => integer().withDefault(const Constant(0))();
}

class Orders extends Table {
  IntColumn get id => integer().autoIncrement()();
  TextColumn get orderNumber => text().unique()();
  IntColumn get tableId => integer().references(RestaurantTables, #id)();
  @override
  String? get tableName => 'orders';
  TextColumn get tableNameCol => text().named('table_name')();
  IntColumn get waiterId => integer().references(Users, #id)();
  TextColumn get waiterName => text()();
  TextColumn get status => text().withDefault(const Constant('open'))();
  RealColumn get discountPercent => real().withDefault(const Constant(0.0))();
  RealColumn get discountAmount => real().withDefault(const Constant(0.0))();
  RealColumn get taxPercent => real().withDefault(const Constant(0.0))();
  RealColumn get serviceChargePercent => real().withDefault(const Constant(0.0))();
  RealColumn get serviceChargeFixed => real().withDefault(const Constant(0.0))();
  TextColumn get orderType => text().withDefault(const Constant('dine_in'))();
  IntColumn get riderId => integer().nullable()();
  TextColumn get riderName => text().nullable()();
  RealColumn get deliveryCharges => real().withDefault(const Constant(0.0))();
  TextColumn get notes => text().withDefault(const Constant(''))();
  IntColumn get kitchenTicketCount => integer().withDefault(const Constant(0))();
  IntColumn get guestCount => integer().withDefault(const Constant(1))();
  DateTimeColumn get createdAt => dateTime().withDefault(currentDateAndTime)();
  DateTimeColumn get paidAt => dateTime().nullable()();
  IntColumn get shiftId => integer().nullable()();
  IntColumn get registerId => integer().nullable()();
  DateTimeColumn get businessDate => dateTime().nullable()();
}

class OrderItems extends Table {
  IntColumn get id => integer().autoIncrement()();
  IntColumn get orderId => integer().references(Orders, #id, onDelete: KeyAction.cascade)();
  IntColumn get menuItemId => integer().nullable().references(MenuItems, #id)();
  TextColumn get menuItemName => text()();
  RealColumn get unitPrice => real()();
  RealColumn get costPrice => real().withDefault(const Constant(0.0))();
  IntColumn get quantity => integer()();
  TextColumn get notes => text().withDefault(const Constant(''))();
  TextColumn get status => text().withDefault(const Constant('pending'))();
  TextColumn get modifiersJson => text().withDefault(const Constant('[]'))();
  BoolColumn get isVoided => boolean().withDefault(const Constant(false))();
  DateTimeColumn get sentToKitchenAt => dateTime().nullable()();
  IntColumn get dealId => integer().nullable().references(Deals, #id)();
  TextColumn get dealItemsJson => text().nullable()();
  BoolColumn get isCustomItem => boolean().withDefault(const Constant(false))();
}

class Invoices extends Table {
  IntColumn get id => integer().autoIncrement()();
  TextColumn get invoiceNumber => text().unique()();
  IntColumn get orderId => integer().references(Orders, #id)();
  TextColumn get orderNumber => text()();
  @override
  String? get tableName => 'invoices';
  TextColumn get tableNameCol => text().named('table_name')();
  TextColumn get waiterName => text()();
  RealColumn get subtotal => real()();
  RealColumn get discountValue => real().withDefault(const Constant(0.0))();
  RealColumn get taxValue => real().withDefault(const Constant(0.0))();
  RealColumn get serviceChargeValue => real().withDefault(const Constant(0.0))();
  RealColumn get deliveryCharges => real().withDefault(const Constant(0.0))();
  RealColumn get grandTotal => real()();
  RealColumn get amountPaid => real()();
  RealColumn get changeAmount => real().withDefault(const Constant(0.0))();
  TextColumn get paymentMethod => text().withDefault(const Constant('cash'))();
  TextColumn get paymentSplitsJson => text().withDefault(const Constant('[]'))();
  TextColumn get status => text().withDefault(const Constant('proforma'))();
  IntColumn get customerId => integer().nullable()();
  BoolColumn get isVoided => boolean().withDefault(const Constant(false))();
  DateTimeColumn get createdAt => dateTime().withDefault(currentDateAndTime)();
  IntColumn get shiftId => integer().nullable()();
  IntColumn get registerId => integer().nullable()();
  DateTimeColumn get businessDate => dateTime().nullable()();
}

class Customers extends Table {
  IntColumn get id => integer().autoIncrement()();
  TextColumn get name => text()();
  TextColumn get phone => text().unique()();
  TextColumn get address => text().nullable()();
  RealColumn get creditLimit => real().withDefault(const Constant(0.0))();
  RealColumn get balance => real().withDefault(const Constant(0.0))();
  IntColumn get loyaltyPoints => integer().withDefault(const Constant(0))();
  DateTimeColumn get createdAt => dateTime().withDefault(currentDateAndTime)();
}

class CreditLedger extends Table {
  IntColumn get id => integer().autoIncrement()();
  IntColumn get customerId => integer().references(Customers, #id)();
  TextColumn get type => text()(); // 'debit' | 'payment'
  RealColumn get amount => real()();
  RealColumn get balanceAfter => real()();
  TextColumn get description => text().withDefault(const Constant(''))();
  IntColumn get invoiceId => integer().nullable()();
  DateTimeColumn get createdAt => dateTime().withDefault(currentDateAndTime)();
}

class InventoryItems extends Table {
  IntColumn get id => integer().autoIncrement()();
  TextColumn get name => text()();
  TextColumn get unit => text()();
  RealColumn get currentStock => real().withDefault(const Constant(0.0))();
  RealColumn get minStock => real().withDefault(const Constant(0.0))();
  RealColumn get costPerUnit => real().withDefault(const Constant(0.0))();
  IntColumn get supplierId => integer().nullable()();
  DateTimeColumn get expiryDate => dateTime().nullable()();
}

class CashRegisters extends Table {
  IntColumn get id => integer().autoIncrement()();
  TextColumn get openedBy => text()();
  RealColumn get openingCash => real()();
  DateTimeColumn get openedAt => dateTime().withDefault(currentDateAndTime)();
  TextColumn get status => text().withDefault(const Constant('open'))();
  TextColumn get closedBy => text().nullable()();
  DateTimeColumn get closedAt => dateTime().nullable()();
  RealColumn get closingCash => real().withDefault(const Constant(0.0))();
  RealColumn get totalCashSales => real().withDefault(const Constant(0.0))();
  RealColumn get totalCardSales => real().withDefault(const Constant(0.0))();
  RealColumn get totalWalletSales => real().withDefault(const Constant(0.0))();
  RealColumn get totalCreditSales => real().withDefault(const Constant(0.0))();
  RealColumn get totalExpenses => real().withDefault(const Constant(0.0))();
  RealColumn get cashIn => real().withDefault(const Constant(0.0))();
  RealColumn get cashOut => real().withDefault(const Constant(0.0))();
  IntColumn get totalOrders => integer().withDefault(const Constant(0))();
  IntColumn get totalKitchenTickets => integer().withDefault(const Constant(0))();
  RealColumn get totalDiscounts => real().withDefault(const Constant(0.0))();
  RealColumn get totalTax => real().withDefault(const Constant(0.0))();
  IntColumn get totalVoids => integer().withDefault(const Constant(0))();
  DateTimeColumn get businessDate => dateTime().nullable()();
  RealColumn get cashVariance => real().withDefault(const Constant(0.0))();
  TextColumn get closeReason => text().nullable()();
}

class ShiftAuditLogs extends Table {
  IntColumn get id => integer().autoIncrement()();
  TextColumn get action => text()(); // SHIFT_OPENED, SHIFT_CLOSED, SHIFT_FORCE_CLOSED, CASH_ADJUSTMENT, etc.
  IntColumn get userId => integer().nullable()();
  TextColumn get userName => text()();
  IntColumn get shiftId => integer().nullable()();
  TextColumn get shiftNumber => text().nullable()();
  TextColumn get reason => text().nullable()();
  TextColumn get oldValue => text().nullable()();
  TextColumn get newValue => text().nullable()();
  DateTimeColumn get createdAt => dateTime().withDefault(currentDateAndTime)();
}

class Expenses extends Table {
  IntColumn get id => integer().autoIncrement()();
  TextColumn get category => text()();
  RealColumn get amount => real()();
  TextColumn get description => text()();
  TextColumn get paidBy => text()();
  IntColumn get registerId => integer().nullable()();
  DateTimeColumn get createdAt => dateTime().withDefault(currentDateAndTime)();
}

class CashTransactions extends Table {
  IntColumn get id => integer().autoIncrement()();
  IntColumn get registerId => integer()();
  TextColumn get type => text()(); // 'cash_in', 'cash_out', 'expense'
  RealColumn get amount => real()();
  TextColumn get note => text().withDefault(const Constant(''))();
  TextColumn get createdBy => text().withDefault(const Constant('System'))();
  DateTimeColumn get createdAt => dateTime().withDefault(currentDateAndTime)();
}

class Attendance extends Table {
  IntColumn get id => integer().autoIncrement()();
  IntColumn get userId => integer().references(Users, #id)();
  TextColumn get userName => text()();
  DateTimeColumn get checkIn => dateTime()();
  DateTimeColumn get checkOut => dateTime().nullable()();
  RealColumn get dailyWage => real().withDefault(const Constant(0.0))();
}

class SalaryPayments extends Table {
  IntColumn get id => integer().autoIncrement()();
  IntColumn get userId => integer().references(Users, #id)();
  TextColumn get userName => text()();
  IntColumn get month => integer()();
  IntColumn get year => integer()();
  RealColumn get amount => real()();
  TextColumn get notes => text().nullable()();
  DateTimeColumn get paidAt => dateTime().withDefault(currentDateAndTime)();
}

class AppSettings extends Table {
  IntColumn get id => integer().autoIncrement()();
  TextColumn get key => text().unique()();
  TextColumn get value => text()();
  DateTimeColumn get updatedAt => dateTime().withDefault(currentDateAndTime)();
}

class Deals extends Table {
  IntColumn get id => integer().autoIncrement()();
  TextColumn get name => text()();
  TextColumn get code => text().nullable()();
  RealColumn get price => real()();
  TextColumn get description => text().nullable()();
  BoolColumn get isActive => boolean().withDefault(const Constant(true))();
  TextColumn get imagePath => text().nullable()();
  DateTimeColumn get createdAt => dateTime().withDefault(currentDateAndTime)();
}

class DealItems extends Table {
  IntColumn get id => integer().autoIncrement()();
  IntColumn get dealId => integer().references(Deals, #id, onDelete: KeyAction.cascade)();
  IntColumn get menuItemId => integer().references(MenuItems, #id)();
  IntColumn get quantity => integer()();
}

class BackupHistories extends Table {
  IntColumn get id => integer().autoIncrement()();
  DateTimeColumn get createdAt => dateTime().withDefault(currentDateAndTime)();
  TextColumn get location => text()();
  TextColumn get status => text()(); // 'success' | 'failed'
  TextColumn get errorMessage => text().nullable()();
  RealColumn get sizeBytes => real().withDefault(const Constant(0.0))();
}

@DriftAccessor(tables: [Deals, DealItems, BackupHistories])
class DealDao extends DatabaseAccessor<AppDatabase> with _$DealDaoMixin {
  DealDao(super.db);

  Stream<List<Deal>> watchAll() =>
    (select(deals)..orderBy([(d) => OrderingTerm.desc(d.createdAt)])).watch();

  Future<List<Deal>> getActiveDeals() =>
    (select(deals)..where((d) => d.isActive.equals(true))..orderBy([(d) => OrderingTerm.desc(d.createdAt)])).get();

  Future<List<Deal>> getAllDeals() =>
    (select(deals)..orderBy([(d) => OrderingTerm.desc(d.createdAt)])).get();

  Future<Deal?> byId(int id) =>
    (select(deals)..where((d) => d.id.equals(id))).getSingleOrNull();

  Future<List<DealItem>> itemsForDeal(int dealId) =>
    (select(dealItems)..where((i) => i.dealId.equals(dealId))).get();

  Future<int> insertDeal(DealsCompanion c) => into(deals).insert(c);

  Future<void> updateDeal(DealsCompanion c) =>
    (update(deals)..where((d) => d.id.equals(c.id.value))).write(c);

  Future<void> deleteDeal(int id) => (delete(deals)..where((d) => d.id.equals(id))).go();

  Future<int> insertDealItem(DealItemsCompanion c) => into(dealItems).insert(c);

  Future<void> deleteItemsForDeal(int dealId) =>
    (delete(dealItems)..where((i) => i.dealId.equals(dealId))).go();

  Future<List<BackupHistory>> getBackupHistory() =>
    (select(backupHistories)..orderBy([(b) => OrderingTerm.desc(b.createdAt)])).get();

  Future<int> insertBackupHistory(BackupHistoriesCompanion c) =>
    into(backupHistories).insert(c);
}

// ── DAOs ─────────────────────────────────────────────

@DriftAccessor(tables: [Users])
class UserDao extends DatabaseAccessor<AppDatabase> with _$UserDaoMixin {
  UserDao(super.db);
  Future<UserRow?> byEmail(String email) =>
    (select(users)..where((u) => u.email.equals(email))).getSingleOrNull();
  Future<UserRow?> byId(int id) =>
    (select(users)..where((u) => u.id.equals(id))).getSingleOrNull();
  Future<List<UserRow>> allUsers() => select(users).get();
  Stream<List<UserRow>> watchAll() =>
    (select(users)..where((u) => u.isActive.equals(true))..orderBy([(u) => OrderingTerm.asc(u.name)])).watch();
  Future<int> insert_(UsersCompanion c) => into(users).insert(c);
  Future<void> update_(UsersCompanion c) => (update(users)..where((u) => u.id.equals(c.id.value))).write(c);
  Future<bool> hasAdmin() async {
    final countExp = users.id.count();
    final query = selectOnly(users)..addColumns([countExp])..where(users.role.isIn(['owner', 'admin']));
    final result = await query.getSingle();
    final count = result.read(countExp);
    return count != null && count > 0;
  }
}

@DriftAccessor(tables: [Floors, RestaurantTables])
class TableDao extends DatabaseAccessor<AppDatabase> with _$TableDaoMixin {
  TableDao(super.db);
  Future<List<FloorRow>> allFloors() =>
    (select(floors)..orderBy([(f) => OrderingTerm.asc(f.sortOrder)])).get();
  Stream<List<RestaurantTableRow>> watchByFloor(int floorId) =>
    (select(restaurantTables)..where((t) => t.floorId.equals(floorId))).watch();
  Stream<List<RestaurantTableRow>> watchAll() =>
    select(restaurantTables).watch();
  Future<RestaurantTableRow?> byId(int id) =>
    (select(restaurantTables)..where((t) => t.id.equals(id))).getSingleOrNull();
  Future<void> setStatus(int id, String status, {int? orderId, String? waiterName, int? guestCount, double? runningTotal, DateTime? orderStartTime}) =>
    (update(restaurantTables)..where((t) => t.id.equals(id))).write(RestaurantTablesCompanion(
      status: Value(status),
      activeOrderId: orderId != null ? Value(orderId) : const Value.absent(),
      waiterName: waiterName != null ? Value(waiterName) : const Value.absent(),
      guestCount: guestCount != null ? Value(guestCount) : const Value.absent(),
      runningTotal: runningTotal != null ? Value(runningTotal) : const Value.absent(),
      orderStartTime: orderStartTime != null ? Value(orderStartTime) : const Value.absent(),
    ));
  Future<void> freeTable(int id) =>
    (update(restaurantTables)..where((t) => t.id.equals(id))).write(const RestaurantTablesCompanion(
      status: Value('available'), activeOrderId: Value(null),
      waiterName: Value(null), guestCount: Value(0),
      runningTotal: Value(0.0), orderStartTime: Value(null),
    ));
  Future<void> updatePosition(int id, double x, double y) =>
    (update(restaurantTables)..where((t) => t.id.equals(id))).write(RestaurantTablesCompanion(posX: Value(x), posY: Value(y)));
  Future<void> updateSize(int id, double w, double h) =>
    (update(restaurantTables)..where((t) => t.id.equals(id))).write(RestaurantTablesCompanion(width: Value(w), height: Value(h)));
  Future<void> updateRunningTotal(int id, double total) =>
    (update(restaurantTables)..where((t) => t.id.equals(id))).write(RestaurantTablesCompanion(runningTotal: Value(total)));
  Future<void> updateTable(int id, {String? name, int? capacity}) =>
    (update(restaurantTables)..where((t) => t.id.equals(id))).write(RestaurantTablesCompanion(
      name: name != null ? Value(name) : const Value.absent(),
      capacity: capacity != null ? Value(capacity) : const Value.absent(),
    ));
}

@DriftAccessor(tables: [MenuGroups, MenuItems])
class MenuDao extends DatabaseAccessor<AppDatabase> with _$MenuDaoMixin {
  MenuDao(super.db);
  Stream<List<MenuGroupRow>> watchGroups() =>
    (select(menuGroups)..where((g) => g.isActive.equals(true))..orderBy([(g) => OrderingTerm.asc(g.sortOrder)])).watch();
  Future<List<MenuGroupRow>> getGroups() =>
    (select(menuGroups)..where((g) => g.isActive.equals(true))..orderBy([(g) => OrderingTerm.asc(g.sortOrder)])).get();
  Stream<List<MenuItemRow>> watchByGroup(int groupId) =>
    (select(menuItems)..where((i) => i.groupId.equals(groupId) & i.isAvailable.equals(true))..orderBy([(i) => OrderingTerm.asc(i.sortOrder)])).watch();
  Future<List<MenuItemRow>> getByGroup(int groupId) =>
    (select(menuItems)..where((i) => i.groupId.equals(groupId))..orderBy([(i) => OrderingTerm.asc(i.sortOrder)])).get();
  Future<List<MenuItemRow>> search(String q) =>
    (select(menuItems)..where((i) => i.name.like('%$q%') & i.isAvailable.equals(true))).get();
  Future<MenuItemRow?> byId(int id) =>
    (select(menuItems)..where((i) => i.id.equals(id))).getSingleOrNull();
  Future<int> insertGroup(MenuGroupsCompanion c) => into(menuGroups).insert(c);
  Future<void> updateGroup(MenuGroupsCompanion c) => (update(menuGroups)..where((g) => g.id.equals(c.id.value))).write(c);
  Future<void> deleteGroup(int id) => (delete(menuGroups)..where((g) => g.id.equals(id))).go();
  Future<int> insertItem(MenuItemsCompanion c) => into(menuItems).insert(c);
  Future<void> updateItem(MenuItemsCompanion c) => (update(menuItems)..where((i) => i.id.equals(c.id.value))).write(c);
  Future<void> deleteItem(int id) => (delete(menuItems)..where((i) => i.id.equals(id))).go();
  Future<void> toggleAvailable(int id, bool val) =>
    (update(menuItems)..where((i) => i.id.equals(id))).write(MenuItemsCompanion(isAvailable: Value(val)));
}

@DriftAccessor(tables: [Orders, OrderItems])
class OrderDao extends DatabaseAccessor<AppDatabase> with _$OrderDaoMixin {
  OrderDao(super.db);
  Stream<List<OrderRow>> watchActive() =>
    (select(orders)..where((o) => o.status.isNotIn(['paid', 'cancelled']))..orderBy([(o) => OrderingTerm.desc(o.createdAt)])).watch();
  Future<OrderRow?> byId(int id) =>
    (select(orders)..where((o) => o.id.equals(id))).getSingleOrNull();
  Future<OrderRow?> activeForTable(int tableId) =>
    (select(orders)..where((o) => o.tableId.equals(tableId) & o.status.isNotIn(['paid', 'cancelled']))).getSingleOrNull();
  Future<List<OrderRow>> activeOrdersForTable(int tableId) =>
    (select(orders)..where((o) => o.tableId.equals(tableId) & o.status.isNotIn(['paid', 'cancelled']))).get();
  Future<List<OrderItemRow>> itemsForOrder(int orderId) =>
    (select(orderItems)..where((i) => i.orderId.equals(orderId))..orderBy([(i) => OrderingTerm.asc(i.id)])).get();
  Stream<List<OrderItemRow>> watchItemsForOrder(int orderId) =>
    (select(orderItems)..where((i) => i.orderId.equals(orderId))).watch();
  Future<int> insertOrder(OrdersCompanion c) => into(orders).insert(c);
  Future<void> updateOrder(OrdersCompanion c) => (update(orders)..where((o) => o.id.equals(c.id.value))).write(c);
  Future<int> insertItem(OrderItemsCompanion c) => into(orderItems).insert(c);
  Future<void> updateItem(OrderItemsCompanion c) => (update(orderItems)..where((i) => i.id.equals(c.id.value))).write(c);
  Future<void> removeItem(int id) => (delete(orderItems)..where((i) => i.id.equals(id))).go();
  Future<List<OrderRow>> forPeriod(DateTime start, DateTime end) =>
    (select(orders)..where((o) => o.createdAt.isBetweenValues(start, end))..orderBy([(o) => OrderingTerm.desc(o.createdAt)])).get();
  Future<List<OrderRow>> forShift(int shiftId) =>
    (select(orders)..where((o) => o.shiftId.equals(shiftId))..orderBy([(o) => OrderingTerm.asc(o.createdAt)])).get();
  Future<List<OrderRow>> withNullShift() =>
    (select(orders)..where((o) => o.shiftId.isNull())).get();
  Future<List<OrderRow>> byBusinessDate(DateTime day) {
    final d = DateTime(day.year, day.month, day.day);
    final next = d.add(const Duration(days: 1));
    return (select(orders)..where((o) => o.businessDate.isBetweenValues(d, next))..orderBy([(o) => OrderingTerm.asc(o.createdAt)])).get();
  }
  Future<bool> hasOrdersForTable(int tableId) async {
    final countExp = orders.id.count();
    final query = selectOnly(orders)
      ..addColumns([countExp])
      ..where(orders.tableId.equals(tableId));
    final result = await query.getSingle();
    final count = result.read(countExp);
    return count != null && count > 0;
  }
  // Kitchen: orders sent to the kitchen (not yet paid)
  Future<List<OrderRow>> kitchenPending() =>
    (select(orders)..where((o) => o.status.equals('kitchenSent'))..orderBy([(o) => OrderingTerm.asc(o.createdAt)])).get();
  // Kitchen: recently paid (done) orders — since the current register opened
  Future<List<OrderRow>> doneToday(DateTime since) =>
    (select(orders)
      ..where((o) => o.status.equals('paid') & o.paidAt.isBiggerThanValue(since))
      ..orderBy([(o) => OrderingTerm.desc(o.paidAt)])).get();
  // Kitchen: cancelled orders — since the current register opened
  Future<List<OrderRow>> cancelledToday(DateTime since) =>
    (select(orders)
      ..where((o) => o.status.equals('cancelled') & o.createdAt.isBiggerThanValue(since) & o.kitchenTicketCount.isBiggerOrEqualValue(1))
      ..orderBy([(o) => OrderingTerm.desc(o.createdAt)])).get();
  // Stream variants for real-time kitchen display
  Stream<List<OrderRow>> watchKitchenPending() =>
    (select(orders)..where((o) => o.status.equals('kitchenSent'))..orderBy([(o) => OrderingTerm.asc(o.createdAt)])).watch();
  Stream<List<OrderRow>> watchDoneToday(DateTime since) =>
    (select(orders)
      ..where((o) => o.status.equals('paid') & o.paidAt.isBiggerThanValue(since))
      ..orderBy([(o) => OrderingTerm.desc(o.paidAt)])).watch();
  Stream<List<OrderRow>> watchCancelledToday(DateTime since) =>
    (select(orders)
      ..where((o) => o.status.equals('cancelled') & o.createdAt.isBiggerThanValue(since) & o.kitchenTicketCount.isBiggerOrEqualValue(1))
      ..orderBy([(o) => OrderingTerm.desc(o.createdAt)])).watch();
  // Voided kitchen items: individual items voided from POS after kitchen ticket sent
  Stream<List<VoidedKitchenItem>> watchVoidedKitchenItems(DateTime since) {
    final q = select(orderItems).join([
      innerJoin(orders, orders.id.equalsExp(orderItems.orderId)),
    ])
      ..where(orderItems.isVoided.equals(true) & orderItems.sentToKitchenAt.isNotNull()
          & orders.createdAt.isBiggerThanValue(since))
      ..orderBy([OrderingTerm.desc(orderItems.sentToKitchenAt)]);
    return q.watch().map((rows) => rows.map((r) {
      final item = r.readTable(orderItems);
      final order = r.readTable(orders);
      return VoidedKitchenItem(
        itemName: item.menuItemName, quantity: item.quantity,
        orderNumber: order.orderNumber, tableName: order.tableNameCol,
        ticketNumber: order.kitchenTicketCount, waiterName: order.waiterName,
        sentAt: item.sentToKitchenAt!,
      );
    }).toList());
  }
}

@DriftAccessor(tables: [Invoices])
class InvoiceDao extends DatabaseAccessor<AppDatabase> with _$InvoiceDaoMixin {
  InvoiceDao(super.db);
  Future<int> insert_(InvoicesCompanion c) => into(invoices).insert(c);
  Future<void> void_(int id) => (update(invoices)..where((i) => i.id.equals(id))).write(const InvoicesCompanion(isVoided: Value(true)));
  Future<void> delete_(int id) => (delete(invoices)..where((i) => i.id.equals(id))).go();
  Future<InvoiceRow?> byId(int id) =>
    (select(invoices)..where((i) => i.id.equals(id))).getSingleOrNull();
  Future<List<InvoiceRow>> forPeriod(DateTime start, DateTime end) =>
    (select(invoices)..where((i) => i.createdAt.isBetweenValues(start, end) & i.isVoided.equals(false))..orderBy([(i) => OrderingTerm.desc(i.createdAt)])).get();
  Future<InvoiceRow?> byOrder(int orderId) =>
    (select(invoices)..where((i) => i.orderId.equals(orderId) & i.isVoided.equals(false))).getSingleOrNull();
  Future<List<InvoiceRow>> byShift(int shiftId) =>
    (select(invoices)..where((i) => i.shiftId.equals(shiftId) & i.isVoided.equals(false))..orderBy([(i) => OrderingTerm.asc(i.createdAt)])).get();
  Future<List<InvoiceRow>> byShiftIncludingVoided(int shiftId) =>
    (select(invoices)..where((i) => i.shiftId.equals(shiftId))..orderBy([(i) => OrderingTerm.asc(i.createdAt)])).get();
  Future<List<InvoiceRow>> withNullShift() =>
    (select(invoices)..where((i) => i.shiftId.isNull())).get();
  Future<List<InvoiceRow>> byBusinessDate(DateTime day) {
    final d = DateTime(day.year, day.month, day.day);
    final next = d.add(const Duration(days: 1));
    return (select(invoices)
      ..where((i) => i.businessDate.isBetweenValues(d, next) & i.isVoided.equals(false))
      ..orderBy([(i) => OrderingTerm.asc(i.createdAt)])).get();
  }
  Future<void> updateShift(int id, int shiftId, int registerId, DateTime businessDate) =>
    (update(invoices)..where((i) => i.id.equals(id))).write(InvoicesCompanion(
      shiftId: Value(shiftId), registerId: Value(registerId), businessDate: Value(businessDate),
    ));
}

@DriftAccessor(tables: [Customers, CreditLedger])
class CustomerDao extends DatabaseAccessor<AppDatabase> with _$CustomerDaoMixin {
  CustomerDao(super.db);
  Stream<List<CustomerRow>> watchAll() =>
    (select(customers)..orderBy([(c) => OrderingTerm.asc(c.name)])).watch();
  Future<CustomerRow?> byPhone(String phone) =>
    (select(customers)..where((c) => c.phone.equals(phone))).getSingleOrNull();
  Future<CustomerRow?> byId(int id) =>
    (select(customers)..where((c) => c.id.equals(id))).getSingleOrNull();
  Future<int> insert_(CustomersCompanion c) => into(customers).insert(c);
  Future<void> updateBalance(int id, double bal) =>
    (update(customers)..where((c) => c.id.equals(id))).write(CustomersCompanion(balance: Value(bal)));
  Future<List<CreditLedgerRow>> ledger(int customerId) =>
    (select(creditLedger)..where((l) => l.customerId.equals(customerId))..orderBy([(l) => OrderingTerm.desc(l.createdAt)])).get();
  Future<void> insertLedger(CreditLedgerCompanion c) => into(creditLedger).insert(c);
  Future<void> deleteCustomer(int id) =>
    (delete(customers)..where((c) => c.id.equals(id))).go();
  Future<void> deleteLedgerForCustomer(int customerId) =>
    (delete(creditLedger)..where((l) => l.customerId.equals(customerId))).go();
  Future<void> updateCustomer(int id, CustomersCompanion c) =>
    (update(customers)..where((cu) => cu.id.equals(id))).write(c);
  Future<CustomerRow?> byName(String name) =>
    (select(customers)..where((c) => c.name.equals(name))).getSingleOrNull();
}

@DriftAccessor(tables: [CashRegisters, Expenses, CashTransactions, ShiftAuditLogs])
class RegisterDao extends DatabaseAccessor<AppDatabase> with _$RegisterDaoMixin {
  RegisterDao(super.db);
  Future<CashRegisterRow?> openRegister() =>
    (select(cashRegisters)..where((r) => r.status.equals('open'))).getSingleOrNull();
  Stream<CashRegisterRow?> watchOpenRegister() =>
    (select(cashRegisters)..where((r) => r.status.equals('open'))).watchSingleOrNull();
  Future<int> open(CashRegistersCompanion c) => into(cashRegisters).insert(c);
  Future<void> update_(int id, CashRegistersCompanion c) =>
    (update(cashRegisters)..where((r) => r.id.equals(id))).write(c);
  Future<int> addExpense(ExpensesCompanion c) => into(expenses).insert(c);
  Future<void> updateExpense(int id, ExpensesCompanion c) =>
    (update(expenses)..where((e) => e.id.equals(id))).write(c);
  Future<void> deleteExpense(int id) =>
    (delete(expenses)..where((e) => e.id.equals(id))).go();
  Future<List<ExpenseRow>> expensesForRegister(int regId) =>
    (select(expenses)..where((e) => e.registerId.equals(regId))..orderBy([(e) => OrderingTerm.desc(e.createdAt)])).get();
  Future<List<ExpenseRow>> expensesForPeriod(DateTime start, DateTime end) =>
    (select(expenses)..where((e) => e.createdAt.isBetweenValues(start, end))..orderBy([(e) => OrderingTerm.desc(e.createdAt)])).get();

  // CashTransactions
  Future<int> addCashTransaction(CashTransactionsCompanion c) => into(cashTransactions).insert(c);
  Future<void> updateCashTransaction(int id, CashTransactionsCompanion c) =>
    (update(cashTransactions)..where((t) => t.id.equals(id))).write(c);
  Future<void> deleteCashTransaction(int id) =>
    (delete(cashTransactions)..where((t) => t.id.equals(id))).go();
  Future<List<CashTransaction>> transactionsForRegister(int regId) =>
    (select(cashTransactions)..where((t) => t.registerId.equals(regId))..orderBy([(t) => OrderingTerm.desc(t.createdAt)])).get();
  Future<double> sumCashIn(int regId) async {
    final q = selectOnly(cashTransactions)..addColumns([cashTransactions.amount.sum()])
      ..where(cashTransactions.registerId.equals(regId) & cashTransactions.type.equals('cash_in'));
    final r = await q.getSingleOrNull();
    return r?.read(cashTransactions.amount.sum()) ?? 0;
  }
  Future<double> sumCashOut(int regId) async {
    final q = selectOnly(cashTransactions)..addColumns([cashTransactions.amount.sum()])
      ..where(cashTransactions.registerId.equals(regId) & cashTransactions.type.equals('cash_out'));
    final r = await q.getSingleOrNull();
    return r?.read(cashTransactions.amount.sum()) ?? 0;
  }
  Future<double> sumExpenses(int regId) async {
    final q = selectOnly(cashTransactions)..addColumns([cashTransactions.amount.sum()])
      ..where(cashTransactions.registerId.equals(regId) & cashTransactions.type.equals('expense'));
    final r = await q.getSingleOrNull();
    return r?.read(cashTransactions.amount.sum()) ?? 0;
  }

  Future<List<CashRegisterRow>> history() =>
    (select(cashRegisters)..orderBy([(r) => OrderingTerm.desc(r.openedAt)])).get();
  Stream<List<CashRegisterRow>> watchHistory() =>
    (select(cashRegisters)..orderBy([(r) => OrderingTerm.desc(r.openedAt)])).watch();
  Future<List<CashRegisterRow>> historyForPeriod(DateTime start, DateTime end) =>
    (select(cashRegisters)..where((r) => r.openedAt.isBetweenValues(start, end))..orderBy([(r) => OrderingTerm.desc(r.openedAt)])).get();
  Future<List<CashRegisterRow>> historyForBusinessDay(DateTime day) {
    final d = DateTime(day.year, day.month, day.day);
    final next = d.add(const Duration(days: 1));
    return (select(cashRegisters)
      ..where((r) => r.businessDate.isBetweenValues(d, next))
      ..orderBy([(r) => OrderingTerm.desc(r.openedAt)])).get();
  }
  Future<CashRegisterRow?> byId(int id) =>
    (select(cashRegisters)..where((r) => r.id.equals(id))).getSingleOrNull();
  Future<List<CashRegisterRow>> allShifts() =>
    (select(cashRegisters)..orderBy([(r) => OrderingTerm.desc(r.openedAt)])).get();
  Future<List<CashRegisterRow>> shiftsForPeriod(DateTime start, DateTime end) =>
    (select(cashRegisters)
      ..where((r) => r.openedAt.isBetweenValues(start, end))
      ..orderBy([(r) => OrderingTerm.desc(r.openedAt)])).get();

  /// Returns the single register/shift whose open→close window contains [ts].
  /// Historically only one register was ever open at a time, so this is
  /// unambiguous. Used to backfill `shift_id` for invoices created before
  /// the shift field existed.
  Future<CashRegisterRow?> shiftContaining(DateTime ts) async {
    final rows = await (select(cashRegisters)..orderBy([(r) => OrderingTerm.asc(r.openedAt)])).get();
    for (final r in rows) {
      final opened = r.openedAt;
      final closed = r.closedAt ?? opened.add(const Duration(days: 365 * 5));
      if (!ts.isBefore(opened) && !ts.isAfter(closed)) return r;
    }
    return null;
  }

  // ── Shift Audit Log ───────────────────────────────
  Future<int> addAuditLog(ShiftAuditLogsCompanion c) => into(shiftAuditLogs).insert(c);
  Stream<List<ShiftAuditLogRow>> watchAuditLogsForShift(int shiftId) =>
    (select(shiftAuditLogs)..where((l) => l.shiftId.equals(shiftId))..orderBy([(l) => OrderingTerm.desc(l.createdAt)])).watch();
  Future<List<ShiftAuditLogRow>> auditLogsForShift(int shiftId) =>
    (select(shiftAuditLogs)..where((l) => l.shiftId.equals(shiftId))..orderBy([(l) => OrderingTerm.desc(l.createdAt)])).get();
  Future<List<ShiftAuditLogRow>> allAuditLogs() =>
    (select(shiftAuditLogs)..orderBy([(l) => OrderingTerm.desc(l.createdAt)])).get();
}

@DriftAccessor(tables: [Attendance, SalaryPayments])
class HRDao extends DatabaseAccessor<AppDatabase> with _$HRDaoMixin {
  HRDao(super.db);
  Stream<List<AttendanceRow>> watchToday() {
    final today = DateTime.now();
    final start = DateTime(today.year, today.month, today.day);
    final end = start.add(const Duration(days: 1));
    return (select(attendance)..where((a) => a.checkIn.isBetweenValues(start, end))).watch();
  }
  Future<AttendanceRow?> activeForUser(int userId) =>
    (select(attendance)..where((a) => a.userId.equals(userId) & a.checkOut.isNull())).getSingleOrNull();
  Future<int> checkIn(AttendanceCompanion c) => into(attendance).insert(c);
  Future<void> checkOut(int id, DateTime time) =>
    (update(attendance)..where((a) => a.id.equals(id))).write(AttendanceCompanion(checkOut: Value(time)));
  Future<List<AttendanceRow>> forPeriod(DateTime start, DateTime end) =>
    (select(attendance)..where((a) => a.checkIn.isBetweenValues(start, end))).get();
  Future<List<SalaryPaymentRow>> salaryForUser(int userId) =>
    (select(salaryPayments)..where((s) => s.userId.equals(userId))..orderBy([(s) => OrderingTerm.desc(s.paidAt)])).get();
  Stream<List<SalaryPaymentRow>> watchSalaryForUser(int userId) =>
    (select(salaryPayments)..where((s) => s.userId.equals(userId))..orderBy([(s) => OrderingTerm.desc(s.paidAt)])).watch();
  Future<List<SalaryPaymentRow>> salaryForUserMonth(int userId, int month, int year) =>
    (select(salaryPayments)..where((s) => s.userId.equals(userId) & s.month.equals(month) & s.year.equals(year))..orderBy([(s) => OrderingTerm.desc(s.paidAt)])).get();
  Future<double> totalSalaryPaidMonth(int userId, int month, int year) async {
    final q = selectOnly(salaryPayments)
      ..addColumns([salaryPayments.amount.sum()])
      ..where(salaryPayments.userId.equals(userId) & salaryPayments.month.equals(month) & salaryPayments.year.equals(year));
    final r = await q.getSingle();
    return r.read(salaryPayments.amount.sum()) ?? 0.0;
  }
  Future<void> paySalary(SalaryPaymentsCompanion c) => into(salaryPayments).insert(c);
  Future<void> updateSalaryPayment(int id, SalaryPaymentsCompanion c) =>
    (update(salaryPayments)..where((s) => s.id.equals(id))).write(c);
  Future<void> deleteSalaryPayment(int id) =>
    (delete(salaryPayments)..where((s) => s.id.equals(id))).go();
}

@DriftAccessor(tables: [AppSettings])
class SettingsDao extends DatabaseAccessor<AppDatabase> with _$SettingsDaoMixin {
  SettingsDao(super.db);
  Future<String?> get(String key) async {
    final row = await (select(appSettings)..where((s) => s.key.equals(key))).getSingleOrNull();
    return row?.value;
  }
  Future<void> set(String key, String value) async {
    final existing = await (select(appSettings)..where((s) => s.key.equals(key))).getSingleOrNull();
    if (existing != null) {
      await (update(appSettings)..where((s) => s.key.equals(key))).write(
        AppSettingsCompanion(value: Value(value), updatedAt: Value(DateTime.now())));
    } else {
      await into(appSettings).insert(
        AppSettingsCompanion.insert(key: key, value: value, updatedAt: Value(DateTime.now())));
    }
  }
  Future<Map<String, String>> getAll() async {
    final rows = await select(appSettings).get();
    return {for (final r in rows) r.key: r.value};
  }
}

// ── DATABASE ──────────────────────────────────────────

@DriftDatabase(tables: [
  Users, Floors, RestaurantTables, MenuGroups, MenuItems,
  Orders, OrderItems, Invoices, Customers, CreditLedger,
  InventoryItems, CashRegisters, Expenses, CashTransactions, Attendance,
  SalaryPayments, AppSettings, Deals, DealItems, BackupHistories, ShiftAuditLogs,
], daos: [UserDao, TableDao, MenuDao, OrderDao, InvoiceDao, CustomerDao, RegisterDao, HRDao, SettingsDao, DealDao])
class AppDatabase extends _$AppDatabase {
  AppDatabase([QueryExecutor? executor]) : super(executor ?? _open());

  @override int get schemaVersion => 8;

  @override MigrationStrategy get migration => MigrationStrategy(
    onCreate: (m) async {
      await m.createAll();
      await _seed();
    },
    onUpgrade: (m, from, to) async {
      if (from < 2) {
        await m.createTable(deals);
        await m.createTable(dealItems);
        await m.createTable(backupHistories);
        await m.addColumn(orderItems, orderItems.dealId);
        await m.addColumn(orderItems, orderItems.dealItemsJson);
      }
      if (from < 3) {
        await m.addColumn(floors, floors.prefix);
      }
      if (from < 4) {
        await m.addColumn(orders, orders.serviceChargeFixed);
      }
      if (from < 5) {
        await m.addColumn(orders, orders.orderType);
        await m.addColumn(orders, orders.riderId);
        await m.addColumn(orders, orders.riderName);
        await m.addColumn(orders, orders.deliveryCharges);
        await m.addColumn(invoices, invoices.deliveryCharges);
      }
      if (from < 6) {
        await m.createTable(cashTransactions);
      }
      if (from < 7) {
        await m.addColumn(orderItems, orderItems.costPrice);
        await m.addColumn(orderItems, orderItems.isCustomItem);
        await customStatement(
          'CREATE TABLE order_items_new ('
          'id INTEGER PRIMARY KEY AUTOINCREMENT,'
          'order_id INTEGER NOT NULL REFERENCES orders(id) ON DELETE CASCADE,'
          'menu_item_id INTEGER REFERENCES menu_items(id),'
          'menu_item_name TEXT NOT NULL,'
          'unit_price REAL NOT NULL,'
          'cost_price REAL NOT NULL DEFAULT 0.0,'
          'quantity INTEGER NOT NULL,'
          'notes TEXT NOT NULL DEFAULT \'\','
          'status TEXT NOT NULL DEFAULT \'pending\','
          'modifiers_json TEXT NOT NULL DEFAULT \'[]\','
          'is_voided INTEGER NOT NULL DEFAULT 0,'
          'sent_to_kitchen_at INTEGER,'
          'deal_id INTEGER REFERENCES deals(id),'
          'deal_items_json TEXT,'
          'is_custom_item INTEGER NOT NULL DEFAULT 0'
          ')',
        );
        await customStatement(
          'INSERT INTO order_items_new '
          '(id, order_id, menu_item_id, menu_item_name, unit_price, cost_price, quantity, notes, status, modifiers_json, is_voided, sent_to_kitchen_at, deal_id, deal_items_json, is_custom_item) '
          'SELECT id, order_id, menu_item_id, menu_item_name, unit_price, 0.0, quantity, notes, status, modifiers_json, is_voided, sent_to_kitchen_at, deal_id, deal_items_json, 0 '
          'FROM order_items',
        );
        await customStatement('DROP TABLE order_items');
        await customStatement('ALTER TABLE order_items_new RENAME TO order_items');
      }
      if (from < 8) {
        // Defensive: each step is guarded so a partially-applied migration
        // (e.g. an interrupted upgrade) can't crash a later open and make the
        // app fall back to a fresh setup screen on upgrade.
        try { await m.createTable(shiftAuditLogs); } catch (_) {}
        try { await m.addColumn(cashRegisters, cashRegisters.businessDate); } catch (_) {}
        try { await m.addColumn(cashRegisters, cashRegisters.cashVariance); } catch (_) {}
        try { await m.addColumn(cashRegisters, cashRegisters.closeReason); } catch (_) {}
        try { await m.addColumn(orders, orders.shiftId); } catch (_) {}
        try { await m.addColumn(orders, orders.registerId); } catch (_) {}
        try { await m.addColumn(orders, orders.businessDate); } catch (_) {}
        try { await m.addColumn(invoices, invoices.shiftId); } catch (_) {}
        try { await m.addColumn(invoices, invoices.registerId); } catch (_) {}
        try { await m.addColumn(invoices, invoices.businessDate); } catch (_) {}
      }
    },
    beforeOpen: (m) async {
      if (m.wasCreated) return;
      await _ensureDeliveryFloor();
      await _backfillShifts();
    },
  );

  /// Idempotent backfill: assigns shift_id/register_id/business_date to any
  /// historical order/invoice that predates the shift field. Because only one
  /// register was ever open at a time, the single register whose open→close
  /// window contains the transaction's timestamp is unambiguously its shift.
  Future<void> _backfillShifts() async {
    try {
      final nullOrders = await orderDao.withNullShift();
      for (final o in nullOrders) {
        final shift = await registerDao.shiftContaining(o.createdAt);
        if (shift != null) {
          final bd = shift.businessDate ?? DateTime(o.createdAt.year, o.createdAt.month, o.createdAt.day);
          await orderDao.updateOrder(OrdersCompanion(
            id: Value(o.id), shiftId: Value(shift.id),
            registerId: Value(shift.id), businessDate: Value(bd),
          ));
        }
      }
      final nullInvoices = await invoiceDao.withNullShift();
      for (final inv in nullInvoices) {
        final shift = await registerDao.shiftContaining(inv.createdAt);
        if (shift != null) {
          final bd = shift.businessDate ?? DateTime(inv.createdAt.year, inv.createdAt.month, inv.createdAt.day);
          await invoiceDao.updateShift(inv.id, shift.id, shift.id, bd);
        }
      }
    } catch (_) {
      // Non-fatal — leave any unmapped rows NULL; they stay in date reports.
    }
  }

  Future<void> _ensureDeliveryFloor() async {
    final existing = await select(floors).get();
    final hasDelivery = existing.any((f) => f.name == 'Delivery');
    if (!hasDelivery) {
      final sortOrder = existing.isEmpty ? 3 : (existing.map((f) => f.sortOrder).reduce((a, b) => a > b ? a : b) + 1);
      final floorId = await into(floors).insert(FloorsCompanion.insert(
        name: 'Delivery', prefix: const Value('D'), sortOrder: Value(sortOrder)));
      for (int i = 1; i <= 5; i++) {
        await into(restaurantTables).insert(RestaurantTablesCompanion.insert(
          floorId: floorId, name: 'Rider $i',
          capacity: const Value(1), shape: const Value('rider'),
          posX: Value(40.0 + (i - 1) * 200), posY: const Value(80),
        ));
      }
    }
    final settings = await settingsDao.getAll();
    if (!settings.containsKey('default_delivery_charges')) {
      await settingsDao.set('default_delivery_charges', '150');
    }
  }

  Future<void> _seed() async {
    final now = DateTime.now();

    // Seed floors
    final floorId = await into(floors).insert(FloorsCompanion.insert(name: 'Main Hall', prefix: const Value('T'), sortOrder: const Value(1)));
    final floor2 = await into(floors).insert(FloorsCompanion.insert(name: 'Roof Top', prefix: const Value('R'), sortOrder: const Value(2)));

    // Seed tables (main hall)
    for (int i = 1; i <= 8; i++) {
      final col = (i - 1) % 4;
      final row = (i - 1) ~/ 4;
      await into(restaurantTables).insert(RestaurantTablesCompanion.insert(
        floorId: floorId, name: 'T$i',
        capacity: const Value(4),
        posX: Value(40.0 + col * 200),
        posY: Value(60.0 + row * 180),
      ));
    }
    // Seed VIP tables
    for (int i = 9; i <= 12; i++) {
      final col = (i - 9) % 4;
      await into(restaurantTables).insert(RestaurantTablesCompanion.insert(
        floorId: floor2, name: 'R${i - 8}',
        capacity: const Value(6),
        posX: Value(40.0 + col * 220),
        posY: const Value(80),
      ));
    }

    // Seed Delivery floor with riders
    final floor3 = await into(floors).insert(FloorsCompanion.insert(name: 'Delivery', prefix: const Value('D'), sortOrder: const Value(3)));
    for (int i = 1; i <= 5; i++) {
      final col = (i - 1) % 5;
      await into(restaurantTables).insert(RestaurantTablesCompanion.insert(
        floorId: floor3, name: 'Rider $i',
        capacity: const Value(1),
        shape: const Value('rider'),
        posX: Value(40.0 + col * 200),
        posY: const Value(80),
      ));
    }

    // Seed menu groups
    final groups = [
      ('Karahi', '#E74C3C'),
      ('Biryani', '#2ECC71'),
      ('Beverages', '#3498DB'),
      ('BBQ', '#E67E22'),
      ('Desserts', '#9B59B6'),
      ('Rolls & Sandwiches', '#1ABC9C'),
    ];
    for (int i = 0; i < groups.length; i++) {
      final (name, color) = groups[i];
      final gid = await into(menuGroups).insert(MenuGroupsCompanion.insert(
        name: name, colorHex: Value(color), sortOrder: Value(i),
      ));

      // Seed items per group
      final items = _sampleItems(name, gid);
      for (int j = 0; j < items.length; j++) {
        final (iname, price, cost) = items[j];
        await into(menuItems).insert(MenuItemsCompanion.insert(
          groupId: gid, name: iname, price: price, costPrice: Value(cost),
          sortOrder: Value(j), taxPercent: const Value(17.0),
        ));
      }
    }

    // Seed settings
    await settingsDao.set('restaurant_name', 'Desi Dhaba Restaurant');
    await settingsDao.set('restaurant_address', 'Main Boulevard, Gulberg, Lahore');
    await settingsDao.set('restaurant_phone', '+92-42-35756789');
    await settingsDao.set('tax_percent', '17.0');
    await settingsDao.set('service_charge_percent', '10.0');
    await settingsDao.set('currency_symbol', 'Rs');
    await settingsDao.set('receipt_width', '80');
    await settingsDao.set('auto_kitchen_print', 'true');
    await settingsDao.set('default_delivery_charges', '150');
  }

  List<(String, double, double)> _sampleItems(String group, int gid) {
    return switch (group) {
      'Karahi' => [
        ('Chicken Karahi', 950, 450), ('Mutton Karahi', 1450, 750),
        ('White Karahi', 1100, 550), ('Beef Karahi', 1200, 600),
        ('Mix Karahi', 1350, 680),
      ],
      'Biryani' => [
        ('Chicken Biryani', 450, 200), ('Mutton Biryani', 650, 320),
        ('Beef Biryani', 550, 260), ('Prawn Biryani', 750, 380),
        ('Vegetable Biryani', 350, 150),
      ],
      'Beverages' => [
        ('Pepsi (Can)', 120, 60), ('Lassi (Sweet)', 150, 60),
        ('Fresh Juice', 200, 80), ('Chai', 80, 25),
        ('Mineral Water', 80, 30), ('Milkshake', 250, 100),
      ],
      'BBQ' => [
        ('Seekh Kebab (4 pcs)', 480, 230), ('Boti Kebab (4 pcs)', 520, 260),
        ('Chicken Tikka (6 pcs)', 680, 340), ('Tandoori Chicken', 850, 400),
        ('Chapli Kebab (2 pcs)', 360, 170),
      ],
      'Desserts' => [
        ('Gulab Jamun (3 pcs)', 180, 70), ('Kheer', 200, 80),
        ('Firni', 220, 90), ('Ice Cream (2 scoops)', 250, 100),
        ('Shahi Tukra', 300, 130),
      ],
      _ => [
        ('Chicken Roll', 280, 120), ('Beef Burger', 350, 160),
        ('Club Sandwich', 320, 140), ('Shawarma', 300, 130),
      ],
    };
  }
}

LazyDatabase _open() => LazyDatabase(() async {
  final dir = await getApplicationDocumentsDirectory();
  final file = File(p.join(dir.path, 'restaurant_pos', 'pos.db'));
  await file.parent.create(recursive: true);
  // Capture a pre-open snapshot so a failed migration/upgrade can be rolled
  // back from the backup folder. Non-fatal if it fails.
  await _backupBeforeOpen(file);
  return NativeDatabase.createInBackground(file);
});

/// Copies the current database (plus WAL/SHM sidecar files, so WAL-mode data
/// is included) to `restaurant_pos/backups/pos-<timestamp>.db` before the app
/// opens it. Keeps only the most recent [keepCount] backups to avoid clutter.
Future<void> _backupBeforeOpen(File dbFile, {int keepCount = 5}) async {
  try {
    if (!await dbFile.exists()) return; // fresh install — nothing to preserve
    final bakDir = Directory(p.join(dbFile.parent.path, 'backups'));
    await bakDir.create(recursive: true);
    final stamp = DateTime.now().millisecondsSinceEpoch;
    final dest = File(p.join(bakDir.path, 'pos-$stamp.db'));
    await dbFile.copy(dest.path);
    for (final suffix in ['-wal', '-shm']) {
      final src = File('${dbFile.path}$suffix');
      if (await src.exists()) {
        try { await src.copy('${dest.path}$suffix'); } catch (_) {}
      }
    }
    // Prune old backups, keeping the newest `keepCount`.
    final backups = bakDir.listSync().whereType<File>()
        .where((f) => f.path.endsWith('.db'))
        .toList()
      ..sort((a, b) => b.statSync().modified.compareTo(a.statSync().modified));
    for (final old in backups.skip(keepCount)) {
      try {
        old.deleteSync();
        for (final suffix in ['-wal', '-shm']) {
          final s = File('${old.path}$suffix');
          if (s.existsSync()) s.deleteSync();
        }
      } catch (_) {}
    }
  } catch (_) {
    // Backup is a safety net only — never block app startup on it.
  }
}

// ═══════════════════════════════════════════════════════
// DOMAIN ENTITIES — Complete business objects
// ═══════════════════════════════════════════════════════

import 'dart:convert';

// ── User & Roles ─────────────────────────────────────
enum UserRole { owner, admin, manager, cashier, waiter, kitchen, accountant }
enum WageType { monthly, daily, hourly }

class UserEntity {
  const UserEntity({
    required this.id, required this.name, required this.email,
    required this.role, this.phone, this.photoPath,
    this.salary = 0, this.wageType = WageType.monthly,
    this.isActive = true, this.permissions = const {},
    required this.createdAt,
  });
  final int id;
  final String name;
  final String email;
  final UserRole role;
  final String? phone;
  final String? photoPath;
  final double salary;
  final WageType wageType;
  final bool isActive;
  final Map<String, bool> permissions;
  final DateTime createdAt;

  bool can(String p) => permissions[p] ?? _defaults[role]?[p] ?? false;

  static const _defaults = <UserRole, Map<String, bool>>{
    UserRole.owner:     {'all': true, 'reports': true, 'void_bill': true, 'discount': true, 'manage_menu': true, 'manage_staff': true, 'close_register': true},
    UserRole.admin:     {'all': true, 'reports': true, 'void_bill': true, 'discount': true, 'manage_menu': true, 'manage_staff': true, 'close_register': true},
    UserRole.manager:   {'reports': true, 'void_bill': false, 'discount': true, 'manage_menu': true, 'manage_staff': false, 'close_register': true},
    UserRole.cashier:   {'void_bill': false, 'discount': false, 'close_register': true, 'process_payment': true},
    UserRole.waiter:    {'take_order': true},
    UserRole.kitchen:   {'view_kitchen': true},
    UserRole.accountant:{'reports': true, 'close_register': true},
  };

  UserEntity copyWith({String? name, String? phone, double? salary, bool? isActive, String? photoPath}) =>
    UserEntity(id: id, name: name ?? this.name, email: email, role: role,
      phone: phone ?? this.phone, photoPath: photoPath ?? this.photoPath,
      salary: salary ?? this.salary, wageType: wageType, isActive: isActive ?? this.isActive,
      permissions: permissions, createdAt: createdAt);
}

// ── Attendance & Wages ───────────────────────────────
class AttendanceEntity {
  const AttendanceEntity({
    required this.id, required this.userId, required this.userName,
    required this.checkIn, this.checkOut, this.dailyWage = 0,
  });
  final int id;
  final int userId;
  final String userName;
  final DateTime checkIn;
  final DateTime? checkOut;
  final double dailyWage;

  Duration get workedDuration => checkOut != null
      ? checkOut!.difference(checkIn)
      : DateTime.now().difference(checkIn);

  bool get isCheckedOut => checkOut != null;
}

class SalaryRecord {
  const SalaryRecord({
    required this.id, required this.userId, required this.userName,
    required this.month, required this.year, required this.amount,
    required this.paidAt, this.notes,
  });
  final int id;
  final int userId;
  final String userName;
  final int month;
  final int year;
  final double amount;
  final DateTime paidAt;
  final String? notes;
}

// ── Floor & Tables ───────────────────────────────────
enum TableStatus { available, occupied, reserved, cleaning }

class FloorEntity {
  const FloorEntity({required this.id, required this.name, required this.sortOrder});
  final int id;
  final String name;
  final int sortOrder;
}

class TableEntity {
  const TableEntity({
    required this.id, required this.floorId, required this.name,
    required this.capacity, required this.status,
    this.posX = 0, this.posY = 0, this.width = 120, this.height = 90,
    this.activeOrderId, this.waiterName, this.guestCount = 0,
    this.runningTotal = 0, this.orderStartTime, this.shape = 'rectangle',
  });
  final int id;
  final int floorId;
  final String name;
  final int capacity;
  final TableStatus status;
  final double posX, posY, width, height;
  final int? activeOrderId;
  final String? waiterName;
  final int guestCount;
  final double runningTotal;
  final DateTime? orderStartTime;
  final String shape;

  bool get isAvailable => status == TableStatus.available;
  bool get isOccupied => status == TableStatus.occupied;

  TableEntity copyWith({
    TableStatus? status, int? activeOrderId, String? waiterName,
    int? guestCount, double? runningTotal, DateTime? orderStartTime,
    double? posX, double? posY, double? width, double? height,
  }) => TableEntity(
    id: id, floorId: floorId, name: name, capacity: capacity,
    status: status ?? this.status, posX: posX ?? this.posX, posY: posY ?? this.posY,
    width: width ?? this.width, height: height ?? this.height,
    activeOrderId: activeOrderId ?? this.activeOrderId,
    waiterName: waiterName ?? this.waiterName,
    guestCount: guestCount ?? this.guestCount,
    runningTotal: runningTotal ?? this.runningTotal,
    orderStartTime: orderStartTime ?? this.orderStartTime,
    shape: shape,
  );
}

// ── Menu ─────────────────────────────────────────────
class MenuGroupEntity {
  const MenuGroupEntity({
    required this.id, required this.name, required this.iconPath,
    this.colorHex = '#1A56DB', this.sortOrder = 0, this.isActive = true,
  });
  final int id;
  final String name;
  final String iconPath; // local image path from management
  final String colorHex;
  final int sortOrder;
  final bool isActive;
}

class MenuItemEntity {
  const MenuItemEntity({
    required this.id, required this.groupId, required this.groupName,
    required this.name, required this.price, this.costPrice = 0,
    this.description, this.imagePath, this.preparationMinutes = 10,
    this.isAvailable = true, this.stockCount = -1, // -1 = unlimited
    this.taxPercent = 0, this.sortOrder = 0,
  });
  final int id;
  final int groupId;
  final String groupName;
  final String name;
  final double price;
  final double costPrice;
  final String? description;
  final String? imagePath;
  final int preparationMinutes;
  final bool isAvailable;
  final int stockCount;
  final double taxPercent;
  final int sortOrder;

  bool get hasImage => imagePath != null && imagePath!.isNotEmpty;
  bool get isUnlimited => stockCount == -1;
  bool get isOutOfStock => !isUnlimited && stockCount <= 0;
  bool get isLowStock => !isUnlimited && stockCount > 0 && stockCount <= 5;
  double get profit => price - costPrice;
}

// ── Orders ───────────────────────────────────────────
enum OrderStatus { open, hold, kitchenSent, ready, billPrinted, paid, cancelled }
enum OrderItemStatus { pending, sent, preparing, ready, served }

class OrderModifier {
  const OrderModifier({required this.name, required this.price});
  final String name;
  final double price;
}

class DealItemInfo {
  const DealItemInfo({required this.id, required this.name, required this.quantity});
  final int id;
  final String name;
  final int quantity;
}

class OrderItemEntity {
  const OrderItemEntity({
    required this.id, required this.orderId, required this.menuItem,
    required this.quantity, required this.unitPrice,
    this.notes = '', this.status = OrderItemStatus.pending,
    this.modifiers = const [], this.isVoided = false,
    this.sentToKitchenAt,
    this.dealId,
    this.dealItemsJson,
  });
  final int id;
  final int orderId;
  final MenuItemEntity menuItem;
  final int quantity;
  final double unitPrice;
  final String notes;
  final OrderItemStatus status;
  final List<OrderModifier> modifiers;
  final bool isVoided;
  final DateTime? sentToKitchenAt;
  final int? dealId;
  final String? dealItemsJson;

  bool get isDeal => dealId != null;

  List<DealItemInfo> get dealItems {
    if (dealItemsJson == null || dealItemsJson!.isEmpty) return [];
    try {
      final decoded = jsonDecode(dealItemsJson!) as List;
      return decoded.map((d) => DealItemInfo(
        id: d['id'] as int,
        name: d['name'] as String,
        quantity: d['quantity'] as int,
      )).toList();
    } catch (_) {
      return [];
    }
  }

  double get modTotal => modifiers.fold(0, (s, m) => s + m.price);
  double get lineTotal => (unitPrice + modTotal) * quantity;

  OrderItemEntity copyWith({int? quantity, OrderItemStatus? status, String? notes, bool? isVoided}) =>
    OrderItemEntity(id: id, orderId: orderId, menuItem: menuItem,
      quantity: quantity ?? this.quantity, unitPrice: unitPrice,
      notes: notes ?? this.notes, status: status ?? this.status,
      modifiers: modifiers, isVoided: isVoided ?? this.isVoided,
      sentToKitchenAt: sentToKitchenAt,
      dealId: dealId,
      dealItemsJson: dealItemsJson);
}

class OrderEntity {
  const OrderEntity({
    required this.id, required this.orderNumber, required this.tableId,
    required this.tableName, required this.waiterId, required this.waiterName,
    required this.items, required this.status,
    this.discountPercent = 0, this.discountAmount = 0,
    this.taxPercent = 0, this.serviceChargePercent = 0,
    this.notes = '', required this.createdAt, this.paidAt,
    this.kitchenTicketCount = 0, this.guestCount = 1,
  });
  final int id;
  final String orderNumber;
  final int tableId;
  final String tableName;
  final int waiterId;
  final String waiterName;
  final List<OrderItemEntity> items;
  final OrderStatus status;
  final double discountPercent;
  final double discountAmount;
  final double taxPercent;
  final double serviceChargePercent;
  final String notes;
  final DateTime createdAt;
  final DateTime? paidAt;
  final int kitchenTicketCount;
  final int guestCount;

  List<OrderItemEntity> get activeItems => items.where((i) => !i.isVoided).toList();
  double get subtotal => activeItems.fold(0, (s, i) => s + i.lineTotal);
  double get discountValue => discountAmount + (subtotal * discountPercent / 100);
  double get afterDiscount => subtotal - discountValue;
  double get taxValue => afterDiscount * taxPercent / 100;
  double get serviceChargeValue => afterDiscount * serviceChargePercent / 100;
  double get grandTotal => afterDiscount + taxValue + serviceChargeValue;
  int get totalItems => activeItems.fold(0, (s, i) => s + i.quantity);

  // Items pending kitchen
  List<OrderItemEntity> get pendingKitchenItems =>
    items.where((i) => !i.isVoided && i.status == OrderItemStatus.pending).toList();

  OrderEntity copyWith({
    List<OrderItemEntity>? items, OrderStatus? status,
    double? discountPercent, double? discountAmount,
    String? notes, int? kitchenTicketCount, DateTime? paidAt,
  }) => OrderEntity(
    id: id, orderNumber: orderNumber, tableId: tableId, tableName: tableName,
    waiterId: waiterId, waiterName: waiterName,
    items: items ?? this.items, status: status ?? this.status,
    discountPercent: discountPercent ?? this.discountPercent,
    discountAmount: discountAmount ?? this.discountAmount,
    taxPercent: taxPercent, serviceChargePercent: serviceChargePercent,
    notes: notes ?? this.notes, createdAt: createdAt, paidAt: paidAt ?? this.paidAt,
    kitchenTicketCount: kitchenTicketCount ?? this.kitchenTicketCount,
    guestCount: guestCount,
  );
}

// ── Billing / Invoice ────────────────────────────────
enum PaymentMethod { cash, card, bank, wallet, credit, split }
enum BillStatus { proforma, final_ }

class PaymentSplit {
  const PaymentSplit({required this.method, required this.amount});
  final PaymentMethod method;
  final double amount;
}

class InvoiceEntity {
  const InvoiceEntity({
    required this.id, required this.invoiceNumber, required this.orderId,
    required this.orderNumber, required this.tableName,
    required this.waiterName, required this.items,
    required this.subtotal, required this.discountValue,
    required this.taxValue, required this.serviceChargeValue,
    required this.grandTotal, required this.amountPaid,
    required this.paymentMethod, required this.status,
    required this.createdAt, this.customerId,
    this.paymentSplits = const [], this.changeAmount = 0,
    this.isVoided = false,
  });
  final int id;
  final String invoiceNumber;
  final int orderId;
  final String orderNumber;
  final String tableName;
  final String waiterName;
  final List<OrderItemEntity> items;
  final double subtotal;
  final double discountValue;
  final double taxValue;
  final double serviceChargeValue;
  final double grandTotal;
  final double amountPaid;
  final double changeAmount;
  final PaymentMethod paymentMethod;
  final BillStatus status;
  final DateTime createdAt;
  final int? customerId;
  final List<PaymentSplit> paymentSplits;
  final bool isVoided;
}

// ── Customers / Credit ───────────────────────────────
class CustomerEntity {
  const CustomerEntity({
    required this.id, required this.name, required this.phone,
    this.address, this.creditLimit = 0, this.balance = 0,
    this.loyaltyPoints = 0, required this.createdAt,
  });
  final int id;
  final String name;
  final String phone;
  final String? address;
  final double creditLimit;
  final double balance; // outstanding debt
  final int loyaltyPoints;
  final DateTime createdAt;

  double get availableCredit => creditLimit - balance;
  bool get hasDebt => balance > 0;
}

// ── Inventory ────────────────────────────────────────
class InventoryItem {
  const InventoryItem({
    required this.id, required this.name, required this.unit,
    required this.currentStock, required this.minStock,
    required this.costPerUnit, this.supplierId, this.expiryDate,
  });
  final int id;
  final String name;
  final String unit;
  final double currentStock;
  final double minStock;
  final double costPerUnit;
  final int? supplierId;
  final DateTime? expiryDate;
  bool get isLow => currentStock <= minStock;
}

// ── Cash Register ────────────────────────────────────
enum RegisterStatus { open, closed }

class CashRegisterEntity {
  const CashRegisterEntity({
    required this.id, required this.openedBy, required this.openingCash,
    required this.openedAt, required this.status,
    this.closedAt, this.closedBy, this.closingCash = 0,
    this.totalCashSales = 0, this.totalCardSales = 0,
    this.totalWalletSales = 0, this.totalCreditSales = 0,
    this.totalExpenses = 0, this.cashIn = 0, this.cashOut = 0,
    this.totalOrders = 0, this.totalKitchenTickets = 0,
    this.totalDiscounts = 0, this.totalTax = 0, this.totalVoids = 0,
  });
  final int id;
  final String openedBy;
  final double openingCash;
  final DateTime openedAt;
  final RegisterStatus status;
  final DateTime? closedAt;
  final String? closedBy;
  final double closingCash;
  final double totalCashSales;
  final double totalCardSales;
  final double totalWalletSales;
  final double totalCreditSales;
  final double totalExpenses;
  final double cashIn;
  final double cashOut;
  final int totalOrders;
  final int totalKitchenTickets;
  final double totalDiscounts;
  final double totalTax;
  final int totalVoids;

  bool get isOpen => status == RegisterStatus.open;
  double get totalSales => totalCashSales + totalCardSales + totalWalletSales + totalCreditSales;
  double get expectedCash => openingCash + totalCashSales + cashIn - cashOut - totalExpenses;
  double get cashDifference => closingCash - expectedCash;
}

class ExpenseEntity {
  const ExpenseEntity({
    required this.id, required this.category, required this.amount,
    required this.description, required this.paidBy, required this.createdAt,
  });
  final int id;
  final String category;
  final double amount;
  final String description;
  final String paidBy;
  final DateTime createdAt;
}

// ── Settings ─────────────────────────────────────────
class RestaurantSettings {
  const RestaurantSettings({
    this.name = 'My Restaurant',
    this.address = '',
    this.phone = '',
    this.email = '',
    this.taxNumber = '',
    this.footerMessage = 'Thank you for dining with us!',
    this.logoPath,
    this.taxPercent = 17.0,
    this.serviceChargePercent = 10.0,
    this.currencySymbol = 'Rs',
    this.receiptWidth = 80,
    this.autoKitchenPrint = true,
    this.autoPrintBillOnPay = true,
    this.autoBackupEnabled = false,
    this.autoBackupInterval = 'Every 24 Hours',
    this.autoBackupDestFolder = '',
    this.autoBackupLastTime = '',
    this.autoBackupNextTime = '',
    this.autoBackupStatus = 'Idle',
  });

  final String name;
  final String address;
  final String phone;
  final String email;
  final String taxNumber;
  final String footerMessage;
  final String? logoPath;
  final double taxPercent;
  final double serviceChargePercent;
  final String currencySymbol;
  final int receiptWidth;
  final bool autoKitchenPrint;
  final bool autoPrintBillOnPay;
  final bool autoBackupEnabled;
  final String autoBackupInterval;
  final String autoBackupDestFolder;
  final String autoBackupLastTime;
  final String autoBackupNextTime;
  final String autoBackupStatus;

  RestaurantSettings copyWith({
    String? name, String? address, String? phone, String? email,
    String? taxNumber, String? footerMessage, String? logoPath,
    double? taxPercent, double? serviceChargePercent, String? currencySymbol,
    int? receiptWidth, bool? autoKitchenPrint, bool? autoPrintBillOnPay,
    bool? autoBackupEnabled, String? autoBackupInterval, String? autoBackupDestFolder,
    String? autoBackupLastTime, String? autoBackupNextTime, String? autoBackupStatus,
  }) => RestaurantSettings(
    name: name ?? this.name, address: address ?? this.address,
    phone: phone ?? this.phone, email: email ?? this.email,
    taxNumber: taxNumber ?? this.taxNumber,
    footerMessage: footerMessage ?? this.footerMessage,
    logoPath: logoPath ?? this.logoPath,
    taxPercent: taxPercent ?? this.taxPercent,
    serviceChargePercent: serviceChargePercent ?? this.serviceChargePercent,
    currencySymbol: currencySymbol ?? this.currencySymbol,
    receiptWidth: receiptWidth ?? this.receiptWidth,
    autoKitchenPrint: autoKitchenPrint ?? this.autoKitchenPrint,
    autoPrintBillOnPay: autoPrintBillOnPay ?? this.autoPrintBillOnPay,
    autoBackupEnabled: autoBackupEnabled ?? this.autoBackupEnabled,
    autoBackupInterval: autoBackupInterval ?? this.autoBackupInterval,
    autoBackupDestFolder: autoBackupDestFolder ?? this.autoBackupDestFolder,
    autoBackupLastTime: autoBackupLastTime ?? this.autoBackupLastTime,
    autoBackupNextTime: autoBackupNextTime ?? this.autoBackupNextTime,
    autoBackupStatus: autoBackupStatus ?? this.autoBackupStatus,
  );
}

// ═══════════════════════════════════════════════════════
// PRINT SERVICE — Kitchen tickets, bills, invoices, reports
// ═══════════════════════════════════════════════════════

import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';
import 'package:flutter/services.dart' show rootBundle;
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:printing/printing.dart';
import 'package:intl/intl.dart';
import 'package:file_picker/file_picker.dart';
import 'package:open_filex/open_filex.dart';

import '../data/datasources/database.dart';
import '../domain/entities.dart';
import 'thermal_layout.dart';
import 'utils/app_paths.dart';

/// Thrown by [PrintService] when a print/save operation cannot complete.
class PrintException implements Exception {
  final String message;
  const PrintException(this.message);
  @override
  String toString() => message;
}

/// Per-item shift stats: how many times it was ordered, how much was sold,
/// and how much actually went to the kitchen. Comparing sold vs kitchen
/// catches items that were entered but never sent, or prepared but not billed.
class ReportItemStat {
  final String name;
  final int orderCount;
  final int qty;
  final int kitchenQty;
  final double amount;
  const ReportItemStat(this.name, this.orderCount, this.qty, this.kitchenQty, [this.amount = 0]);

  bool get discrepancy => kitchenQty < qty;
}

/// Shift data gathered from the database for the Z report.
class ReportData {
  final int completedOrders;
  final int totalItemsSold;
  final int voidedOrders;
  final List<String> cancelledOrderNumbers;
  final List<CancelledItemEntry> cancelledItems;
  final int kitchenGenerated;
  final int kitchenCompleted;
  final int voidedKitchen;
  final int kitchenItemsSent;
  final double totalServiceCharge;
  final double invoiceCashTotal;
  final double invoiceCardTotal;
  final double invoiceWalletTotal;
  final double invoiceCreditTotal;
  final List<ReportItemStat> itemSales;
  final List<ReportItemStat> kitchenItems;
  const ReportData({
    this.completedOrders = 0,
    this.totalItemsSold = 0,
    this.voidedOrders = 0,
    this.cancelledOrderNumbers = const [],
    this.cancelledItems = const [],
    this.kitchenGenerated = 0,
    this.kitchenCompleted = 0,
    this.voidedKitchen = 0,
    this.kitchenItemsSent = 0,
    this.totalServiceCharge = 0,
    this.invoiceCashTotal = 0,
    this.invoiceCardTotal = 0,
    this.invoiceWalletTotal = 0,
    this.invoiceCreditTotal = 0,
    this.itemSales = const [],
    this.kitchenItems = const [],
  });
}

class CancelledItemEntry {
  final String orderNumber;
  final int ticketNumber;
  final String itemName;
  final int quantity;
  const CancelledItemEntry(this.orderNumber, this.ticketNumber, this.itemName, this.quantity);
}

class PrintService {
  static final PrintService instance = PrintService._();
  PrintService._();

  RestaurantSettings _settings = const RestaurantSettings();
  AppDatabase? _db;
  void configure(RestaurantSettings s) => _settings = s;
  void setDatabase(AppDatabase db) => _db = db;

  /// 'thermal' → direct print to the selected printer (no OS dialog).
  /// Anything else → generate a PDF the user saves to disk.
  String get printerMode => _settings.printerMode == 'thermal' ? 'thermal' : 'pdf';

  /// Lists printers installed on this machine.
  Future<List<Printer>> listPrinters() => Printing.listPrinters();

  // ── Output dispatcher ──────────────────────────────
  // Builds the document bytes then outputs them according to the
  // configured printer mode:
  //   thermal → find the saved printer and send the job directly
  //             (winspool), never opening an OS dialog. The page is built
  //             with the printer's real geometry so nothing gets clipped.
  //   pdf     → saves the 80mm PDF via a save dialog, no printer dialog.
  Future<void> _emit(String name, Future<Uint8List> Function(PdfPageFormat) build) async {
    final fixedFormat = _fixedLayout.pageFormat;
    if (printerMode == 'thermal') {
      final printers = await Printing.listPrinters();
      final selected = _settings.selectedPrinterName;
      if (selected.isEmpty) {
        throw const PrintException('Please select a printer in Printer Settings.');
      }
      Printer? printer;
      for (final p in printers) {
        if (p.name == selected) {
          printer = p;
          break;
        }
      }
      if (printer == null || !printer.isAvailable) {
        throw const PrintException('Thermal printer is not connected.');
      }
      // Build the format for the printer driver. We explicitly set the
      // margins to our safe margins (2mm left, 5mm right) so the driver
      // knows the content area. The right margin is intentionally larger
      // because thermal printers have a wider unprintable zone on the
      // right edge. Height is set to a very large value so the driver
      // does not cut or paginate at a fixed page boundary on roll paper.
      final thermalFormat = PdfPageFormat(
        fixedFormat.width,
        9999 * PdfPageFormat.mm,
        marginLeft: fixedFormat.marginLeft,
        marginTop: fixedFormat.marginTop,
        marginRight: fixedFormat.marginRight,
        marginBottom: fixedFormat.marginBottom,
      );
      await Printing.directPrintPdf(
        printer: printer,
        format: thermalFormat,
        onLayout: (_) async {
          final bytes = await build(thermalFormat);
          return bytes;
        },
        name: name,
      );
    } else {
      final bytes = await build(fixedFormat);
      final path = await FilePicker.platform.saveFile(
        dialogTitle: 'Save $name as PDF',
        fileName: '$name.pdf',
        type: FileType.custom,
        allowedExtensions: ['pdf'],
      );
      if (path == null) {
        throw const PrintException('PDF save canceled.');
      }
      await File(path).writeAsBytes(bytes);
      OpenFilex.open(path);
    }
  }

  // ── Test print ─────────────────────────────────────
  // Prints a small diagnostic page through the current mode.
  Future<void> testPrint() => _emit('Printer-Test', (format) async {
    final t = _layout(format: format);
    final pdf = pw.Document();
    pdf.addPage(pw.Page(
      pageFormat: t.pageFormat,
      build: (ctx) => pw.Column(crossAxisAlignment: pw.CrossAxisAlignment.start, children: [
        pw.SizedBox(height: 4),
        t.center('PRINTER TEST', font: thermalBold, size: 14),
        pw.SizedBox(height: 3),
        t.center(_settings.name, font: thermalRegular, size: 8),
        pw.SizedBox(height: 4),
        t.dashedLine(),
        t.row('Mode', printerMode.toUpperCase(), size: 9, font: thermalBold),
        t.row('Printer', _settings.selectedPrinterName.isEmpty ? 'Default' : _settings.selectedPrinterName, size: 9, font: thermalRegular),
        t.row('Width', '80mm', size: 9, font: thermalRegular),
        t.row('Time', _df.format(DateTime.now()), size: 9, font: thermalRegular),
        t.dashedLine(h: 1.4),
        pw.SizedBox(height: 4),
        t.credit(thermalRegular, 7),
      ]),
    ));
    return pdf.save();
  });

  final _df = DateFormat('dd/MM/yyyy h:mm a');
  final _tf = DateFormat('h:mm a');
  final _dtf = DateFormat('dd MMM yyyy');

  String _dealSummary(OrderItemEntity item) =>
      item.dealItems.map((d) => '${d.quantity}x ${d.name}').join(', ');

  // ── Layout helper ──────────────────────────────────
  // Always 80mm thermal — identical layout for PDF and thermal print.
  // 3mm margin on each side keeps content in the safe printable zone.
  static final _fixedLayout = ThermalLayout(paperWidthMm: 80);

  ThermalLayout _layout({PdfPageFormat? format}) {
    if (format != null) return ThermalLayout.fromFormat(format);
    return _fixedLayout;
  }

  // ── Fonts ──────────────────────────────────────────
  static pw.Font get bold => pw.Font.helveticaBold();
  static pw.Font get regular => pw.Font.helvetica();
  // Monospace thermal/dot-matrix fonts for POS receipts.
  static pw.Font get thermalBold => pw.Font.courierBold();
  static pw.Font get thermalRegular => pw.Font.courier();

  // ── Shift data for reports ─────────────────────────
  // Everything is calculated from the real database: paid invoices,
  // their items (grouped by name), voided orders and kitchen activity
  // since the current register opened. Each item records how many times
  // it was ordered and how much actually went to the kitchen, so the
  // X/Z report can be checked against the printed kitchen tickets.
  Future<ReportData> _collectShiftData(DateTime since) async {
    final db = _db;
    if (db == null) return const ReportData();
    final now = DateTime.now();
    final invoices = await db.invoiceDao.forPeriod(since, now);
    final orders = await db.orderDao.forPeriod(since, now);
    return _computeShiftData(invoices, orders);
  }

  /// Shift-accurate variant: gathers every transaction that belongs to the
  /// given shift (by `shift_id`), so an overnight shift correctly includes
  /// invoices created after midnight. This is what the X/Z reports use.
  Future<ReportData> _collectShiftDataForShift(int shiftId) async {
    final db = _db;
    if (db == null) return const ReportData();
    final invoices = await db.invoiceDao.byShiftIncludingVoided(shiftId);
    final orders = await db.orderDao.forShift(shiftId);
    return _computeShiftData(invoices, orders);
  }

  Future<ReportData> _computeShiftData(List<InvoiceRow> invoices, List<OrderRow> orders) async {
    final db = _db;
    if (db == null) return const ReportData();
    final soldQty = <String, int>{};
    final soldAmount = <String, double>{};
    final soldOrders = <String, Set<int>>{};
    final cancelledItems = <CancelledItemEntry>[];
    var totalItems = 0;
    for (final order in orders) {
      final items = await db.orderDao.itemsForOrder(order.id);
      for (final it in items) {
        if (it.isVoided) {
          cancelledItems.add(CancelledItemEntry(
            order.orderNumber, order.kitchenTicketCount, it.menuItemName, it.quantity));
          continue;
        }
        soldQty[it.menuItemName] = (soldQty[it.menuItemName] ?? 0) + it.quantity;
        soldAmount[it.menuItemName] = (soldAmount[it.menuItemName] ?? 0) + (it.unitPrice * it.quantity);
        (soldOrders[it.menuItemName] ??= <int>{}).add(order.id);
        totalItems += it.quantity;
      }
    }

    var kitchenGenerated = 0, kitchenItemsSent = 0, kitchenCompleted = 0, voidedKitchen = 0;
    final kitchenQty = <String, int>{};
    for (final order in orders) {
      if (order.status != 'cancelled') {
        kitchenGenerated += order.kitchenTicketCount;
      }
      final items = await db.orderDao.itemsForOrder(order.id);
      for (final it in items) {
        if (it.isVoided) continue;
        if (it.sentToKitchenAt != null) {
          kitchenItemsSent += it.quantity;
          kitchenQty[it.menuItemName] = (kitchenQty[it.menuItemName] ?? 0) + it.quantity;
        }
      }
      if (order.kitchenTicketCount > 0) {
        if (order.status == 'paid') kitchenCompleted++;
        if (order.status == 'cancelled') voidedKitchen += order.kitchenTicketCount;
      }
    }

    final names = <String>{...soldQty.keys, ...kitchenQty.keys};
    final itemStats = names.map((n) => ReportItemStat(
      n,
      soldOrders[n]?.length ?? 0,
      soldQty[n] ?? 0,
      kitchenQty[n] ?? 0,
      soldAmount[n] ?? 0,
    )).toList()..sort((a, b) => b.qty.compareTo(a.qty));

    // Sum service charges from invoices in this shift
    var totalSvc = 0.0;
    double invCashTotal = 0, invCardTotal = 0, invWalletTotal = 0, invCreditTotal = 0;
    for (final inv in invoices) {
      totalSvc += inv.serviceChargeValue;
      // Determine cash portion: prefer splits if present, else single method
      final splits = inv.paymentSplitsJson.isNotEmpty
          ? (jsonDecode(inv.paymentSplitsJson) as List)
          : <dynamic>[];
      if (splits.isEmpty) {
        final m = inv.paymentMethod;
        if (m == 'cash') invCashTotal += inv.grandTotal;
        else if (m == 'card') invCardTotal += inv.grandTotal;
        else if (m == 'wallet') invWalletTotal += inv.grandTotal;
        else if (m == 'credit') invCreditTotal += inv.grandTotal;
      } else {
        for (final s in splits) {
          final m = s['method'] as String? ?? 'cash';
          final amt = (s['amount'] as num? ?? 0).toDouble();
          if (m == 'cash') invCashTotal += amt;
          else if (m == 'card') invCardTotal += amt;
          else if (m == 'wallet') invWalletTotal += amt;
          else if (m == 'credit') invCreditTotal += amt;
        }
      }
    }

    return ReportData(
      completedOrders: orders.where((o) => o.status == 'paid').length,
      totalItemsSold: totalItems,
      voidedOrders: orders.where((o) => o.status == 'cancelled').length,
      cancelledOrderNumbers: orders.where((o) => o.status == 'cancelled').map((o) => o.orderNumber).toList(),
      cancelledItems: cancelledItems,
      kitchenGenerated: kitchenGenerated,
      kitchenCompleted: kitchenCompleted,
      voidedKitchen: voidedKitchen,
      kitchenItemsSent: kitchenItemsSent,
      totalServiceCharge: totalSvc,
      invoiceCashTotal: invCashTotal,
      invoiceCardTotal: invCardTotal,
      invoiceWalletTotal: invWalletTotal,
      invoiceCreditTotal: invCreditTotal,
      itemSales: itemStats,
      kitchenItems: itemStats.where((s) => s.kitchenQty > 0).toList(),
    );
  }

  // ── Kitchen Ticket ────────────────────────────────
  Future<void> printKitchenTicket(OrderEntity order, {int? ticketNumber}) async {
    final items = order.items.where((i) => !i.isVoided && i.status == OrderItemStatus.pending).toList();
    if (items.isEmpty) return;

    await _emit('Kitchen-${order.orderNumber}',
        (format) => _buildKitchenPDF(format, order, items, ticketNumber: ticketNumber));
  }

  Future<void> printKitchenTicketAll(OrderEntity order, {int? ticketNumber}) async {
    final items = order.items.where((i) => !i.isVoided).toList();
    if (items.isEmpty) return;

    await _emit('Kitchen-${order.orderNumber}-all',
        (format) => _buildKitchenPDF(format, order, items, ticketNumber: ticketNumber));
  }

  Future<void> printKitchenTicketItem(OrderEntity order, OrderItemEntity item, {int? ticketNumber}) async {
    if (item.isVoided) return;

    await _emit('Kitchen-${order.orderNumber}-item-${item.id}',
        (format) => _buildKitchenPDF(format, order, [item], ticketNumber: ticketNumber));
  }

  // ── Proforma Bill (before payment) ────────────────
  Future<void> printProformaBill(OrderEntity order) async {
    await _emit('Bill-${order.orderNumber}',
        (format) => _buildBillPDF(format, order, isProforma: true));
  }

  // ── Final Receipt (after payment) ─────────────────
  Future<void> printFinalReceipt(InvoiceEntity invoice) async {
    await _emit('Receipt-${invoice.invoiceNumber}',
        (format) => _buildReceiptPDF(format, invoice));
  }

  // ── A4 Tax Invoice ────────────────────────────────
  Future<void> printA4Invoice(InvoiceEntity invoice) async {
    await Printing.layoutPdf(
      onLayout: (fmt) => _buildA4PDF(invoice, format: fmt),
      name: 'Invoice-${invoice.invoiceNumber}',
    );
  }

  // ── Z Report (end of day) ─────────────────────────
  Future<void> printZReport(CashRegisterEntity reg, double closingCash) async {
    final data = await collectShiftDataForShift(reg.id);
    await _emit('Z-Report', (format) => _buildZReportPDF(format, reg, closingCash, data));
  }

  /// Gathers shift stats (item sales + kitchen counts) so the UI can show
  /// per-item kitchen quantities before printing the Z report.
  Future<ReportData> collectShiftData(DateTime since) => _collectShiftData(since);

  /// Shift-accurate stats for a given shift id (used by X/Z reports).
  Future<ReportData> collectShiftDataForShift(int shiftId) => _collectShiftDataForShift(shiftId);

  // ── X Report (mid-shift) ──────────────────────────
  Future<void> printXReport(CashRegisterEntity reg) async {
    final data = await collectShiftDataForShift(reg.id);
    await _emit('X-Report', (format) => _buildXReportPDF(format, reg, data));
  }

  // ── Internal: Kitchen PDF ─────────────────────────
  Future<Uint8List> _buildKitchenPDF(PdfPageFormat format, OrderEntity order, List<OrderItemEntity> items, {int? ticketNumber}) async {
    final t = _layout(format: format);
    final pdf = pw.Document();
    pdf.addPage(pw.Page(
      pageFormat: t.pageFormat,
      build: (ctx) => pw.Column(
        crossAxisAlignment: pw.CrossAxisAlignment.start,
        children: [
          t.center('KITCHEN TICKET', font: thermalBold, size: 14),
          t.center(_settings.name, font: thermalRegular, size: 8),
          pw.SizedBox(height: 4),
          t.dashedLine(),
          pw.SizedBox(height: 4),
          t.row('Order', '#${order.orderNumber}', size: 10, font: thermalBold),
          t.row('Table', order.tableName, size: 10, font: thermalBold),
          t.row('Waiter', order.waiterName, size: 9, font: thermalRegular),
          t.row('Date/Time', _df.format(DateTime.now()), size: 9, font: thermalBold),
          pw.SizedBox(height: 4),
          t.dashedLine(),
          pw.SizedBox(height: 5),
          ...items.map((item) => pw.Padding(
            padding: const pw.EdgeInsets.only(bottom: 6),
            child: pw.Column(crossAxisAlignment: pw.CrossAxisAlignment.start, children: [
              t.item('${item.quantity}x ${item.menuItem.name}', '', size: 11, font: thermalBold),
              if (item.modifiers.isNotEmpty)
                t.sub('  + ${item.modifiers.map((m) => m.name).join(', ')}', size: 8.5, font: thermalRegular),
              if (item.isDeal && item.dealItems.isNotEmpty)
                t.sub('  - ${_dealSummary(item)}', size: 8, font: thermalRegular),
              if (item.notes.isNotEmpty)
                t.sub('  * ${item.notes}', size: 8.5, font: thermalRegular),
            ]),
          )),
          t.dashedLine(h: 1.4),
          pw.SizedBox(height: 4),
          if (order.notes.isNotEmpty)
            pw.Padding(
              padding: const pw.EdgeInsets.only(bottom: 4),
              child: pw.Text('ORDER NOTE: ${order.notes}',
                  style: pw.TextStyle(font: thermalBold, fontSize: 10)),
            ),
          t.center('Ticket #${ticketNumber ?? order.kitchenTicketCount + 1}  |  ${_tf.format(DateTime.now())}',
              font: thermalRegular, size: 8),
          pw.SizedBox(height: 10),
        ],
      ),
    ));
    return pdf.save();
  }

  // ── Internal: Bill PDF ────────────────────────────
  Future<Uint8List> _buildBillPDF(PdfPageFormat format, OrderEntity order, {required bool isProforma}) async {
    final t = _layout(format: format);
    final pdf = pw.Document();
    final logoImg = await _getLogoImage();
    pdf.addPage(pw.Page(
      pageFormat: t.pageFormat,
      build: (ctx) => pw.Column(
        crossAxisAlignment: pw.CrossAxisAlignment.start,
        children: [
          t.header(logo: logoImg, name: _settings.name),
          if (_settings.address.isNotEmpty)
            t.center(_settings.address, font: thermalRegular, size: 8),
          if (_settings.phone.isNotEmpty)
            t.center(_settings.phone, font: thermalRegular, size: 8),
          pw.SizedBox(height: 4),
          t.dashedLine(),
          pw.SizedBox(height: 3),
          t.center(isProforma ? '*** BILL (NOT PAID) ***' : '*** RECEIPT ***', font: thermalBold, size: 11),
          pw.SizedBox(height: 3),
          t.dashedLine(),
          pw.SizedBox(height: 3),
          t.row('Date', _df.format(DateTime.now()), size: 8.5, font: thermalRegular),
          t.row(order.isDelivery ? 'Rider' : 'Table', order.tableName, size: 8.5, font: thermalBold),
          t.row('Order #', order.orderNumber, size: 8.5, font: thermalRegular),
          t.row('Waiter', order.waiterName, size: 8.5, font: thermalBold),
          pw.SizedBox(height: 3),
          t.dashedLine(),
          pw.SizedBox(height: 3),
          t.row('ITEM', 'AMOUNT', size: 8.5, font: thermalBold),
          pw.SizedBox(height: 2),
          t.dashedLine(h: 0.6),
          pw.SizedBox(height: 3),
          ...order.activeItems.map((item) => pw.Padding(
            padding: const pw.EdgeInsets.only(bottom: 3),
            child: pw.Column(crossAxisAlignment: pw.CrossAxisAlignment.start, children: [
              t.item('${item.menuItem.name} x${item.quantity}',
                  '${_settings.currencySymbol} ${item.lineTotal.toStringAsFixed(0)}',
                  size: 9, font: thermalBold),
              if (item.isDeal && item.dealItems.isNotEmpty)
                t.sub('  ${_dealSummary(item)}', size: 7, font: thermalRegular),
              if (item.notes.isNotEmpty)
                t.sub('  * ${item.notes}', size: 7, font: thermalRegular),
            ]),
          )),
          pw.SizedBox(height: 3),
          t.dashedLine(),
          pw.SizedBox(height: 3),
          t.row('SUBTOTAL', '${_settings.currencySymbol} ${order.subtotal.toStringAsFixed(0)}', size: 9, font: thermalBold),
          if (order.discountValue > 0)
            t.row('DISCOUNT', '-${_settings.currencySymbol} ${order.discountValue.toStringAsFixed(0)}', size: 9, font: thermalRegular),
          if (order.taxValue > 0)
            t.row('TAX (${order.taxPercent.toStringAsFixed(0)}%)', '${_settings.currencySymbol} ${order.taxValue.toStringAsFixed(0)}', size: 9, font: thermalRegular),
          if (order.serviceChargeFixed > 0)
            t.row('SERVICE CHARGE', '${_settings.currencySymbol} ${order.serviceChargeFixed.toStringAsFixed(0)}', size: 9, font: thermalRegular),
          if (order.serviceChargePercentValue > 0)
            t.row('SERVICE (${order.serviceChargePercent.toStringAsFixed(0)}%)', '${_settings.currencySymbol} ${order.serviceChargePercentValue.toStringAsFixed(0)}', size: 9, font: thermalRegular),
          if (order.deliveryCharges > 0)
            t.row('DELIVERY CHARGES', '${_settings.currencySymbol} ${order.deliveryCharges.toStringAsFixed(0)}', size: 9, font: thermalRegular),
          pw.SizedBox(height: 3),
          t.dashedLine(h: 1.4),
          pw.SizedBox(height: 3),
          t.row('TOTAL', '${_settings.currencySymbol} ${order.grandTotal.toStringAsFixed(0)}', size: 15, font: thermalBold),
          pw.SizedBox(height: 4),
          t.dashedLine(),
          pw.SizedBox(height: 6),
          t.center(isProforma ? 'Please wait for payment...' : _settings.footerMessage,
              font: thermalRegular, size: 8),
          pw.SizedBox(height: 2),
          t.center('Thank you! Visit again.', font: thermalBold, size: 8),
          pw.SizedBox(height: 4),
          t.credit(thermalRegular, 7),
          pw.SizedBox(height: 10),
        ],
      ),
    ));
    return pdf.save();
  }

  // ── Internal: Receipt PDF ─────────────────────────
  Future<Uint8List> _buildReceiptPDF(PdfPageFormat format, InvoiceEntity inv) async {
    final t = _layout(format: format);
    final pdf = pw.Document();
    final logoImg = await _getLogoImage();
    final stampImg = await _getPaidStampImage();
    pdf.addPage(pw.Page(
      pageFormat: t.pageFormat,
      build: (ctx) => pw.Column(
        crossAxisAlignment: pw.CrossAxisAlignment.start,
        children: [
          // Logo — top center, compact, original proportions preserved
          t.header(logo: logoImg, name: _settings.name),
          if (_settings.address.isNotEmpty)
            t.center(_settings.address, font: thermalRegular, size: 8),
          if (_settings.phone.isNotEmpty)
            t.center(_settings.phone, font: thermalRegular, size: 8),
          pw.SizedBox(height: 4),
          t.dashedLine(),
          pw.SizedBox(height: 3),
          t.center('*** RECEIPT ***', font: thermalBold, size: 11),
          pw.SizedBox(height: 3),
          t.dashedLine(),
          pw.SizedBox(height: 3),
          t.row('Invoice', inv.invoiceNumber, size: 8.5, font: thermalRegular),
          t.row('Date', _df.format(inv.createdAt), size: 8.5, font: thermalRegular),
          t.row(inv.orderType == 'delivery' ? 'Rider' : 'Table', inv.tableName, size: 8.5, font: thermalBold),
          t.row('Order #', inv.orderNumber, size: 8.5, font: thermalRegular),
          t.row('Waiter', inv.waiterName, size: 8.5, font: thermalBold),
          pw.SizedBox(height: 3),
          t.dashedLine(),
          pw.SizedBox(height: 3),
          // Column headers
          t.row('ITEM', 'AMOUNT', size: 8.5, font: thermalBold),
          pw.SizedBox(height: 2),
          t.dashedLine(h: 0.6),
          pw.SizedBox(height: 3),
          // Items
          ...inv.items.map((item) => pw.Padding(
            padding: const pw.EdgeInsets.only(bottom: 3),
            child: pw.Column(crossAxisAlignment: pw.CrossAxisAlignment.start, children: [
              t.item('${item.quantity}x ${item.menuItem.name}',
                  '${_settings.currencySymbol} ${item.lineTotal.toStringAsFixed(0)}',
                  size: 9, font: thermalBold),
              if (item.isDeal && item.dealItems.isNotEmpty)
                t.sub('  ${_dealSummary(item)}', size: 7, font: thermalRegular),
              if (item.notes.isNotEmpty)
                t.sub('  * ${item.notes}', size: 7, font: thermalRegular),
            ]),
          )),
          pw.SizedBox(height: 3),
          t.dashedLine(),
          pw.SizedBox(height: 3),
          t.row('SUBTOTAL', '${_settings.currencySymbol} ${inv.subtotal.toStringAsFixed(0)}', size: 9, font: thermalBold),
          if (inv.discountValue > 0)
            t.row('DISCOUNT', '-${_settings.currencySymbol} ${inv.discountValue.toStringAsFixed(0)}', size: 9, font: thermalRegular),
          if (inv.taxValue > 0)
            t.row('TAX (${_settings.taxPercent.toStringAsFixed(0)}%)', '${_settings.currencySymbol} ${inv.taxValue.toStringAsFixed(0)}', size: 9, font: thermalRegular),
          if (inv.serviceChargeValue > 0)
            t.row('SERVICE CHARGE', '${_settings.currencySymbol} ${inv.serviceChargeValue.toStringAsFixed(0)}', size: 9, font: thermalRegular),
          if (inv.deliveryCharges > 0)
            t.row('DELIVERY CHARGES', '${_settings.currencySymbol} ${inv.deliveryCharges.toStringAsFixed(0)}', size: 9, font: thermalRegular),
          pw.SizedBox(height: 3),
          t.dashedLine(h: 1.4),
          pw.SizedBox(height: 3),
          // Grand total — large and bold
          t.row('TOTAL', '${_settings.currencySymbol} ${inv.grandTotal.toStringAsFixed(0)}', size: 15, font: thermalBold),
          pw.SizedBox(height: 3),
          t.dashedLine(),
          pw.SizedBox(height: 3),
          // Payment section
          t.center('PAYMENT METHOD: ${_methodLabel(inv.paymentMethod).toUpperCase()}', font: thermalBold, size: 8.5),
          pw.SizedBox(height: 2),
          t.row('PAID AMOUNT', '${_settings.currencySymbol} ${inv.amountPaid.toStringAsFixed(0)}', size: 9, font: thermalBold),
          if (inv.changeAmount > 0)
            t.row('CHANGE', '${_settings.currencySymbol} ${inv.changeAmount.toStringAsFixed(0)}', size: 9, font: thermalRegular),
          pw.SizedBox(height: 4),
          // PAID stamp — centered in the payment section, inline (no overlap)
          if (stampImg != null)
            pw.Center(
              child: pw.Transform.rotate(
                angle: -0.15,
                child: pw.Image(stampImg, width: t.contentWidth * 0.5, height: t.contentWidth * 0.16, fit: pw.BoxFit.contain),
              ),
            ),
          pw.SizedBox(height: 4),
          t.dashedLine(),
          pw.SizedBox(height: 5),
          t.center('Thank You For Dining With Us!', font: thermalRegular, size: 8),
          if (_settings.footerMessage.isNotEmpty)
            t.center(_settings.footerMessage, font: thermalRegular, size: 8),
          pw.SizedBox(height: 2),
          t.center('Thank You! Visit Again', font: thermalBold, size: 8),
          pw.SizedBox(height: 4),
          t.credit(thermalRegular, 7),
          pw.SizedBox(height: 10),
        ],
      ),
    ));
    return pdf.save();
  }

  // ── Internal: A4 Invoice PDF ──────────────────────
  Future<Uint8List> _buildA4PDF(InvoiceEntity inv, {required PdfPageFormat format}) async {
    final pdf = pw.Document();
    final font = bold;
    final fontReg = regular;

    final logoImg = await _getLogoImage();
    pdf.addPage(pw.Page(
      pageFormat: PdfPageFormat.a4,
      margin: const pw.EdgeInsets.all(30),
      build: (ctx) => pw.Column(
        crossAxisAlignment: pw.CrossAxisAlignment.start,
        children: [
          // Header
          pw.Row(mainAxisAlignment: pw.MainAxisAlignment.spaceBetween, children: [
            pw.Row(crossAxisAlignment: pw.CrossAxisAlignment.center, children: [
              if (logoImg != null)
                pw.Padding(
                  padding: const pw.EdgeInsets.only(right: 12),
                  child: pw.Image(logoImg.image, width: 85, height: 85, fit: pw.BoxFit.contain),
                ),
              pw.Column(crossAxisAlignment: pw.CrossAxisAlignment.start, children: [
                pw.Text(_settings.name, style: pw.TextStyle(font: font, fontSize: 24, color: PdfColors.blue900)),
                pw.Text(_settings.address, style: pw.TextStyle(font: fontReg, fontSize: 10)),
                pw.Text('Tel: ${_settings.phone}', style: pw.TextStyle(font: fontReg, fontSize: 10)),
                if (_settings.taxNumber.isNotEmpty)
                  pw.Text('NTN: ${_settings.taxNumber}', style: pw.TextStyle(font: fontReg, fontSize: 10)),
              ]),
            ]),
            pw.Column(crossAxisAlignment: pw.CrossAxisAlignment.end, children: [
              pw.Container(
                padding: const pw.EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                decoration: pw.BoxDecoration(
                  color: PdfColors.green100,
                  border: pw.Border.all(color: PdfColors.green700),
                  borderRadius: const pw.BorderRadius.all(pw.Radius.circular(6)),
                ),
                child: pw.Text('TAX INVOICE', style: pw.TextStyle(font: font, fontSize: 14, color: PdfColors.green800)),
              ),
              pw.SizedBox(height: 6),
              pw.Text('Invoice: ${inv.invoiceNumber}', style: pw.TextStyle(font: font, fontSize: 11)),
              pw.Text('Date: ${_df.format(inv.createdAt)}', style: pw.TextStyle(font: fontReg, fontSize: 10)),
              pw.Text('${inv.orderType == 'delivery' ? 'Rider' : 'Table'}: ${inv.tableName}', style: pw.TextStyle(font: fontReg, fontSize: 10)),
              pw.Text('Waiter: ${inv.waiterName}', style: pw.TextStyle(font: fontReg, fontSize: 10)),
            ]),
          ]),
          pw.SizedBox(height: 20),
          pw.Divider(),
          pw.SizedBox(height: 10),
          // Items table
          pw.Table(
            border: pw.TableBorder(horizontalInside: const pw.BorderSide(color: PdfColors.grey300, width: 0.5)),
            columnWidths: {0: const pw.FlexColumnWidth(4), 1: const pw.FixedColumnWidth(50), 2: const pw.FixedColumnWidth(80), 3: const pw.FixedColumnWidth(90)},
            children: [
              pw.TableRow(
                decoration: const pw.BoxDecoration(color: PdfColors.blue900),
                children: ['Item', 'Qty', 'Unit Price', 'Total'].map((h) =>
                  pw.Padding(padding: const pw.EdgeInsets.all(8),
                    child: pw.Text(h, style: pw.TextStyle(font: font, color: PdfColors.white, fontSize: 10)))).toList(),
              ),
              ...inv.items.asMap().entries.map((e) => pw.TableRow(
                decoration: pw.BoxDecoration(color: e.key.isOdd ? PdfColors.grey50 : PdfColors.white),
                children: [
                  pw.Padding(padding: const pw.EdgeInsets.all(8), child: pw.Column(
                    crossAxisAlignment: pw.CrossAxisAlignment.start,
                    children: [
                      pw.Text(e.value.menuItem.name, style: pw.TextStyle(font: font, fontSize: 10)),
                      if (e.value.isDeal && e.value.dealItems.isNotEmpty)
                        pw.Text(_dealSummary(e.value), style: pw.TextStyle(font: fontReg, fontSize: 8, color: PdfColors.grey600)),
                      if (e.value.notes.isNotEmpty)
                        pw.Text('Note: ${e.value.notes}', style: pw.TextStyle(font: fontReg, fontSize: 8, color: PdfColors.grey600)),
                    ],
                  )),
                  pw.Padding(padding: const pw.EdgeInsets.all(8), child: pw.Text('${e.value.quantity}', style: pw.TextStyle(font: fontReg, fontSize: 10))),
                  pw.Padding(padding: const pw.EdgeInsets.all(8), child: pw.Text('${_settings.currencySymbol} ${e.value.unitPrice.toStringAsFixed(0)}', style: pw.TextStyle(font: fontReg, fontSize: 10))),
                  pw.Padding(padding: const pw.EdgeInsets.all(8), child: pw.Text('${_settings.currencySymbol} ${e.value.lineTotal.toStringAsFixed(0)}', style: pw.TextStyle(font: font, fontSize: 10), textAlign: pw.TextAlign.right)),
                ],
              )),
            ],
          ),
          pw.SizedBox(height: 16),
          // Totals
          pw.Row(mainAxisAlignment: pw.MainAxisAlignment.end, children: [
            pw.SizedBox(width: 240, child: pw.Column(children: [
              _a4TotalRow('Subtotal', inv.subtotal, font, fontReg),
              if (inv.discountValue > 0) _a4TotalRow('Discount', -inv.discountValue, font, fontReg),
              if (inv.taxValue > 0) _a4TotalRow('GST (${_settings.taxPercent.toStringAsFixed(0)}%)', inv.taxValue, font, fontReg),
              if (inv.serviceChargeValue > 0) _a4TotalRow('Service Charge', inv.serviceChargeValue, font, fontReg),
              if (inv.deliveryCharges > 0) _a4TotalRow('Delivery Charges', inv.deliveryCharges, font, fontReg),
              pw.Divider(thickness: 1),
              pw.Row(mainAxisAlignment: pw.MainAxisAlignment.spaceBetween, children: [
                pw.Text('GRAND TOTAL', style: pw.TextStyle(font: font, fontSize: 13)),
                pw.Text('${_settings.currencySymbol} ${inv.grandTotal.toStringAsFixed(0)}',
                    style: pw.TextStyle(font: font, fontSize: 14, color: PdfColors.blue800)),
              ]),
              pw.Divider(thickness: 0.5),
              _a4TotalRow('Paid (${_methodLabel(inv.paymentMethod)})', inv.amountPaid, font, fontReg),
              if (inv.changeAmount > 0) _a4TotalRow('Change', inv.changeAmount, font, fontReg),
            ])),
          ]),
          pw.Spacer(),
          pw.Divider(),
          pw.Center(child: pw.Text(_settings.footerMessage, style: pw.TextStyle(font: fontReg, fontSize: 10, color: PdfColors.grey700))),
          pw.Center(child: pw.Text('Software By Engr. Hamza Asad', style: pw.TextStyle(font: fontReg, fontSize: 9, color: PdfColors.black))),
        ],
      ),
    ));
    return pdf.save();
  }

  // ── Z Report PDF ──────────────────────────────────
  Future<Uint8List> _buildZReportPDF(PdfPageFormat format, CashRegisterEntity reg, double closingCash, ReportData data) async {
    final t = _layout(format: format);
    final pdf = pw.Document();
    final diff = closingCash - reg.expectedCash;
    final logoImg = await _getLogoImage();
    final sym = _settings.currencySymbol;

    pdf.addPage(pw.Page(
      pageFormat: t.pageFormat,
      build: (ctx) => pw.Column(crossAxisAlignment: pw.CrossAxisAlignment.start, children: [
        t.header(logo: null, name: _settings.name, title: 'Z REPORT', subtitle: '*** SHIFT CLOSED ***'),
        pw.SizedBox(height: 4),
        t.dashedLine(h: 1.2),
        t.row('Shift', reg.shiftNumber, size: 9, font: thermalBold),
        t.row('Business date', _dtf.format(reg.businessDate ?? reg.openedAt), size: 9, font: thermalRegular),
        t.row('Opened', _df.format(reg.openedAt), size: 9, font: thermalRegular),
        t.row('Closed', _df.format(DateTime.now()), size: 9, font: thermalRegular),
        t.row('Duration', _formatDuration(DateTime.now().difference(reg.openedAt)), size: 9, font: thermalRegular),
        t.dashedLine(),
        t.section('SALES SUMMARY', font: thermalBold),
        t.row('Total orders', '${data.completedOrders}', size: 9, font: thermalRegular),
        t.row('Gross sales', '$sym ${reg.totalSales.toStringAsFixed(0)}', size: 9, font: thermalBold),
        t.row('Discounts', '-$sym ${reg.totalDiscounts.toStringAsFixed(0)}', size: 9, font: thermalRegular),
        t.row('Tax collected', '$sym ${reg.totalTax.toStringAsFixed(0)}', size: 9, font: thermalRegular),
        if (data.totalServiceCharge > 0)
          t.row('Service charge', '$sym ${data.totalServiceCharge.toStringAsFixed(0)}', size: 9, font: thermalRegular),
        t.dashedLine(),
        t.section('PAYMENT BREAKDOWN', font: thermalBold),
        t.row('Cash', '$sym ${reg.totalCashSales.toStringAsFixed(0)}', size: 9, font: thermalRegular),
        t.row('Card', '$sym ${reg.totalCardSales.toStringAsFixed(0)}', size: 9, font: thermalRegular),
        t.row('Wallet', '$sym ${reg.totalWalletSales.toStringAsFixed(0)}', size: 9, font: thermalRegular),
        t.row('Credit', '$sym ${reg.totalCreditSales.toStringAsFixed(0)}', size: 9, font: thermalRegular),
        t.dashedLine(),
        t.section('CASH RECONCILIATION', font: thermalBold),
        t.row('Opening cash', '$sym ${reg.openingCash.toStringAsFixed(0)}', size: 9, font: thermalRegular),
        t.row('Cash sales', '$sym ${reg.totalCashSales.toStringAsFixed(0)}', size: 9, font: thermalRegular),
        t.row('Cash in', '+$sym ${reg.cashIn.toStringAsFixed(0)}', size: 9, font: thermalRegular),
        t.row('Cash out', '-$sym ${reg.cashOut.toStringAsFixed(0)}', size: 9, font: thermalRegular),
        t.row('Expenses', '-$sym ${reg.totalExpenses.toStringAsFixed(0)}', size: 9, font: thermalRegular),
        t.dashedLine(h: 1.2),
        t.row('Expected cash', '$sym ${reg.expectedCash.toStringAsFixed(0)}', size: 9, font: thermalBold),
        t.row('Actual cash', '$sym ${closingCash.toStringAsFixed(0)}', size: 9, font: thermalBold),
        t.row('DIFFERENCE', '${diff >= 0 ? '+' : ''}$sym ${diff.toStringAsFixed(0)}', size: 11, font: thermalBold),
        t.dashedLine(),
        t.section('AUDIT (from invoices)', font: thermalBold),
        t.row('Invoice cash', '$sym ${data.invoiceCashTotal.toStringAsFixed(0)}', size: 9, font: thermalRegular),
        t.row('Invoice card', '$sym ${data.invoiceCardTotal.toStringAsFixed(0)}', size: 9, font: thermalRegular),
        t.row('Invoice wallet', '$sym ${data.invoiceWalletTotal.toStringAsFixed(0)}', size: 9, font: thermalRegular),
        t.row('Invoice credit', '$sym ${data.invoiceCreditTotal.toStringAsFixed(0)}', size: 9, font: thermalRegular),
        t.row('Counted cash', '$sym ${reg.totalCashSales.toStringAsFixed(0)}', size: 9, font: thermalRegular),
        t.row('CASH MISMATCH',
          '$sym ${(reg.totalCashSales - data.invoiceCashTotal).toStringAsFixed(0)}',
          size: 11, font: thermalBold),
        t.dashedLine(),
        t.section('KITCHEN', font: thermalBold),
        t.row('Tickets printed', '${data.kitchenGenerated}', size: 9, font: thermalRegular),
        t.row('Void transactions', '${data.cancelledOrderNumbers.length}', size: 9, font: thermalRegular),
        if (data.cancelledItems.isNotEmpty) ...[
          pw.SizedBox(height: 4),
          t.section('CANCELLED ITEMS', font: thermalBold),
          ...data.cancelledItems.map((c) => pw.Padding(
            padding: const pw.EdgeInsets.only(bottom: 2),
            child: pw.Column(crossAxisAlignment: pw.CrossAxisAlignment.start, children: [
              t.row('  ${c.quantity}x ${c.itemName}', '', size: 9, font: thermalRegular),
              t.sub('    Order #${c.orderNumber}  Ticket #${c.ticketNumber}', size: 8, font: thermalRegular),
            ]),
          )),
        ],
        if (data.cancelledOrderNumbers.isNotEmpty && data.cancelledItems.isEmpty) ...[
          pw.SizedBox(height: 4),
          t.section('CANCELLED ORDERS', font: thermalBold),
          ...data.cancelledOrderNumbers.map((n) => t.row('  #$n', '', size: 9, font: thermalRegular)),
        ],
        pw.SizedBox(height: 4),
        t.dashedLine(h: 1.2),
        pw.SizedBox(height: 4),
        t.center('*** END OF DAY — COUNTERS RESET ***', font: thermalBold, size: 9),
        t.center(_df.format(DateTime.now()), font: thermalRegular, size: 8),
        t.credit(thermalRegular, 7),
      ]),
    ));
    return pdf.save();
  }

  // ── X Report PDF (mid-shift) ─────────────────────
  Future<Uint8List> _buildXReportPDF(PdfPageFormat format, CashRegisterEntity reg, ReportData data) async {
    final t = _layout(format: format);
    final pdf = pw.Document();
    final logoImg = await _getLogoImage();
    final sym = _settings.currencySymbol;

    pdf.addPage(pw.Page(
      pageFormat: t.pageFormat,
      build: (ctx) => pw.Column(crossAxisAlignment: pw.CrossAxisAlignment.start, children: [
        t.header(logo: null, name: _settings.name, title: 'X REPORT', subtitle: '*** SHIFT SUMMARY ***'),
        pw.SizedBox(height: 2),
        t.dashedLine(h: 1.2),
        t.row('Shift', reg.shiftNumber, size: 9, font: thermalBold),
        t.row('Business date', _dtf.format(reg.businessDate ?? reg.openedAt), size: 9, font: thermalRegular),
        t.row('Date', _dtf.format(DateTime.now()), size: 9, font: thermalRegular),
        t.row('Time', _df.format(DateTime.now()), size: 9, font: thermalRegular),
        t.dashedLine(),
        t.section('ITEMS', font: thermalBold),
        if (data.itemSales.isEmpty)
          t.sub('  No items sold yet', size: 9, font: thermalRegular),
        if (data.itemSales.isNotEmpty)
          ...data.itemSales.map((s) => pw.Padding(
            padding: const pw.EdgeInsets.only(bottom: 2),
            child: pw.Column(crossAxisAlignment: pw.CrossAxisAlignment.start, children: [
              t.item('${s.qty}x ${s.name}', '', size: 9, font: thermalBold),
              t.sub('  $sym ${s.amount.toStringAsFixed(0)}', size: 8, font: thermalRegular),
            ]),
          )),
        t.dashedLine(h: 1.2),
        pw.SizedBox(height: 2),
        t.section('KITCHEN', font: thermalBold),
        t.row('Tickets printed', '${data.kitchenGenerated}', size: 9, font: thermalRegular),
        t.row('Void tickets', '${data.voidedKitchen}', size: 9, font: thermalRegular),
        if (data.cancelledItems.isNotEmpty) ...[
          pw.SizedBox(height: 2),
          t.section('CANCELLED ITEMS', font: thermalBold),
          ...data.cancelledItems.map((c) => pw.Padding(
            padding: const pw.EdgeInsets.only(bottom: 1),
            child: pw.Column(crossAxisAlignment: pw.CrossAxisAlignment.start, children: [
              t.row('  ${c.quantity}x ${c.itemName}', '', size: 8, font: thermalRegular),
              t.sub('    Order #${c.orderNumber}  Ticket #${c.ticketNumber}', size: 7, font: thermalRegular),
            ]),
          )),
        ],
        t.dashedLine(h: 1.2),
        pw.SizedBox(height: 2),
        t.center('*** X REPORT — CONTINUES ***', font: thermalBold, size: 9),
        t.center(_df.format(DateTime.now()), font: thermalRegular, size: 8),
        t.credit(thermalRegular, 7),
      ]),
    ));
    return pdf.save();
  }

  Future<ThermalLogo?> _getLogoImage() async {
    if (_settings.logoPath != null && _settings.logoPath!.isNotEmpty) {
      final resolvedPath = AppPaths.resolve(_settings.logoPath!);
      final file = File(resolvedPath);
      if (file.existsSync()) {
        try {
          final bytes = file.readAsBytesSync();
          return ThermalLogo(pw.MemoryImage(bytes));
        } catch (_) {}
      }
    }
    return null;
  }

  // Bundled "PAID" stamp, loaded from assets/images/paid_stamp.png.
  Future<pw.MemoryImage?> _getPaidStampImage() async {
    try {
      final data = await rootBundle.load('assets/images/paid_stamp.png');
      return pw.MemoryImage(data.buffer.asUint8List());
    } catch (_) {
      return null;
    }
  }

  // ── Helpers ───────────────────────────────────────
  pw.Widget _a4TotalRow(String label, double val, pw.Font b, pw.Font r) => pw.Padding(
    padding: const pw.EdgeInsets.symmetric(vertical: 2),
    child: pw.Row(mainAxisAlignment: pw.MainAxisAlignment.spaceBetween, children: [
      pw.Text(label, style: pw.TextStyle(font: r, fontSize: 10)),
      pw.Text('${_settings.currencySymbol} ${val.abs().toStringAsFixed(0)}',
          style: pw.TextStyle(font: b, fontSize: 10, color: val < 0 ? PdfColors.green700 : null)),
    ]),
  );

  String _methodLabel(PaymentMethod m) => switch (m) {
    PaymentMethod.cash   => 'Cash',
    PaymentMethod.card   => 'Card',
    PaymentMethod.bank   => 'Bank Transfer',
    PaymentMethod.wallet => 'Wallet',
    PaymentMethod.credit => 'Credit',
    PaymentMethod.split  => 'Split',
  };

  String _formatDuration(Duration d) {
    final h = d.inHours;
    final m = d.inMinutes % 60;
    return '${h}h ${m}m';
  }
}

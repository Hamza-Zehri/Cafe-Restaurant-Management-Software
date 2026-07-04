// ═══════════════════════════════════════════════════════
// PRINT SERVICE — Kitchen tickets, bills, invoices
// ═══════════════════════════════════════════════════════

import 'dart:io';
import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:printing/printing.dart';
import 'package:intl/intl.dart';

import '../domain/entities.dart';

class PrintService {
  static final PrintService instance = PrintService._();
  PrintService._();

  RestaurantSettings _settings = const RestaurantSettings();
  void configure(RestaurantSettings s) => _settings = s;

  final _df = DateFormat('dd/MM/yyyy HH:mm');
  final _tf = DateFormat('HH:mm');
  final _dtf = DateFormat('dd MMM yyyy');

  String _dealSummary(OrderItemEntity item) =>
      item.dealItems.map((d) => '${d.quantity}x ${d.name}').join(', ');

  // ── Kitchen Ticket ────────────────────────────────
  Future<void> printKitchenTicket(OrderEntity order) async {
    final items = order.items.where((i) => !i.isVoided && i.status == OrderItemStatus.pending).toList();
    if (items.isEmpty) return;

    await Printing.layoutPdf(
      onLayout: (_) => _buildKitchenPDF(order, items),
      name: 'Kitchen-${order.orderNumber}',
    );
  }

  Future<Uint8List> _buildKitchenPDF(OrderEntity order, List<OrderItemEntity> items) async {
    final pdf = pw.Document();
    final font = await PdfGoogleFonts.nunitoBold();
    final fontReg = await PdfGoogleFonts.nunitoRegular();

    pdf.addPage(pw.Page(
      pageFormat: PdfPageFormat(_mmToPt(80), double.infinity, marginAll: _mmToPt(3)),
      build: (ctx) => pw.Column(
        crossAxisAlignment: pw.CrossAxisAlignment.start,
        children: [
          pw.Center(child: pw.Text('** KITCHEN TICKET **',
              style: pw.TextStyle(font: font, fontSize: 14))),
          pw.SizedBox(height: 4),
          pw.Row(mainAxisAlignment: pw.MainAxisAlignment.spaceBetween, children: [
            pw.Text('Order: #${order.orderNumber}', style: pw.TextStyle(font: font, fontSize: 12)),
            pw.Text('Table: ${order.tableName}', style: pw.TextStyle(font: font, fontSize: 12)),
          ]),
          pw.Text('Waiter: ${order.waiterName}  |  Guests: ${order.guestCount}',
              style: pw.TextStyle(font: fontReg, fontSize: 9)),
          pw.Text('Time: ${_tf.format(DateTime.now())}',
              style: pw.TextStyle(font: fontReg, fontSize: 9)),
          pw.Divider(thickness: 1),
          pw.SizedBox(height: 4),
          ...items.map((item) => pw.Padding(
            padding: const pw.EdgeInsets.only(bottom: 8),
            child: pw.Column(crossAxisAlignment: pw.CrossAxisAlignment.start, children: [
              pw.Row(children: [
                pw.Container(
                  width: 28, height: 28,
                  decoration: pw.BoxDecoration(
                    border: pw.Border.all(width: 1),
                    borderRadius: const pw.BorderRadius.all(pw.Radius.circular(4)),
                  ),
                  child: pw.Center(child: pw.Text('${item.quantity}',
                      style: pw.TextStyle(font: font, fontSize: 14))),
                ),
                pw.SizedBox(width: 8),
                pw.Expanded(child: pw.Text(item.menuItem.name,
                    style: pw.TextStyle(font: font, fontSize: 13))),
              ]),
              if (item.modifiers.isNotEmpty)
                pw.Padding(
                  padding: const pw.EdgeInsets.only(left: 36, top: 2),
                  child: pw.Text(item.modifiers.map((m) => '+ ${m.name}').join(', '),
                      style: pw.TextStyle(font: fontReg, fontSize: 9, color: PdfColors.blue700)),
                ),
              if (item.isDeal && item.dealItems.isNotEmpty)
                pw.Padding(
                  padding: const pw.EdgeInsets.only(left: 36, top: 2),
                  child: pw.Text(_dealSummary(item),
                      style: pw.TextStyle(font: fontReg, fontSize: 8, color: PdfColors.grey700)),
                ),
              if (item.notes.isNotEmpty)
                pw.Container(
                  margin: const pw.EdgeInsets.only(left: 36, top: 2),
                  padding: const pw.EdgeInsets.symmetric(horizontal: 6, vertical: 3),
                  decoration: const pw.BoxDecoration(
                    color: PdfColors.yellow50,
                    border: pw.Border(left: pw.BorderSide(color: PdfColors.orange, width: 3)),
                  ),
                  child: pw.Text('⚠ ${item.notes}',
                      style: pw.TextStyle(font: font, fontSize: 9, color: PdfColors.orange800)),
                ),
            ]),
          )),
          pw.Divider(thickness: 1),
          if (order.notes.isNotEmpty)
            pw.Container(
              padding: const pw.EdgeInsets.all(6),
              decoration: pw.BoxDecoration(border: pw.Border.all(color: PdfColors.red)),
              child: pw.Text('ORDER NOTE: ${order.notes}',
                  style: pw.TextStyle(font: font, fontSize: 10, color: PdfColors.red)),
            ),
          pw.SizedBox(height: 4),
          pw.Text('Ticket #${order.kitchenTicketCount + 1}  |  ${_tf.format(DateTime.now())}',
              style: pw.TextStyle(font: fontReg, fontSize: 8, color: PdfColors.grey600)),
        ],
      ),
    ));
    return pdf.save();
  }

  // ── Proforma Bill (before payment) ────────────────
  Future<void> printProformaBill(OrderEntity order) async {
    await Printing.layoutPdf(
      onLayout: (fmt) => _buildBillPDF(order, isProforma: true, format: fmt),
      name: 'Bill-${order.orderNumber}',
    );
  }

  // ── Final Receipt (after payment) ─────────────────
  Future<void> printFinalReceipt(InvoiceEntity invoice) async {
    await Printing.layoutPdf(
      onLayout: (fmt) => _buildReceiptPDF(invoice, format: fmt),
      name: 'Receipt-${invoice.invoiceNumber}',
    );
  }

  // ── A4 Tax Invoice ────────────────────────────────
  Future<void> printA4Invoice(InvoiceEntity invoice) async {
    await Printing.layoutPdf(
      onLayout: (fmt) => _buildA4PDF(invoice, format: fmt),
      name: 'Invoice-${invoice.invoiceNumber}',
    );
  }

  // ── X Report ─────────────────────────────────────
  Future<void> printXReport(CashRegisterEntity reg) async {
    await Printing.layoutPdf(
      onLayout: (fmt) => _buildXReportPDF(reg),
      name: 'X-Report',
    );
  }

  // ── Z Report ─────────────────────────────────────
  Future<void> printZReport(CashRegisterEntity reg, double closingCash) async {
    await Printing.layoutPdf(
      onLayout: (fmt) => _buildZReportPDF(reg, closingCash),
      name: 'Z-Report',
    );
  }

  // ── Internal: Bill PDF ────────────────────────────
  Future<Uint8List> _buildBillPDF(OrderEntity order, {required bool isProforma, required PdfPageFormat format}) async {
    final pdf = pw.Document();
    final font = await PdfGoogleFonts.nunitoBold();
    final fontReg = await PdfGoogleFonts.nunitoRegular();
    final is80mm = _settings.receiptWidth == 80;
    final width = _mmToPt(is80mm ? 80.0 : 58.0);

    final logoImg = await _getLogoImage();
    pdf.addPage(pw.Page(
      pageFormat: PdfPageFormat(width, double.infinity, marginAll: _mmToPt(3)),
      build: (ctx) => pw.Column(
        crossAxisAlignment: pw.CrossAxisAlignment.start,
        children: [
          // Header
          if (logoImg != null)
            pw.Center(
              child: pw.Padding(
                padding: const pw.EdgeInsets.only(bottom: 6),
                child: pw.Image(logoImg, width: 50, height: 50, fit: pw.BoxFit.contain),
              ),
            ),
          pw.Center(child: pw.Text(_settings.name,
              style: pw.TextStyle(font: font, fontSize: 14))),
          pw.Center(child: pw.Text(_settings.address,
              style: pw.TextStyle(font: fontReg, fontSize: 8))),
          pw.Center(child: pw.Text('Tel: ${_settings.phone}',
              style: pw.TextStyle(font: fontReg, fontSize: 8))),
          pw.SizedBox(height: 4),
          pw.Center(
            child: pw.Container(
              padding: const pw.EdgeInsets.symmetric(horizontal: 12, vertical: 3),
              decoration: pw.BoxDecoration(
                border: pw.Border.all(width: 1.5,
                    color: isProforma ? PdfColors.orange700 : PdfColors.green700),
              ),
              child: pw.Text(isProforma ? 'BILL (NOT PAID)' : 'RECEIPT',
                  style: pw.TextStyle(font: font, fontSize: 11,
                      color: isProforma ? PdfColors.orange700 : PdfColors.green700)),
            ),
          ),
          pw.SizedBox(height: 4),
          pw.Divider(thickness: 0.5),
          _billRow('Date', _df.format(DateTime.now()), font, fontReg),
          _billRow('Table', order.tableName, font, fontReg),
          _billRow('Order #', order.orderNumber, font, fontReg),
          _billRow('Waiter', order.waiterName, font, fontReg),
          pw.Divider(thickness: 0.5),
          // Items
          pw.Row(children: [
            pw.Expanded(child: pw.Text('Item', style: pw.TextStyle(font: font, fontSize: 9))),
            pw.Text('Qty', style: pw.TextStyle(font: font, fontSize: 9)),
            pw.SizedBox(width: 16),
            pw.SizedBox(width: 60, child: pw.Text('Amount', textAlign: pw.TextAlign.right,
                style: pw.TextStyle(font: font, fontSize: 9))),
          ]),
          pw.Divider(thickness: 0.5),
          ...order.activeItems.map((item) => pw.Padding(
            padding: const pw.EdgeInsets.symmetric(vertical: 2),
            child: pw.Column(crossAxisAlignment: pw.CrossAxisAlignment.start, children: [
              pw.Row(children: [
                pw.Expanded(child: pw.Text(item.menuItem.name,
                    style: pw.TextStyle(font: fontReg, fontSize: 9))),
                pw.Text('×${item.quantity}', style: pw.TextStyle(font: fontReg, fontSize: 9)),
                pw.SizedBox(width: 6),
                pw.SizedBox(width: 60, child: pw.Text(
                    '${_settings.currencySymbol} ${item.lineTotal.toStringAsFixed(0)}',
                    textAlign: pw.TextAlign.right,
                    style: pw.TextStyle(font: font, fontSize: 9))),
              ]),
              if (item.isDeal && item.dealItems.isNotEmpty)
                pw.Text('  ${_dealSummary(item)}',
                    style: pw.TextStyle(font: fontReg, fontSize: 7, color: PdfColors.grey600)),
              if (item.notes.isNotEmpty)
                pw.Text('  * ${item.notes}',
                    style: pw.TextStyle(font: fontReg, fontSize: 7, color: PdfColors.grey600)),
            ]),
          )),
          pw.Divider(thickness: 0.5),
          // Totals
          _totalRow('Subtotal', order.subtotal, font, fontReg),
          if (order.discountValue > 0)
            _totalRow('Discount', -order.discountValue, font, fontReg, isNeg: true),
          if (order.taxValue > 0)
            _totalRow('Tax (${order.taxPercent.toStringAsFixed(0)}%)', order.taxValue, font, fontReg),
          if (order.serviceChargeValue > 0)
            _totalRow('Service (${order.serviceChargePercent.toStringAsFixed(0)}%)', order.serviceChargeValue, font, fontReg),
          pw.Divider(thickness: 1),
          pw.Row(mainAxisAlignment: pw.MainAxisAlignment.spaceBetween, children: [
            pw.Text('TOTAL', style: pw.TextStyle(font: font, fontSize: 13)),
            pw.Text('${_settings.currencySymbol} ${order.grandTotal.toStringAsFixed(0)}',
                style: pw.TextStyle(font: font, fontSize: 13, color: PdfColors.blue800)),
          ]),
          pw.Divider(thickness: 0.5),
          pw.SizedBox(height: 4),
          pw.Center(child: pw.Text(isProforma ? 'Please wait for payment...' : _settings.footerMessage,
              style: pw.TextStyle(font: fontReg, fontSize: 8, color: PdfColors.grey600))),
        ],
      ),
    ));
    return pdf.save();
  }

  // ── Internal: Receipt PDF ─────────────────────────
  Future<Uint8List> _buildReceiptPDF(InvoiceEntity inv, {required PdfPageFormat format}) async {
    final pdf = pw.Document();
    final font = await PdfGoogleFonts.nunitoBold();
    final fontReg = await PdfGoogleFonts.nunitoRegular();
    final width = _mmToPt(_settings.receiptWidth.toDouble());

    final logoImg = await _getLogoImage();
    pdf.addPage(pw.Page(
      pageFormat: PdfPageFormat(width, double.infinity, marginAll: _mmToPt(3)),
      build: (ctx) => pw.Column(
        crossAxisAlignment: pw.CrossAxisAlignment.start,
        children: [
          if (logoImg != null)
            pw.Center(
              child: pw.Padding(
                padding: const pw.EdgeInsets.only(bottom: 6),
                child: pw.Image(logoImg, width: 50, height: 50, fit: pw.BoxFit.contain),
              ),
            ),
          pw.Center(child: pw.Text(_settings.name, style: pw.TextStyle(font: font, fontSize: 14))),
          pw.Center(child: pw.Text(_settings.address, style: pw.TextStyle(font: fontReg, fontSize: 8))),
          pw.Center(child: pw.Text('Tel: ${_settings.phone}', style: pw.TextStyle(font: fontReg, fontSize: 8))),
          pw.SizedBox(height: 4),
          pw.Center(child: pw.Container(
            padding: const pw.EdgeInsets.symmetric(horizontal: 10, vertical: 3),
            decoration: pw.BoxDecoration(color: PdfColors.green100, border: pw.Border.all(color: PdfColors.green700)),
            child: pw.Text('PAID', style: pw.TextStyle(font: font, fontSize: 12, color: PdfColors.green700)),
          )),
          pw.SizedBox(height: 4),
          pw.Divider(thickness: 0.5),
          _billRow('Invoice', inv.invoiceNumber, font, fontReg),
          _billRow('Date', _df.format(inv.createdAt), font, fontReg),
          _billRow('Table', inv.tableName, font, fontReg),
          _billRow('Order #', inv.orderNumber, font, fontReg),
          _billRow('Waiter', inv.waiterName, font, fontReg),
          pw.Divider(thickness: 0.5),
          ...inv.items.map((item) => pw.Padding(
            padding: const pw.EdgeInsets.symmetric(vertical: 1),
            child: pw.Column(crossAxisAlignment: pw.CrossAxisAlignment.start, children: [
              pw.Row(children: [
                pw.Expanded(child: pw.Text('${item.quantity}x ${item.menuItem.name}',
                    style: pw.TextStyle(font: fontReg, fontSize: 9))),
                pw.Text('${_settings.currencySymbol} ${item.lineTotal.toStringAsFixed(0)}',
                    style: pw.TextStyle(font: fontReg, fontSize: 9)),
              ]),
              if (item.isDeal && item.dealItems.isNotEmpty)
                pw.Text('  ${_dealSummary(item)}',
                    style: pw.TextStyle(font: fontReg, fontSize: 7, color: PdfColors.grey600)),
            ]),
          )),
          pw.Divider(thickness: 0.5),
          _totalRow('Subtotal', inv.subtotal, font, fontReg),
          if (inv.discountValue > 0) _totalRow('Discount', -inv.discountValue, font, fontReg, isNeg: true),
          if (inv.taxValue > 0) _totalRow('Tax', inv.taxValue, font, fontReg),
          if (inv.serviceChargeValue > 0) _totalRow('Service', inv.serviceChargeValue, font, fontReg),
          pw.Divider(thickness: 1),
          pw.Row(mainAxisAlignment: pw.MainAxisAlignment.spaceBetween, children: [
            pw.Text('TOTAL', style: pw.TextStyle(font: font, fontSize: 12)),
            pw.Text('${_settings.currencySymbol} ${inv.grandTotal.toStringAsFixed(0)}',
                style: pw.TextStyle(font: font, fontSize: 12, color: PdfColors.blue800)),
          ]),
          pw.SizedBox(height: 3),
          _totalRow('Paid (${_methodLabel(inv.paymentMethod)})', inv.amountPaid, font, fontReg),
          if (inv.changeAmount > 0) _totalRow('Change', inv.changeAmount, font, fontReg),
          pw.Divider(thickness: 0.5),
          pw.SizedBox(height: 4),
          pw.Center(child: pw.Text(_settings.footerMessage,
              style: pw.TextStyle(font: fontReg, fontSize: 8, color: PdfColors.grey600))),
          pw.Center(child: pw.Text('Thank you! Visit again.',
              style: pw.TextStyle(font: font, fontSize: 8, color: PdfColors.grey800))),
        ],
      ),
    ));
    return pdf.save();
  }

  // ── Internal: A4 Invoice PDF ──────────────────────
  Future<Uint8List> _buildA4PDF(InvoiceEntity inv, {required PdfPageFormat format}) async {
    final pdf = pw.Document();
    final font = await PdfGoogleFonts.nunitoBold();
    final fontReg = await PdfGoogleFonts.nunitoRegular();

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
                  child: pw.Image(logoImg, width: 60, height: 60, fit: pw.BoxFit.contain),
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
              pw.Text('Table: ${inv.tableName}', style: pw.TextStyle(font: fontReg, fontSize: 10)),
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
        ],
      ),
    ));
    return pdf.save();
  }

  // ── X Report PDF ──────────────────────────────────
  Future<Uint8List> _buildXReportPDF(CashRegisterEntity reg) async {
    final pdf = pw.Document();
    final font = await PdfGoogleFonts.nunitoBold();
    final fontReg = await PdfGoogleFonts.nunitoRegular();

    pdf.addPage(pw.Page(
      pageFormat: PdfPageFormat(_mmToPt(80), double.infinity, marginAll: _mmToPt(4)),
      build: (ctx) => pw.Column(crossAxisAlignment: pw.CrossAxisAlignment.start, children: [
        pw.Center(child: pw.Text(_settings.name, style: pw.TextStyle(font: font, fontSize: 12))),
        pw.Center(child: pw.Text('X REPORT — CURRENT SHIFT', style: pw.TextStyle(font: font, fontSize: 11))),
        pw.Center(child: pw.Text('(NO RESET)', style: pw.TextStyle(font: fontReg, fontSize: 9, color: PdfColors.grey600))),
        pw.Divider(),
        _rptRow('Shift opened', _df.format(reg.openedAt), font, fontReg),
        _rptRow('Printed at', _df.format(DateTime.now()), font, fontReg),
        _rptRow('Opened by', reg.openedBy, font, fontReg),
        pw.Divider(),
        pw.Text('SALES', style: pw.TextStyle(font: font, fontSize: 10)),
        _rptRow('Total orders', '${reg.totalOrders}', font, fontReg),
        _rptRow('Total sales', '${_settings.currencySymbol} ${reg.totalSales.toStringAsFixed(0)}', font, fontReg),
        _rptRow('Cash sales', '${_settings.currencySymbol} ${reg.totalCashSales.toStringAsFixed(0)}', font, fontReg),
        _rptRow('Card sales', '${_settings.currencySymbol} ${reg.totalCardSales.toStringAsFixed(0)}', font, fontReg),
        _rptRow('Wallet sales', '${_settings.currencySymbol} ${reg.totalWalletSales.toStringAsFixed(0)}', font, fontReg),
        _rptRow('Credit sales', '${_settings.currencySymbol} ${reg.totalCreditSales.toStringAsFixed(0)}', font, fontReg),
        pw.Divider(),
        pw.Text('DEDUCTIONS', style: pw.TextStyle(font: font, fontSize: 10)),
        _rptRow('Discounts', '${_settings.currencySymbol} ${reg.totalDiscounts.toStringAsFixed(0)}', font, fontReg),
        _rptRow('Tax collected', '${_settings.currencySymbol} ${reg.totalTax.toStringAsFixed(0)}', font, fontReg),
        _rptRow('Expenses', '${_settings.currencySymbol} ${reg.totalExpenses.toStringAsFixed(0)}', font, fontReg),
        _rptRow('Void orders', '${reg.totalVoids}', font, fontReg),
        pw.Divider(),
        pw.Text('KITCHEN', style: pw.TextStyle(font: font, fontSize: 10)),
        _rptRow('Kitchen tickets', '${reg.totalKitchenTickets}', font, fontReg),
        pw.Divider(),
        pw.Text('CASH DRAWER', style: pw.TextStyle(font: font, fontSize: 10)),
        _rptRow('Opening cash', '${_settings.currencySymbol} ${reg.openingCash.toStringAsFixed(0)}', font, fontReg),
        _rptRow('Cash in', '${_settings.currencySymbol} ${reg.cashIn.toStringAsFixed(0)}', font, fontReg),
        _rptRow('Cash out', '${_settings.currencySymbol} ${reg.cashOut.toStringAsFixed(0)}', font, fontReg),
        _rptRow('Expected cash', '${_settings.currencySymbol} ${reg.expectedCash.toStringAsFixed(0)}', font, fontReg),
        pw.Divider(),
        pw.Center(child: pw.Text('— End of X Report —', style: pw.TextStyle(font: fontReg, fontSize: 9))),
      ]),
    ));
    return pdf.save();
  }

  // ── Z Report PDF ──────────────────────────────────
  Future<Uint8List> _buildZReportPDF(CashRegisterEntity reg, double closingCash) async {
    final pdf = pw.Document();
    final font = await PdfGoogleFonts.nunitoBold();
    final fontReg = await PdfGoogleFonts.nunitoRegular();
    final diff = closingCash - reg.expectedCash;

    pdf.addPage(pw.Page(
      pageFormat: PdfPageFormat(_mmToPt(80), double.infinity, marginAll: _mmToPt(4)),
      build: (ctx) => pw.Column(crossAxisAlignment: pw.CrossAxisAlignment.start, children: [
        pw.Center(child: pw.Text(_settings.name, style: pw.TextStyle(font: font, fontSize: 12))),
        pw.Center(child: pw.Text('Z REPORT — END OF DAY', style: pw.TextStyle(font: font, fontSize: 11))),
        pw.Center(child: pw.Text('*** SHIFT CLOSED ***', style: pw.TextStyle(font: font, fontSize: 10, color: PdfColors.red700))),
        pw.Divider(thickness: 1),
        _rptRow('Date', _dtf.format(DateTime.now()), font, fontReg),
        _rptRow('Opened', _df.format(reg.openedAt), font, fontReg),
        _rptRow('Closed', _df.format(DateTime.now()), font, fontReg),
        _rptRow('Duration', _formatDuration(DateTime.now().difference(reg.openedAt)), font, fontReg),
        pw.Divider(),
        pw.Text('SALES SUMMARY', style: pw.TextStyle(font: font, fontSize: 10)),
        _rptRow('Total orders', '${reg.totalOrders}', font, fontReg),
        _rptRow('Gross sales', '${_settings.currencySymbol} ${reg.totalSales.toStringAsFixed(0)}', font, fontReg),
        _rptRow('Discounts', '-${_settings.currencySymbol} ${reg.totalDiscounts.toStringAsFixed(0)}', font, fontReg),
        _rptRow('Tax collected', '${_settings.currencySymbol} ${reg.totalTax.toStringAsFixed(0)}', font, fontReg),
        pw.Divider(),
        pw.Text('PAYMENT BREAKDOWN', style: pw.TextStyle(font: font, fontSize: 10)),
        _rptRow('Cash', '${_settings.currencySymbol} ${reg.totalCashSales.toStringAsFixed(0)}', font, fontReg),
        _rptRow('Card', '${_settings.currencySymbol} ${reg.totalCardSales.toStringAsFixed(0)}', font, fontReg),
        _rptRow('Wallet', '${_settings.currencySymbol} ${reg.totalWalletSales.toStringAsFixed(0)}', font, fontReg),
        _rptRow('Credit', '${_settings.currencySymbol} ${reg.totalCreditSales.toStringAsFixed(0)}', font, fontReg),
        pw.Divider(),
        pw.Text('CASH RECONCILIATION', style: pw.TextStyle(font: font, fontSize: 10)),
        _rptRow('Opening cash', '${_settings.currencySymbol} ${reg.openingCash.toStringAsFixed(0)}', font, fontReg),
        _rptRow('Cash sales', '${_settings.currencySymbol} ${reg.totalCashSales.toStringAsFixed(0)}', font, fontReg),
        _rptRow('Cash in', '+${_settings.currencySymbol} ${reg.cashIn.toStringAsFixed(0)}', font, fontReg),
        _rptRow('Cash out', '-${_settings.currencySymbol} ${reg.cashOut.toStringAsFixed(0)}', font, fontReg),
        _rptRow('Expenses', '-${_settings.currencySymbol} ${reg.totalExpenses.toStringAsFixed(0)}', font, fontReg),
        pw.Divider(thickness: 1),
        _rptRow('Expected cash', '${_settings.currencySymbol} ${reg.expectedCash.toStringAsFixed(0)}', font, font),
        _rptRow('Actual cash', '${_settings.currencySymbol} ${closingCash.toStringAsFixed(0)}', font, font),
        pw.Row(mainAxisAlignment: pw.MainAxisAlignment.spaceBetween, children: [
          pw.Text('DIFFERENCE', style: pw.TextStyle(font: font, fontSize: 11)),
          pw.Text('${diff >= 0 ? '+' : ''}${_settings.currencySymbol} ${diff.toStringAsFixed(0)}',
              style: pw.TextStyle(font: font, fontSize: 11,
                  color: diff.abs() < 10 ? PdfColors.green700 : PdfColors.red700)),
        ]),
        pw.Divider(),
        pw.Text('KITCHEN', style: pw.TextStyle(font: font, fontSize: 10)),
        _rptRow('Kitchen tickets printed', '${reg.totalKitchenTickets}', font, fontReg),
        _rptRow('Void transactions', '${reg.totalVoids}', font, fontReg),
        pw.Divider(thickness: 1),
        pw.Center(child: pw.Text('*** END OF DAY — COUNTERS RESET ***', style: pw.TextStyle(font: font, fontSize: 9, color: PdfColors.red700))),
        pw.Center(child: pw.Text(_df.format(DateTime.now()), style: pw.TextStyle(font: fontReg, fontSize: 8))),
      ]),
    ));
    return pdf.save();
  }

  Future<pw.MemoryImage?> _getLogoImage() async {
    if (_settings.logoPath != null && _settings.logoPath!.isNotEmpty) {
      final file = File(_settings.logoPath!);
      if (file.existsSync()) {
        try {
          final bytes = file.readAsBytesSync();
          return pw.MemoryImage(bytes);
        } catch (_) {}
      }
    }
    return null;
  }

  // ── Helpers ───────────────────────────────────────
  double _mmToPt(double mm) => mm * 2.8346;

  pw.Widget _billRow(String label, String val, pw.Font b, pw.Font r) => pw.Padding(
    padding: const pw.EdgeInsets.symmetric(vertical: 1),
    child: pw.Row(mainAxisAlignment: pw.MainAxisAlignment.spaceBetween, children: [
      pw.Text(label, style: pw.TextStyle(font: r, fontSize: 8)),
      pw.Text(val, style: pw.TextStyle(font: b, fontSize: 8)),
    ]),
  );

  pw.Widget _totalRow(String label, double val, pw.Font b, pw.Font r, {bool isNeg = false}) => pw.Padding(
    padding: const pw.EdgeInsets.symmetric(vertical: 1),
    child: pw.Row(mainAxisAlignment: pw.MainAxisAlignment.spaceBetween, children: [
      pw.Text(label, style: pw.TextStyle(font: r, fontSize: 9)),
      pw.Text('${isNeg ? '-' : ''}${_settings.currencySymbol} ${val.abs().toStringAsFixed(0)}',
          style: pw.TextStyle(font: b, fontSize: 9, color: isNeg ? PdfColors.green700 : null)),
    ]),
  );

  pw.Widget _a4TotalRow(String label, double val, pw.Font b, pw.Font r) => pw.Padding(
    padding: const pw.EdgeInsets.symmetric(vertical: 2),
    child: pw.Row(mainAxisAlignment: pw.MainAxisAlignment.spaceBetween, children: [
      pw.Text(label, style: pw.TextStyle(font: r, fontSize: 10)),
      pw.Text('${_settings.currencySymbol} ${val.abs().toStringAsFixed(0)}',
          style: pw.TextStyle(font: b, fontSize: 10, color: val < 0 ? PdfColors.green700 : null)),
    ]),
  );

  pw.Widget _rptRow(String label, String val, pw.Font b, pw.Font r) => pw.Padding(
    padding: const pw.EdgeInsets.symmetric(vertical: 2),
    child: pw.Row(mainAxisAlignment: pw.MainAxisAlignment.spaceBetween, children: [
      pw.Text(label, style: pw.TextStyle(font: r, fontSize: 9)),
      pw.Text(val, style: pw.TextStyle(font: b, fontSize: 9)),
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

import 'package:flutter_test/flutter_test.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:restaurant_pos/core/thermal_layout.dart';

void main() {
  test('thermal layout page is exactly 80mm wide with content-driven height', () {
    final t = ThermalLayout(paperWidthMm: 80, marginMm: 4);
    expect(t.pageFormat.width, closeTo(80 * PdfPageFormat.mm, 0.01));
    expect(t.pageFormat.height, double.infinity);
  });

  test('PDF mode saves an 80mm thermal receipt page', () async {
    final t = ThermalLayout(paperWidthMm: 80, marginMm: 4);
    final pdf = pw.Document();
    pdf.addPage(pw.Page(
      pageFormat: t.pageFormat,
      build: (ctx) => pw.Column(
        crossAxisAlignment: pw.CrossAxisAlignment.start,
        children: [
          t.center('RECEIPT', font: pw.Font.courierBold(), size: 12),
          t.row('Width', '80mm', size: 8, font: pw.Font.courier()),
          t.credit(pw.Font.courier(), 7),
        ],
      ),
    ));
    final bytes = await pdf.save();
    final text = String.fromCharCodes(bytes);
    final m = RegExp(r'/MediaBox\[([^\]]+)\]').firstMatch(text);
    expect(m, isNotNull, reason: 'PDF must declare a MediaBox');
    final dims = m!.group(1)!.trim().split(RegExp(r'\s+'));
    final width = double.parse(dims[2]);
    expect(width, closeTo(80 * PdfPageFormat.mm, 0.5),
        reason: 'PDF page width must be 80mm (thermal receipt size)');
  });
}

// ═══════════════════════════════════════════════════════
// THERMAL LAYOUT ENGINE
// ONE width-safe layout system shared by every 80mm/58mm
// thermal receipt & report in the application.
//
//   | safe margin | CONTENT AREA | safe margin |
//                        ↑
//                 nothing ever exceeds this
//
// Every line is measured against the actual content width
// before it is rendered. Right-hand values are always kept
// inside the safe right margin: they right-align, and when a
// label+value cannot fit on one line they wrap instead of
// being clipped. No hard-coded x/y coordinates anywhere.
// ═══════════════════════════════════════════════════════

import 'dart:math' as math;

import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;

/// Logo image plus its intrinsic pixel size, so the printed size can be
/// kept crisp (never upscaled past native resolution) while filling more
/// of the receipt width.
class ThermalLogo {
  final pw.MemoryImage image;
  final int pxWidth;
  final int pxHeight;
  ThermalLogo(pw.MemoryImage image)
      : image = image,
        pxWidth = image.width ?? 1,
        pxHeight = image.height ?? 1;
}

/// Single reusable layout configuration for thermal output.
class ThermalLayout {
  /// Assumed paper geometry: [paperWidthMm] wide with [marginMm] of safe
  /// border on each side (used for PDF save mode and previews).
  ThermalLayout({double paperWidthMm = 80, double marginMm = 4}) {
    paperWidth = paperWidthMm * PdfPageFormat.mm;
    safeMargin = marginMm * PdfPageFormat.mm;
    contentWidth = paperWidth - safeMargin * 2;
    _pageFormat = PdfPageFormat(paperWidth, double.infinity, marginAll: safeMargin);
  }

  /// Real printer geometry from the driver (used for direct thermal print).
  /// The Windows printing plugin renders the PDF 1:1 and clips anything
  /// outside the printer's printable area, so the page must use the exact
  /// margins reported by the driver or the right edge gets physically cut.
  ThermalLayout.fromFormat(PdfPageFormat format) {
    paperWidth = format.width;
    safeMargin = format.marginLeft;
    contentWidth = format.width - format.marginLeft - format.marginRight;
    _pageFormat = PdfPageFormat(
      format.width,
      double.infinity,
      marginLeft: format.marginLeft,
      marginTop: format.marginTop,
      marginRight: format.marginRight,
      marginBottom: format.marginBottom,
    );
  }

  /// Total page width in points.
  late final double paperWidth;

  /// Left safe (unprintable) border, in points.
  late final double safeMargin;

  /// Everything must render inside this width.
  late final double contentWidth;

  late final PdfPageFormat _pageFormat;

  /// Page format for a thermal roll: exact width, unlimited height.
  PdfPageFormat get pageFormat => _pageFormat;

  // Courier is monospace — every glyph ≈ 0.6 × fontSize.
  static const double _charW = 0.6;

  /// Estimated rendered width (pt) of [text] at [size].
  double measure(String text, double size) => text.length * size * _charW;

  pw.Widget get spacer => pw.SizedBox(height: safeMargin);

  // ── Centered text ──────────────────────────────────
  // Center() expands to the full content width, so text is truly centered
  // instead of hugging the left edge.
  pw.Widget center(String text,
          {required pw.Font font, double size = 9, double topPad = 0, double bottomPad = 0}) =>
      pw.Center(
        child: pw.Padding(
          padding: pw.EdgeInsets.only(top: topPad, bottom: bottomPad),
          child: pw.Text(text,
              textAlign: pw.TextAlign.center,
              style: pw.TextStyle(font: font, fontSize: size)),
        ),
      );

  // ── Section heading (left aligned, bold) ───────────
  pw.Widget section(String text,
          {required pw.Font font, double size = 10, double topPad = 5}) =>
      pw.Padding(
        padding: pw.EdgeInsets.only(top: topPad, bottom: 2),
        child: pw.Text(text,
            style: pw.TextStyle(font: font, fontSize: size)),
      );

  // ── Dashed separator filling the content width ─────
  pw.Widget dashedLine({double h = 1.0}) => pw.Align(
        alignment: pw.Alignment.centerLeft,
        child: pw.SizedBox(
          width: contentWidth,
          child: pw.Text(
            '- ' * ((contentWidth / (4.2 * _charW)).round() + 1),
            style: pw.TextStyle(font: pw.Font.courier(), fontSize: 7, letterSpacing: 0.8),
            maxLines: 1,
            overflow: pw.TextOverflow.clip,
          ),
        ),
      );

  // ── Label ····· value row (classic POS) ─────────────
  // Dot-leader when it fits; otherwise a two-column layout
  // where the label wraps and the value stays right-aligned
  // inside the safe area. Never clips, never overflows.
  pw.Widget row(String label, String value,
      {double size = 9, required pw.Font font, pw.Font? valueFont}) {
    final vf = valueFont ?? font;
    final labelW = measure(label, size);
    final valueW = measure(value, size);
    final spaceW = measure(' ', size);
    final availableForDots = contentWidth - labelW - valueW - spaceW * 2;
    if (availableForDots >= measure('.', size) && labelW <= contentWidth * 0.6) {
      final dots = (availableForDots / measure('.', size)).floor().clamp(1, 40);
      final line = '$label ${'.' * dots} $value';
      return pw.Align(
        alignment: pw.Alignment.centerLeft,
        child: pw.SizedBox(
          width: contentWidth,
          child: pw.Text(line,
              style: pw.TextStyle(font: font, fontSize: size),
              maxLines: 1,
              overflow: pw.TextOverflow.clip),
        ),
      );
    }
    return _twoCol(label, value, font, vf, size);
  }

  // ── Two-column label / right-aligned value ──────────
  pw.Widget _twoCol(String label, String value, pw.Font font, pw.Font vf, double size) {
    final valueW = (measure(value, size) + 2).clamp(0.0, contentWidth * 0.55);
    return pw.Row(
      crossAxisAlignment: pw.CrossAxisAlignment.start,
      children: [
        pw.Expanded(
          child: pw.Text(label,
              style: pw.TextStyle(font: font, fontSize: size)),
        ),
        pw.SizedBox(width: 3),
        pw.SizedBox(
          width: valueW,
          child: pw.Text(value,
              textAlign: pw.TextAlign.right,
              style: pw.TextStyle(font: vf, fontSize: size)),
        ),
      ],
    );
  }

  // ── Item line: name (wraps) + qty/value right ───────
  pw.Widget item(String name, String value,
          {double size = 9, required pw.Font font, pw.Font? valueFont}) =>
      row(name, value, size: size, font: font, valueFont: valueFont);

  // ── Indented wrapped sub-line (modifiers/notes/deals) ──
  pw.Widget sub(String text, {double size = 7, required pw.Font font, double indentMm = 5}) =>
      pw.Padding(
        padding: pw.EdgeInsets.only(left: indentMm * PdfPageFormat.mm, top: 1),
        child: pw.Text(text,
            style: pw.TextStyle(font: font, fontSize: size)),
      );

  // ── Header block: logo · name · title · subtitle ────
  pw.Widget header({
    ThermalLogo? logo,
    required String name,
    String title = '',
    String? subtitle,
    double logoSizeMm = 34,
    double nameSize = 14,
    double titleSize = 11,
  }) {
    final children = <pw.Widget>[];
    if (logo != null) {
      final r = _logoRender(logo, logoSizeMm);
      children.add(pw.Center(
        child: pw.Padding(
          padding: const pw.EdgeInsets.only(bottom: 4),
          child: pw.Image(logo.image,
              width: r.w,
              height: r.h,
              fit: pw.BoxFit.contain),
        ),
      ));
    }
    children.add(center(name, font: pw.Font.courierBold(), size: nameSize, bottomPad: 2));
    if (title.isNotEmpty) {
      children.add(center(title, font: pw.Font.courierBold(), size: titleSize));
    }
    if (subtitle != null && subtitle.isNotEmpty) {
      children.add(center(subtitle, font: pw.Font.courier(), size: 9));
    }
    return pw.Column(crossAxisAlignment: pw.CrossAxisAlignment.center, children: children);
  }

  // ── Logo sizing: big but never pixelated ────────────
  // Fills up to [maxMm] of width while preserving aspect ratio. The print
  // size is capped so the effective DPI never drops below ~160, which keeps
  // the logo crisp even when the stored file is low-resolution.
  ({double w, double h}) _logoRender(ThermalLogo logo, double maxMm) {
    final maxW = math.min(maxMm * PdfPageFormat.mm, contentWidth * 0.94);
    final maxH = maxMm * 0.85 * PdfPageFormat.mm;
    final aspect = logo.pxWidth / logo.pxHeight;
    double w = maxW;
    double h = w / aspect;
    if (h > maxH) {
      h = maxH;
      w = h * aspect;
    }
    const targetDpi = 160.0;
    final nativeW = logo.pxWidth / targetDpi * PdfPageFormat.inch;
    final nativeH = logo.pxHeight / targetDpi * PdfPageFormat.inch;
    if (w > nativeW) {
      final r = nativeW / w;
      w = nativeW;
      h *= r;
    }
    if (h > nativeH) {
      final r = nativeH / h;
      h = nativeH;
      w *= r;
    }
    return (w: w, h: h);
  }

  // ── Footer: closing line + software credit ──────────
  pw.Widget footer(String thankYou, {required pw.Font font, double size = 8}) =>
      pw.Column(crossAxisAlignment: pw.CrossAxisAlignment.start, children: [
        pw.SizedBox(height: 5),
        dashedLine(),
        pw.SizedBox(height: 5),
        center(thankYou, font: font, size: size),
        credit(font, size),
      ]);

  // ── Software credit ─────────────────────────────────
  // Bold + full black so it is clearly visible on thermal paper.
  pw.Widget credit(pw.Font font, double size) => pw.Padding(
        padding: const pw.EdgeInsets.only(top: 2, bottom: 6),
        child: pw.Center(
          child: pw.Text('Software By Engr. Hamza Asad',
              style: pw.TextStyle(
                  font: pw.Font.courierBold(),
                  fontSize: size,
                  color: PdfColors.black)),
        ),
      );
}

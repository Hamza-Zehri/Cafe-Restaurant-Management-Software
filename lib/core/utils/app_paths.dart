import 'dart:io';
import 'package:path/path.dart' as p;
import 'package:path_provider/path_provider.dart';

class AppPaths {
  static late final String documentsDir;

  static String get baseDir => p.join(documentsDir, 'restaurant_pos').replaceAll('\\', '/');
  static String get mediaDir => p.join(baseDir, 'media').replaceAll('\\', '/');
  static String get backupsDir => p.join(baseDir, 'backups').replaceAll('\\', '/');
  static String get dbPath => p.join(baseDir, 'pos.db').replaceAll('\\', '/');

  /// Initialize and cache the documents directory path, creating the media folder if it does not exist.
  static Future<void> init() async {
    final dir = await getApplicationDocumentsDirectory();
    documentsDir = dir.path.replaceAll('\\', '/');
    await Directory(mediaDir).create(recursive: true);
    await Directory(backupsDir).create(recursive: true);
  }

  /// Resolves an image path dynamically.
  /// If it is relative (e.g. "media/img_123.jpg"), it prepends the current baseDir.
  /// If it is absolute and belongs to another installation (e.g. contains "restaurant_pos/"),
  /// it maps it relative to the current documents folder.
  /// Otherwise, it returns the path as-is.
  static String resolve(String pathStr) {
    if (pathStr.isEmpty) return '';
    final normalized = pathStr.replaceAll('\\', '/');
    if (normalized.contains('restaurant_pos/')) {
      final idx = normalized.indexOf('restaurant_pos/');
      final relativePart = normalized.substring(idx + 'restaurant_pos/'.length);
      return p.join(baseDir, relativePart).replaceAll('\\', '/');
    }
    if (p.isAbsolute(normalized)) {
      return normalized;
    }
    return p.join(baseDir, normalized).replaceAll('\\', '/');
  }

  /// Copies a source file to the internal media directory and returns its relative path (e.g. "media/logo_123.png").
  static Future<String> copyToMedia(String sourcePath, {required String prefix}) async {
    if (sourcePath.isEmpty) return '';
    final srcFile = File(sourcePath);
    if (!await srcFile.exists()) return sourcePath;

    // Check if the source is already inside our media directory
    final normalizedSource = sourcePath.replaceAll('\\', '/');
    if (normalizedSource.contains('restaurant_pos/media/')) {
      final idx = normalizedSource.indexOf('restaurant_pos/media/');
      return normalizedSource.substring(idx + 'restaurant_pos/'.length);
    }

    final ext = p.extension(sourcePath);
    final fileName = '${prefix}_${DateTime.now().millisecondsSinceEpoch}${ext.isEmpty ? '.jpg' : ext}';
    final destPath = p.join(mediaDir, fileName);

    await Directory(mediaDir).create(recursive: true);
    await srcFile.copy(destPath);
    return 'media/$fileName';
  }
}

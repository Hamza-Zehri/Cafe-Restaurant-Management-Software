import 'dart:io';
import 'package:archive/archive_io.dart';
import 'package:path/path.dart' as p;
import 'app_paths.dart';

class BackupService {
  static const int autoBackupRetentionDays = 5;
  static const String _autoBackupPrefix = 'restaurant_pos_auto_backup_';

  /// Packages the database file and the local media folder into a single ZIP archive.
  static Future<void> createBackup(String destZipPath) async {
    final encoder = ZipFileEncoder();
    encoder.create(destZipPath);

    // 1. Add SQLite database and any SQLite sidecar files.
    final dbFiles = {
      AppPaths.dbPath: 'pos.db',
      '${AppPaths.dbPath}-wal': 'pos.db-wal',
      '${AppPaths.dbPath}-shm': 'pos.db-shm',
    };
    for (final entry in dbFiles.entries) {
      final dbFile = File(entry.key);
      if (await dbFile.exists()) {
        encoder.addFile(dbFile, entry.value);
      }
    }

    // 2. Add media files
    final mediaDir = Directory(AppPaths.mediaDir);
    if (await mediaDir.exists()) {
      final entities = mediaDir.listSync(recursive: true);
      for (final entity in entities) {
        if (entity is File) {
          final relativePath = 'media/${p.basename(entity.path)}';
          encoder.addFile(entity, relativePath);
        }
      }
    }

    encoder.close();
  }

  /// Creates one automatic backup per calendar day and keeps only the newest daily archives.
  /// [destDir] overrides the default backup directory (AppPaths.backupsDir).
  static Future<String?> createDailyBackupIfNeeded({String? destDir}) async {
    final backupDir = (destDir != null && destDir.isNotEmpty) ? destDir : AppPaths.backupsDir;
    await Directory(backupDir).create(recursive: true);

    final dbFile = File(AppPaths.dbPath);
    if (!await dbFile.exists()) {
      await pruneOldAutomaticBackups(backupDir: backupDir);
      return null;
    }

    final today = _dateStamp(DateTime.now());
    final destPath = p.join(
      backupDir,
      '$_autoBackupPrefix$today.zip',
    );

    final backupFile = File(destPath);
    if (!await backupFile.exists()) {
      await createBackup(destPath);
    }

    await pruneOldAutomaticBackups(backupDir: backupDir);
    return destPath;
  }

  static Future<void> pruneOldAutomaticBackups({
    int keepDays = autoBackupRetentionDays,
    String? backupDir,
  }) async {
    final dirPath = (backupDir != null && backupDir.isNotEmpty) ? backupDir : AppPaths.backupsDir;
    final dir = Directory(dirPath);
    if (!await dir.exists()) return;

    final backups = dir
        .listSync()
        .whereType<File>()
        .where((file) {
          final name = p.basename(file.path);
          return name.startsWith(_autoBackupPrefix) && name.endsWith('.zip');
        })
        .toList()
      ..sort((a, b) => b.statSync().modified.compareTo(a.statSync().modified));

    for (final oldBackup in backups.skip(keepDays)) {
      try {
        await oldBackup.delete();
      } catch (_) {
        // A locked backup can be cleaned on a later startup.
      }
    }
  }

  static String _dateStamp(DateTime value) {
    final y = value.year.toString().padLeft(4, '0');
    final m = value.month.toString().padLeft(2, '0');
    final d = value.day.toString().padLeft(2, '0');
    return '$y-$m-$d';
  }

  /// Extracts the ZIP archive into a temporary folder, validates it, closes the active database via a callback,
  /// overwrites the database and media folders, and cleans up the temporary files.
  static Future<bool> restoreBackup(String srcZipPath, {required Future<void> Function() onBeforeRestore}) async {
    final zipFile = File(srcZipPath);
    if (!await zipFile.exists()) return false;

    // Create a unique temporary directory to extract backup contents for verification
    final tempDir = await Directory(p.join(AppPaths.documentsDir, 'temp_restore_${DateTime.now().millisecondsSinceEpoch}')).create(recursive: true);

    try {
      final bytes = await zipFile.readAsBytes();
      final archive = ZipDecoder().decodeBytes(bytes);

      // Unzip all files
      for (final file in archive) {
        final filename = file.name;
        if (file.isFile) {
          final data = file.content as List<int>;
          final outFile = File(p.join(tempDir.path, filename));
          await outFile.parent.create(recursive: true);
          await outFile.writeAsBytes(data);
        } else {
          await Directory(p.join(tempDir.path, filename)).create(recursive: true);
        }
      }

      // Validate database exists in the backup
      final newDbFile = File(p.join(tempDir.path, 'pos.db'));
      if (!await newDbFile.exists()) {
        throw Exception("Invalid backup file: pos.db database file not found in the archive.");
      }

      // Close the current active database connection using the provided callback
      await onBeforeRestore();

      // Overwrite database and clear stale SQLite sidecar files.
      final currentDbFiles = [
        File(AppPaths.dbPath),
        File('${AppPaths.dbPath}-wal'),
        File('${AppPaths.dbPath}-shm'),
      ];
      for (final currentDbFile in currentDbFiles) {
        if (await currentDbFile.exists()) {
          await currentDbFile.delete();
        }
      }
      await newDbFile.copy(AppPaths.dbPath);

      final sidecarFiles = {
        'pos.db-wal': '${AppPaths.dbPath}-wal',
        'pos.db-shm': '${AppPaths.dbPath}-shm',
      };
      for (final entry in sidecarFiles.entries) {
        final backupSidecar = File(p.join(tempDir.path, entry.key));
        if (await backupSidecar.exists()) {
          await backupSidecar.copy(entry.value);
        }
      }

      // Copy media directory contents
      final newMediaDir = Directory(p.join(tempDir.path, 'media'));
      if (await newMediaDir.exists()) {
        final mediaDir = Directory(AppPaths.mediaDir);
        await mediaDir.create(recursive: true);
        final entities = newMediaDir.listSync(recursive: true);
        for (final entity in entities) {
          if (entity is File) {
            final destFilePath = p.join(AppPaths.mediaDir, p.basename(entity.path));
            await entity.copy(destFilePath);
          }
        }
      }

      return true;
    } finally {
      // Clean up temporary restore files
      if (await tempDir.exists()) {
        await tempDir.delete(recursive: true);
      }
    }
  }
}

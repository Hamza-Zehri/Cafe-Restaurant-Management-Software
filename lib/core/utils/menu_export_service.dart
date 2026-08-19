import 'dart:convert';
import 'dart:io';

import 'package:archive/archive.dart';
import 'package:drift/drift.dart' show Value;
import 'package:path/path.dart' as p;

import '../../data/datasources/database.dart';
import 'app_paths.dart';

/// Handles exporting and importing the complete menu (categories, items,
/// deals) including all referenced images as a single ZIP archive.
class MenuExportService {
  /// Exports the full menu to [destZipPath].
  ///
  /// The ZIP contains:
  ///   menu.json          – structured menu data
  ///   media/<file>       – copied image files referenced by the menu
  static Future<void> exportMenu(String destZipPath, AppDatabase db) async {
    // ── 1. Fetch all data ──────────────────────────────
    final groups = await db.menuDao.getGroups();
    final allItems = <_ExportItem>[];
    final groupMap = <int, String>{}; // id → name (for deal-item resolution)

    for (final g in groups) {
      groupMap[g.id] = g.name;
      final items = await db.menuDao.getByGroup(g.id);
      for (final it in items) {
        allItems.add(_ExportItem(
          groupName: g.name,
          name: it.name,
          price: it.price,
          costPrice: it.costPrice,
          description: it.description ?? '',
          imagePath: it.imagePath ?? '',
          preparationMinutes: it.preparationMinutes,
          isAvailable: it.isAvailable,
          stockCount: it.stockCount,
          taxPercent: it.taxPercent,
          sortOrder: it.sortOrder,
        ));
      }
    }

    final deals = await db.dealDao.getAllDeals();
    final exportDeals = <_ExportDeal>[];
    for (final d in deals) {
      final dealItems = await db.dealDao.itemsForDeal(d.id);
      final items = <_ExportDealItem>[];
      for (final di in dealItems) {
        final menuItem = await db.menuDao.byId(di.menuItemId);
        if (menuItem != null) {
          items.add(_ExportDealItem(
            itemName: menuItem.name,
            quantity: di.quantity,
          ));
        }
      }
      exportDeals.add(_ExportDeal(
        name: d.name,
        code: d.code ?? '',
        price: d.price,
        description: d.description ?? '',
        imagePath: d.imagePath ?? '',
        items: items,
      ));
    }

    final exportGroups = groups.map((g) => _ExportGroup(
      name: g.name,
      colorHex: g.colorHex,
      sortOrder: g.sortOrder,
      imagePath: g.iconPath,
    )).toList();

    final restaurantName = await db.settingsDao.get('restaurant_name') ?? '';

    // ── 2. Build menu.json ─────────────────────────────
    final menuData = {
      'version': 1,
      'exportedAt': DateTime.now().toIso8601String(),
      'restaurantName': restaurantName,
      'groups': exportGroups.map((g) => g.toJson()).toList(),
      'items': allItems.map((i) => i.toJson()).toList(),
      'deals': exportDeals.map((d) => d.toJson()).toList(),
    };

    // ── 3. Collect unique image paths ──────────────────
    final imagePaths = <String>{};
    for (final g in exportGroups) {
      if (g.imagePath.isNotEmpty) imagePaths.add(g.imagePath);
    }
    for (final it in allItems) {
      if (it.imagePath.isNotEmpty) imagePaths.add(it.imagePath);
    }
    for (final d in exportDeals) {
      if (d.imagePath.isNotEmpty) imagePaths.add(d.imagePath);
    }

    // ── 4. Build ZIP ──────────────────────────────────
    final archive = Archive();
    archive.addFile(ArchiveFile.string('menu.json', jsonEncode(menuData)));

    for (final relPath in imagePaths) {
      final absPath = AppPaths.resolve(relPath);
      final file = File(absPath);
      if (await file.exists()) {
        final bytes = await file.readAsBytes();
        archive.addFile(ArchiveFile('media/${p.basename(absPath)}', bytes.length, bytes));
      }
    }

    final zipBytes = ZipEncoder().encode(archive);
    if (zipBytes == null) throw Exception('Failed to encode ZIP archive');
    await File(destZipPath).writeAsBytes(zipBytes);
  }

  /// Imports a menu from a ZIP archive at [zipPath].
  ///
  /// - Existing menu items, groups, and deals are **kept** (merge, not replace).
  /// - Groups are matched by name. Items are matched by name+group.
  /// - Images are copied into the media directory.
  static Future<MenuImportResult> importMenu(String zipPath, AppDatabase db) async {
    var groupsCreated = 0, itemsCreated = 0, dealsCreated = 0;
    var groupsSkipped = 0, itemsSkipped = 0, dealsSkipped = 0;

    // ── 1. Extract ZIP to temp ──────────────────────────
    final bytes = await File(zipPath).readAsBytes();
    final archive = ZipDecoder().decodeBytes(bytes);

    String? menuJson;
    final mediaFiles = <String, List<int>>{}; // basename → bytes

    for (final file in archive) {
      if (file.isFile) {
        if (file.name == 'menu.json') {
          menuJson = utf8.decode(file.content as List<int>);
        } else if (file.name.startsWith('media/')) {
          final name = p.basename(file.name);
          mediaFiles[name] = file.content as List<int>;
        }
      }
    }

    if (menuJson == null) throw Exception('Invalid menu archive: missing menu.json');
    final data = jsonDecode(menuJson) as Map<String, dynamic>;

    // ── 2. Copy images to media dir ────────────────────
    final mediaDir = Directory(AppPaths.mediaDir);
    await mediaDir.create(recursive: true);
    for (final entry in mediaFiles.entries) {
      final dest = File(p.join(AppPaths.mediaDir, entry.key));
      if (!await dest.exists()) {
        await dest.writeAsBytes(entry.value);
      }
    }

    // ── 3. Import groups ────────────────────────────────
    final existingGroups = await db.menuDao.getGroups();
    final groupNameToId = <String, int>{};
    for (final g in existingGroups) {
      groupNameToId[g.name] = g.id;
    }

    final rawGroups = (data['groups'] as List?) ?? [];
    for (final rg in rawGroups) {
      final name = rg['name'] as String;
      if (groupNameToId.containsKey(name)) {
        groupsSkipped++;
        continue;
      }
      final imgPath = rg['imagePath'] as String? ?? '';
      final copiedPath = imgPath.isNotEmpty ? _copyImageToMedia(imgPath, mediaFiles) : '';
      final id = await db.menuDao.insertGroup(MenuGroupsCompanion.insert(
        name: name,
        iconPath: Value(copiedPath),
        colorHex: Value(rg['colorHex'] as String? ?? '#1A56DB'),
        sortOrder: Value(rg['sortOrder'] as int? ?? 0),
      ));
      groupNameToId[name] = id;
      groupsCreated++;
    }

    // ── 4. Import items ─────────────────────────────────
    final existingItems = await <String, int>{}; // "groupName|itemName" → id
    for (final g in groupNameToId.entries) {
      final items = await db.menuDao.getByGroup(g.value);
      for (final it in items) {
        existingItems['${g.key}|${it.name}'] = it.id;
      }
    }

    final rawItems = (data['items'] as List?) ?? [];
    for (final ri in rawItems) {
      final groupName = ri['groupName'] as String;
      final name = ri['name'] as String;
      final key = '$groupName|$name';
      if (existingItems.containsKey(key)) {
        itemsSkipped++;
        continue;
      }
      final gid = groupNameToId[groupName];
      if (gid == null) continue; // group wasn't imported

      final imgPath = ri['imagePath'] as String? ?? '';
      final copiedPath = imgPath.isNotEmpty ? _copyImageToMedia(imgPath, mediaFiles) : '';

      await db.menuDao.insertItem(MenuItemsCompanion.insert(
        groupId: gid,
        name: name,
        price: (ri['price'] as num?)?.toDouble() ?? 0,
        costPrice: Value((ri['costPrice'] as num?)?.toDouble() ?? 0),
        description: Value((ri['description'] as String?)?.isNotEmpty == true ? ri['description'] as String : null),
        imagePath: Value(copiedPath.isEmpty ? null : copiedPath),
        preparationMinutes: Value(ri['preparationMinutes'] as int? ?? 10),
        isAvailable: Value(ri['isAvailable'] as bool? ?? true),
        stockCount: Value(ri['stockCount'] as int? ?? -1),
        taxPercent: Value((ri['taxPercent'] as num?)?.toDouble() ?? 0),
        sortOrder: Value(ri['sortOrder'] as int? ?? 0),
      ));
      // Re-read to get new ID
      final inserted = await db.menuDao.search(name);
      if (inserted.isNotEmpty) {
        existingItems[key] = inserted.last.id;
      }
      itemsCreated++;
    }

    // ── 5. Import deals ─────────────────────────────────
    final rawDeals = (data['deals'] as List?) ?? [];
    final existingDealNames = (await db.dealDao.getAllDeals()).map((d) => d.name).toSet();

    for (final rd in rawDeals) {
      final dealName = rd['name'] as String;
      if (existingDealNames.contains(dealName)) {
        dealsSkipped++;
        continue;
      }

      final imgPath = rd['imagePath'] as String? ?? '';
      final copiedPath = imgPath.isNotEmpty ? _copyImageToMedia(imgPath, mediaFiles) : '';

      final dealId = await db.dealDao.insertDeal(DealsCompanion.insert(
        name: dealName,
        code: Value((rd['code'] as String?)?.isNotEmpty == true ? rd['code'] as String : null),
        price: (rd['price'] as num?)?.toDouble() ?? 0,
        description: Value((rd['description'] as String?)?.isNotEmpty == true ? rd['description'] as String : null),
        imagePath: Value(copiedPath.isEmpty ? null : copiedPath),
      ));

      final dealItemsRaw = (rd['items'] as List?) ?? [];
      for (final di in dealItemsRaw) {
        final itemName = di['itemName'] as String;
        final qty = di['quantity'] as int? ?? 1;
        // Find matching item by name across all groups
        for (final entry in existingItems.entries) {
          if (entry.key.endsWith('|$itemName')) {
            await db.dealDao.insertDealItem(DealItemsCompanion.insert(
              dealId: dealId,
              menuItemId: entry.value,
              quantity: qty,
            ));
            break;
          }
        }
      }
      existingDealNames.add(dealName);
      dealsCreated++;
    }

    return MenuImportResult(
      groupsCreated: groupsCreated,
      groupsSkipped: groupsSkipped,
      itemsCreated: itemsCreated,
      itemsSkipped: itemsSkipped,
      dealsCreated: dealsCreated,
      dealsSkipped: dealsSkipped,
    );
  }

  /// Copies an image from the extracted ZIP media into the app's media dir.
  /// Returns the new relative path or empty string if not found.
  static String _copyImageToMedia(String originalPath, Map<String, List<int>> mediaFiles) {
    final baseName = p.basename(originalPath);
    final bytes = mediaFiles[baseName];
    if (bytes == null) return '';
    final dest = p.join(AppPaths.mediaDir, baseName);
    File(dest).writeAsBytesSync(bytes);
    return 'media/$baseName';
  }
}

// ── Data classes ─────────────────────────────────────

class _ExportGroup {
  final String name, colorHex, imagePath;
  final int sortOrder;
  const _ExportGroup({required this.name, this.colorHex = '#1A56DB', this.sortOrder = 0, this.imagePath = ''});
  Map<String, dynamic> toJson() => {'name': name, 'colorHex': colorHex, 'sortOrder': sortOrder, 'imagePath': imagePath};
}

class _ExportItem {
  final String groupName, name, description, imagePath;
  final double price, costPrice, taxPercent;
  final int preparationMinutes, stockCount, sortOrder;
  final bool isAvailable;
  const _ExportItem({required this.groupName, required this.name, this.price = 0, this.costPrice = 0,
    this.description = '', this.imagePath = '', this.preparationMinutes = 10,
    this.isAvailable = true, this.stockCount = -1, this.taxPercent = 0, this.sortOrder = 0});
  Map<String, dynamic> toJson() => {
    'groupName': groupName, 'name': name, 'price': price, 'costPrice': costPrice,
    'description': description, 'imagePath': imagePath,
    'preparationMinutes': preparationMinutes, 'isAvailable': isAvailable,
    'stockCount': stockCount, 'taxPercent': taxPercent, 'sortOrder': sortOrder,
  };
}

class _ExportDeal {
  final String name, code, description, imagePath;
  final double price;
  final List<_ExportDealItem> items;
  const _ExportDeal({required this.name, this.code = '', this.price = 0,
    this.description = '', this.imagePath = '', this.items = const []});
  Map<String, dynamic> toJson() => {
    'name': name, 'code': code, 'price': price, 'description': description,
    'imagePath': imagePath, 'items': items.map((i) => i.toJson()).toList(),
  };
}

class _ExportDealItem {
  final String itemName;
  final int quantity;
  const _ExportDealItem({required this.itemName, this.quantity = 1});
  Map<String, dynamic> toJson() => {'itemName': itemName, 'quantity': quantity};
}

class MenuImportResult {
  final int groupsCreated, groupsSkipped;
  final int itemsCreated, itemsSkipped;
  final int dealsCreated, dealsSkipped;
  const MenuImportResult({this.groupsCreated = 0, this.groupsSkipped = 0,
    this.itemsCreated = 0, this.itemsSkipped = 0,
    this.dealsCreated = 0, this.dealsSkipped = 0});

  @override
  String toString() => 'Groups: +$groupsCreated ($groupsSkipped skipped), '
      'Items: +$itemsCreated ($itemsSkipped skipped), '
      'Deals: +$dealsCreated ($dealsSkipped skipped)';
}

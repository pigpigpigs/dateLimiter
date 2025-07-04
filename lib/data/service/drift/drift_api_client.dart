import 'package:drift/drift.dart';
import 'package:flutter/foundation.dart';
import 'package:food_limmit_controller/data/service/drift/drift_database.dart';
import 'package:food_limmit_controller/data/service/model/item/item_model.dart';

class DriftApiClient {
  final AppDatabase database;

  DriftApiClient(this.database);

  Future<List<ItemModel>> getItemsAsModel() async {
    final items = await database.select(database.itemTable).get();
    return items
        .map(
          (item) => ItemModel(
            id: item.id,
            expirationDate: item.expirationDate!,
            imagePath: item.imagePath,
          ),
        )
        .toList();
  }

  Future<void> addItem(ItemTableCompanion item) async {
    await database.into(database.itemTable).insertReturning(item);
  }

  Future<bool> updateItem(ItemTableCompanion item) async {
    return await database.update(database.itemTable).replace(item);
  }

  Future<int> deleteItem(int id) async {
    return await (database.delete(database.itemTable)
      ..where((t) => t.id.equals(id))).go();
  }

  Future<void> deleteLimitoutItem() async {
    final now = DateTime.now();
    debugPrint(now.toString());
    final itemsToDelete =
        await (database.select(database.itemTable)
          ..where((t) => t.expirationDate.isSmallerThanValue(now))).get();
    for (final item in itemsToDelete) {
      debugPrint(
        'Deleting item with ID: ${item.id}, Expiration Date: ${item.expirationDate}',
      );
      await (database.delete(database.itemTable)
        ..where((t) => t.expirationDate.isSmallerThanValue(now))).go();
    }
  }

  Future<void> deleteAllItems() async {
    await database.delete(database.itemTable).go();
  }

  // ItemTableData から ItemModel への変換を行うヘルパー関数 (必要に応じて)
  ItemModel _itemTableDataToItemModel(ItemTableData data) {
    return ItemModel(
      id: data.id,
      expirationDate: data.expirationDate!,
      imagePath: data.imagePath,
    );
  }

  // 個別の Item を取得して ItemModel で返す関数 (必要に応じて)
  Future<ItemModel?> getItemAsModel(int id) async {
    final query = database.select(database.itemTable)
      ..where((t) => t.id.equals(id));
    final itemData = await query.getSingleOrNull();
    return itemData != null ? _itemTableDataToItemModel(itemData) : null;
  }
}

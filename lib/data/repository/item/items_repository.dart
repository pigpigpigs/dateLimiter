import 'package:drift/drift.dart';
import 'package:food_limmit_controller/data/repository/item/IF_items_repository.dart';
import 'package:food_limmit_controller/data/service/drift/drift_api_client.dart';
import 'package:food_limmit_controller/data/service/drift/drift_database.dart';
import 'package:food_limmit_controller/data/service/model/item/item_model.dart';
import 'package:food_limmit_controller/domain/model/Item/item.dart';
import 'package:food_limmit_controller/domain/model/insert_item/insert_item.dart';

class ItemsRepository implements IFItemsRepository {
  ItemsRepository(this.database);

  final AppDatabase database;

  @override
  Future<List<ItemModel>> fetchItems() async {
    return await DriftApiClient(database).getItemsAsModel();
  }

  @override
  Future<void> addItem(InsertItem item) async {
    final driftApiClient = DriftApiClient(database);
    final itemCompanion = ItemTableCompanion(
      expirationDate: Value(item.expirationDate),
      imagePath: Value(item.imagePath),
    );
    await driftApiClient.addItem(itemCompanion);
    //return await driftApiClient.getItemsAsModel();
  }

  @override
  Future<void> deleteItem(int itemId) async {
    final driftApiClient = DriftApiClient(database);
    await driftApiClient.deleteItem(itemId);
    //return await driftApiClient.getItemsAsModel();
  }

  @override
  Future<void> deleteAllItems() async {
    final driftApiClient = DriftApiClient(database);
    await driftApiClient.deleteAllItems();
  }

  @override
  Future<void> deleteLimitoutItem() async {
    final driftApiClient = DriftApiClient(database);
    await driftApiClient.deleteLimitoutItem();
    //return await driftApiClient.getItemsAsModel();
  }
}

DateTime fromStringExpirationDate(String stringDate) {
  final dateParts = stringDate.split('-');
  return DateTime(
    int.parse(dateParts[0]),
    int.parse(dateParts[1]),
    int.parse(fromStringBEtoStringCount(dateParts[2])),
  );
}

String fromStringBEtoStringCount(String stringBE) {
  if (stringBE == '下旬') {
    return '16';
  } else {
    return '1';
  }
}

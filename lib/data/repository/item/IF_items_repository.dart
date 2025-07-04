import 'package:food_limmit_controller/data/service/model/item/item_model.dart';
import 'package:food_limmit_controller/domain/model/Item/item.dart';
import 'package:food_limmit_controller/domain/model/insert_item/insert_item.dart';

abstract class IFItemsRepository {
  Future<List<ItemModel>> fetchItems();

  Future<void> addItem(InsertItem item);

  Future<void> deleteItem(int itemId);

  Future<void> deleteAllItems();

  Future<void> deleteLimitoutItem();
}

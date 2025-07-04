import 'package:food_limmit_controller/data/repository/item/IF_items_repository.dart';
import 'package:food_limmit_controller/data/repository/item/items_repository.dart';
import 'package:food_limmit_controller/data/service/drift/drift_database.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'IF_item_repository_provider.g.dart';

@riverpod
IFItemsRepository itemsRepository(Ref ref) {
  final database = ref.watch(appDatabaseProvider);
  return ItemsRepository(database);
}

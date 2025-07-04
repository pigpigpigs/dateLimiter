import 'package:drift/drift.dart';
import 'package:flutter/widgets.dart';
import 'package:food_limmit_controller/data/repository/item/IF_item_repository_provider.dart';
import 'package:food_limmit_controller/data/service/model/item/item_model.dart';
import 'package:food_limmit_controller/domain/model/Item/item.dart';
import 'package:food_limmit_controller/domain/model/date/date.dart';
import 'package:food_limmit_controller/ui/setting_page/setting_page_view_model.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'main_page_view_model.g.dart';

@riverpod
class MainPageViewModel extends _$MainPageViewModel {
  @override
  Future<List<Item>> build() async {
    return init();
  }

  Future<List<Item>> init() async {
    //ここでripositoryでデータを取得する
    final itemsProvider = await ref.read(itemsRepositoryProvider).fetchItems();
    //ItemModelからItemに変換する
    final convertedItemLists = convertFromItemModelToItem(itemsProvider);
    //ここで取得したデータをsettingProviderの値を参照して並び替える
    return await sortItems(convertedItemLists);
  }

  Future<void> changeSortData(List<Item> itemLists) async {
    // ここでsettingProviderの値を参照して並び替える
    final sortListItems = await sortItems(itemLists);
    state = AsyncValue.data(sortListItems);
  }

  Future<void> allDeleteItem() async {
    try {
      await ref.read(itemsRepositoryProvider).deleteAllItems();
      state = const AsyncValue.data([]);
    } catch (e) {
      throw Exception(e);
    }
  }

  Future<void> deleteLimitoutItem() async {
    try {
      await ref.read(itemsRepositoryProvider).deleteLimitoutItem();
      if (state.value == null) return;
      final removeLimitOutItems =
          state.value!
              .where((e) => e.expirationDate.isAfter(DateTime.now()))
              .toList();
      state = AsyncValue.data(removeLimitOutItems);
    } catch (e) {
      throw Exception(e);
    }

    //final convertedItemLists = convertFromItemModelToItem(itemProvider);
    //final sortListItems = await sortItems(convertedItemLists);
  }

  Future<void> deleteItem(int itemId) async {
    try {
      // ここでデータを削除する
      await ref.read(itemsRepositoryProvider).deleteItem(itemId);
      if (state.value == null) return;

      //画面の削除するアイテムをListから外す
      final removedItems = state.value!.where((e) => e.id != itemId).toList();

      state = AsyncValue.data(removedItems);
      // ここで取得したデータをsettingProviderの値を参照して並び替える
      //final convertedItemLists = convertFromItemModelToItem(itemsProvider);
      //final sortListItems = await sortItems(convertedItemLists);

      //state = AsyncValue.data(sortListItems);
    } catch (e) {
      throw Exception(e);
    }
  }

  List<Item> convertFromItemModelToItem(List<ItemModel> itemModel) {
    return itemModel.map((itemModel) {
      final stringDate = fromDateTimeToString(itemModel.expirationDate);
      final dateRatio = getDateRatio(itemModel.expirationDate);
      return Item(
        id: itemModel.id,
        stringExpirationDate: stringDate,
        imagePath: itemModel.imagePath,
        expirationDate: itemModel.expirationDate,
        dateRatio: dateRatio,
      );
    }).toList();
  }

  String fromDateTimeToString(DateTime date) {
    final yy = date.year.toString().substring(2);
    if (date.day == 1) {
      return '$yy-${date.month}-上旬';
    } else if (date.day == 16) {
      return '$yy-${date.month}-下旬';
    }
    return '$yy-${date.month}-上旬';
  }

  //１年に対しての賞味期限の割合の計算
  double getDateRatio(DateTime dateTime) {
    final now = DateTime.now();
    final oneYearLater = DateTime(now.year, now.month + 6, now.day);
    if (dateTime.isBefore(now)) {
      return 0.0; // 期限切れの場合は0%
    } else if (dateTime.isAfter(oneYearLater)) {
      return 1.0; // 半年先の場合は100%
    } else {
      final totalDays = oneYearLater.difference(dateTime).inDays;
      debugPrint(totalDays.toString());
      final a = (183 / totalDays);
      debugPrint(a.toString());
      return 1 - (totalDays / 183);
    }
  }

  // 並び替えロジック
  Future<List<Item>> sortItems(List<Item> items) async {
    final settingvm = ref.read(settingPageViewModelProvider);
    return await settingvm.when(
      data: (order) {
        if (order.sortData == 'id') {
          // 登録順（ID昇順）
          items.sort((a, b) => a.id.compareTo(b.id));
        } else if (order.sortData == 'expirationDate') {
          // 期限順（賞味期限が近い順）
          items.sort((a, b) {
            return a.expirationDate.compareTo(b.expirationDate);
          });
        }
        return items;
      },
      loading: () => items,
      error: (error, stackTrace) => items,
    );
  }

  Color getDateRatioColor(double dateRatio) {
    debugPrint(dateRatio.toString());
    if (dateRatio <= 0.2) {
      return const Color.fromARGB(255, 254, 91, 91); // 赤色
    } else if (dateRatio < 0.4) {
      return const Color.fromARGB(255, 251, 251, 125); // 黄色
    } else {
      return const Color.fromARGB(255, 176, 255, 176); // 緑色
    }
  }

  String showDate() {
    const weekNum = ['月', '火', '水', '木', '金', '土', '日'];
    final now = DateTime.now();
    return '${now.year}年${now.month}月${now.day}日(${weekNum[now.weekday - 1]})';
  }
}

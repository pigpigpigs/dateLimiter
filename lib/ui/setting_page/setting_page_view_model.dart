import 'package:flutter/cupertino.dart';
import 'package:food_limmit_controller/data/repository/item/IF_item_repository_provider.dart';
import 'package:food_limmit_controller/data/repository/shared_preferences/IF_shared_preferences_repository_provider.dart';
import 'package:food_limmit_controller/domain/model/setting/setting.dart';
import 'package:food_limmit_controller/ui/main_page/view_model/main_page_view_model.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'setting_page_view_model.g.dart';

@riverpod
class SettingPageViewModel extends _$SettingPageViewModel {
  @override
  Future<Setting> build() async {
    return await initSetting();
  }

  Future<Setting> initSetting() async {
    final settingDataModel =
        await ref.read(sharedPreferencesRepositoryProvider).getSettingData();
    return Setting(
      sortData: settingDataModel.sortData ?? 'id',
      isNotification: settingDataModel.isNotification ?? false,
    );
  }

  Future<void> changeSort(String stringSortData) async {
    final itemLists = ref.read(mainPageViewModelProvider).value;
    late Setting newSetting;
    final settingState = state;
    settingState.whenData((setting) {
      newSetting = setting.copyWith(sortData: stringSortData);
      state = AsyncValue.data(newSetting);
    });
    await ref
        .read(sharedPreferencesRepositoryProvider)
        .setSettingData(newSetting);
    await ref
        .read(mainPageViewModelProvider.notifier)
        .changeSortData(itemLists!);
  }

  Future<void> changeNotification(bool isNotification) async {
    late Setting newSetting;
    final settingState = state;
    settingState.whenData((setting) {
      newSetting = setting.copyWith(isNotification: isNotification);
      state = AsyncValue.data(newSetting);
    });
    await ref
        .read(sharedPreferencesRepositoryProvider)
        .setSettingData(newSetting);
  }

  Future<void> pushAllDeleteButtom() async {
    await ref.read(mainPageViewModelProvider.notifier).allDeleteItem();
  }

  Future<void> pushDeleteLimitoutItemButton() async {
    await ref.read(mainPageViewModelProvider.notifier).deleteLimitoutItem();
  }
}

import 'package:food_limmit_controller/data/repository/shared_preferences/IF_shared_preferences_repository.dart';
import 'package:food_limmit_controller/data/service/model/setting/setting_model.dart';
import 'package:food_limmit_controller/data/service/shared_preferences/shared_preferences.dart';
import 'package:food_limmit_controller/domain/model/setting/setting.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:shared_preferences/shared_preferences.dart';

const String settingSortKey = 'sort';
const String settingNotificationKey = 'notification';

class SharedPreferencesRepository implements IFSharedPreferencesRepository {
  SharedPreferencesRepository(this.prefs);

  final SharedPreferencesAsync prefs;

  //設定の取得
  @override
  Future<SettingModel> getSettingData() async {
    final getSortSetting = await prefs.getString(settingSortKey);
    final getNotificationSetting = await prefs.getBool(settingNotificationKey);

    return SettingModel(
      sortData: getSortSetting,
      isNotification: getNotificationSetting,
    );
  }

  // 設定を保存する
  @override
  Future<SettingModel> setSettingData(Setting setting) async {
    final settingModel = fromSetting(setting);
    if (settingModel.sortData == null && settingModel.isNotification == null) {
      //nullの場合はreturn
      return settingModel;
    }
    SharedPreferencesAsync asyncPrefs = SharedPreferencesAsync();
    await asyncPrefs.setString(settingSortKey, settingModel.sortData!);
    await asyncPrefs.setBool(
      settingNotificationKey,
      settingModel.isNotification!,
    );
    return SettingModel(
      sortData: settingModel.sortData,
      isNotification: settingModel.isNotification,
    );
  }

  SettingModel fromSetting(Setting setting) {
    return SettingModel(
      sortData: setting.sortData,
      isNotification: setting.isNotification,
    );
  }
}

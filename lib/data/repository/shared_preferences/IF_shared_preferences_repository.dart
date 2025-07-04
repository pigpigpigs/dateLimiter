import 'package:food_limmit_controller/data/service/model/setting/setting_model.dart';
import 'package:food_limmit_controller/domain/model/setting/setting.dart';

abstract class IFSharedPreferencesRepository {
  Future<SettingModel> getSettingData();
  Future<SettingModel> setSettingData(Setting setting);
}

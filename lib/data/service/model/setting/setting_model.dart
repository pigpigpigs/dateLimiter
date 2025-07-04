import 'package:freezed_annotation/freezed_annotation.dart';

part 'setting_model.freezed.dart';

@freezed
abstract class SettingModel with _$SettingModel {
  const factory SettingModel({
    required String? sortData,
    required bool? isNotification,
  }) = _SettingModel;
}

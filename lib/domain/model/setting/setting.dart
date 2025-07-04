import 'package:freezed_annotation/freezed_annotation.dart';

part 'setting.freezed.dart';

@freezed
abstract class Setting with _$Setting {
  const factory Setting({
    required String sortData,
    required bool isNotification,
  }) = _Setting;
}
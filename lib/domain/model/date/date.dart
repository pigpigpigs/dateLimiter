import 'package:freezed_annotation/freezed_annotation.dart';

part 'date.freezed.dart';

@freezed
abstract class Date with _$Date {
  const factory Date({
    required String year,
    required String month,
    required String day,
  }) = _Date;
}
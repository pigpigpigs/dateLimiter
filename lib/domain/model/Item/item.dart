import 'package:freezed_annotation/freezed_annotation.dart';

part 'item.freezed.dart';

@freezed
abstract class Item with _$Item {
  const factory Item({
    required int id,
    required String imagePath,
    required String stringExpirationDate,
    required DateTime expirationDate,
    required double dateRatio,
  }) = _Item;
}

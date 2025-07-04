import 'package:freezed_annotation/freezed_annotation.dart';

part 'insert_item.freezed.dart';

@freezed
abstract class InsertItem with _$InsertItem {
  const factory InsertItem({
    required String imagePath,
    required DateTime expirationDate,
  }) = _InsertItem;
}

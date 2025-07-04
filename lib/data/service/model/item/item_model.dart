import 'package:freezed_annotation/freezed_annotation.dart';

part 'item_model.freezed.dart';

@freezed
abstract class ItemModel with _$ItemModel {
  const factory ItemModel({
    required int id,
    required DateTime expirationDate,
    required String imagePath,
  }) = _ItemModel;
}

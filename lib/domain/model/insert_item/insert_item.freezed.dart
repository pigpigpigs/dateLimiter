// dart format width=80
// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'insert_item.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$InsertItem {

 String get imagePath; DateTime get expirationDate;
/// Create a copy of InsertItem
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$InsertItemCopyWith<InsertItem> get copyWith => _$InsertItemCopyWithImpl<InsertItem>(this as InsertItem, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is InsertItem&&(identical(other.imagePath, imagePath) || other.imagePath == imagePath)&&(identical(other.expirationDate, expirationDate) || other.expirationDate == expirationDate));
}


@override
int get hashCode => Object.hash(runtimeType,imagePath,expirationDate);

@override
String toString() {
  return 'InsertItem(imagePath: $imagePath, expirationDate: $expirationDate)';
}


}

/// @nodoc
abstract mixin class $InsertItemCopyWith<$Res>  {
  factory $InsertItemCopyWith(InsertItem value, $Res Function(InsertItem) _then) = _$InsertItemCopyWithImpl;
@useResult
$Res call({
 String imagePath, DateTime expirationDate
});




}
/// @nodoc
class _$InsertItemCopyWithImpl<$Res>
    implements $InsertItemCopyWith<$Res> {
  _$InsertItemCopyWithImpl(this._self, this._then);

  final InsertItem _self;
  final $Res Function(InsertItem) _then;

/// Create a copy of InsertItem
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? imagePath = null,Object? expirationDate = null,}) {
  return _then(_self.copyWith(
imagePath: null == imagePath ? _self.imagePath : imagePath // ignore: cast_nullable_to_non_nullable
as String,expirationDate: null == expirationDate ? _self.expirationDate : expirationDate // ignore: cast_nullable_to_non_nullable
as DateTime,
  ));
}

}


/// @nodoc


class _InsertItem implements InsertItem {
  const _InsertItem({required this.imagePath, required this.expirationDate});
  

@override final  String imagePath;
@override final  DateTime expirationDate;

/// Create a copy of InsertItem
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$InsertItemCopyWith<_InsertItem> get copyWith => __$InsertItemCopyWithImpl<_InsertItem>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _InsertItem&&(identical(other.imagePath, imagePath) || other.imagePath == imagePath)&&(identical(other.expirationDate, expirationDate) || other.expirationDate == expirationDate));
}


@override
int get hashCode => Object.hash(runtimeType,imagePath,expirationDate);

@override
String toString() {
  return 'InsertItem(imagePath: $imagePath, expirationDate: $expirationDate)';
}


}

/// @nodoc
abstract mixin class _$InsertItemCopyWith<$Res> implements $InsertItemCopyWith<$Res> {
  factory _$InsertItemCopyWith(_InsertItem value, $Res Function(_InsertItem) _then) = __$InsertItemCopyWithImpl;
@override @useResult
$Res call({
 String imagePath, DateTime expirationDate
});




}
/// @nodoc
class __$InsertItemCopyWithImpl<$Res>
    implements _$InsertItemCopyWith<$Res> {
  __$InsertItemCopyWithImpl(this._self, this._then);

  final _InsertItem _self;
  final $Res Function(_InsertItem) _then;

/// Create a copy of InsertItem
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? imagePath = null,Object? expirationDate = null,}) {
  return _then(_InsertItem(
imagePath: null == imagePath ? _self.imagePath : imagePath // ignore: cast_nullable_to_non_nullable
as String,expirationDate: null == expirationDate ? _self.expirationDate : expirationDate // ignore: cast_nullable_to_non_nullable
as DateTime,
  ));
}


}

// dart format on

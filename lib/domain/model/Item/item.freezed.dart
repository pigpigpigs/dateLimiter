// dart format width=80
// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'item.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$Item {

 int get id; String get imagePath; String get stringExpirationDate; DateTime get expirationDate; double get dateRatio;
/// Create a copy of Item
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ItemCopyWith<Item> get copyWith => _$ItemCopyWithImpl<Item>(this as Item, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is Item&&(identical(other.id, id) || other.id == id)&&(identical(other.imagePath, imagePath) || other.imagePath == imagePath)&&(identical(other.stringExpirationDate, stringExpirationDate) || other.stringExpirationDate == stringExpirationDate)&&(identical(other.expirationDate, expirationDate) || other.expirationDate == expirationDate)&&(identical(other.dateRatio, dateRatio) || other.dateRatio == dateRatio));
}


@override
int get hashCode => Object.hash(runtimeType,id,imagePath,stringExpirationDate,expirationDate,dateRatio);

@override
String toString() {
  return 'Item(id: $id, imagePath: $imagePath, stringExpirationDate: $stringExpirationDate, expirationDate: $expirationDate, dateRatio: $dateRatio)';
}


}

/// @nodoc
abstract mixin class $ItemCopyWith<$Res>  {
  factory $ItemCopyWith(Item value, $Res Function(Item) _then) = _$ItemCopyWithImpl;
@useResult
$Res call({
 int id, String imagePath, String stringExpirationDate, DateTime expirationDate, double dateRatio
});




}
/// @nodoc
class _$ItemCopyWithImpl<$Res>
    implements $ItemCopyWith<$Res> {
  _$ItemCopyWithImpl(this._self, this._then);

  final Item _self;
  final $Res Function(Item) _then;

/// Create a copy of Item
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? imagePath = null,Object? stringExpirationDate = null,Object? expirationDate = null,Object? dateRatio = null,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as int,imagePath: null == imagePath ? _self.imagePath : imagePath // ignore: cast_nullable_to_non_nullable
as String,stringExpirationDate: null == stringExpirationDate ? _self.stringExpirationDate : stringExpirationDate // ignore: cast_nullable_to_non_nullable
as String,expirationDate: null == expirationDate ? _self.expirationDate : expirationDate // ignore: cast_nullable_to_non_nullable
as DateTime,dateRatio: null == dateRatio ? _self.dateRatio : dateRatio // ignore: cast_nullable_to_non_nullable
as double,
  ));
}

}


/// @nodoc


class _Item implements Item {
  const _Item({required this.id, required this.imagePath, required this.stringExpirationDate, required this.expirationDate, required this.dateRatio});
  

@override final  int id;
@override final  String imagePath;
@override final  String stringExpirationDate;
@override final  DateTime expirationDate;
@override final  double dateRatio;

/// Create a copy of Item
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$ItemCopyWith<_Item> get copyWith => __$ItemCopyWithImpl<_Item>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _Item&&(identical(other.id, id) || other.id == id)&&(identical(other.imagePath, imagePath) || other.imagePath == imagePath)&&(identical(other.stringExpirationDate, stringExpirationDate) || other.stringExpirationDate == stringExpirationDate)&&(identical(other.expirationDate, expirationDate) || other.expirationDate == expirationDate)&&(identical(other.dateRatio, dateRatio) || other.dateRatio == dateRatio));
}


@override
int get hashCode => Object.hash(runtimeType,id,imagePath,stringExpirationDate,expirationDate,dateRatio);

@override
String toString() {
  return 'Item(id: $id, imagePath: $imagePath, stringExpirationDate: $stringExpirationDate, expirationDate: $expirationDate, dateRatio: $dateRatio)';
}


}

/// @nodoc
abstract mixin class _$ItemCopyWith<$Res> implements $ItemCopyWith<$Res> {
  factory _$ItemCopyWith(_Item value, $Res Function(_Item) _then) = __$ItemCopyWithImpl;
@override @useResult
$Res call({
 int id, String imagePath, String stringExpirationDate, DateTime expirationDate, double dateRatio
});




}
/// @nodoc
class __$ItemCopyWithImpl<$Res>
    implements _$ItemCopyWith<$Res> {
  __$ItemCopyWithImpl(this._self, this._then);

  final _Item _self;
  final $Res Function(_Item) _then;

/// Create a copy of Item
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? imagePath = null,Object? stringExpirationDate = null,Object? expirationDate = null,Object? dateRatio = null,}) {
  return _then(_Item(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as int,imagePath: null == imagePath ? _self.imagePath : imagePath // ignore: cast_nullable_to_non_nullable
as String,stringExpirationDate: null == stringExpirationDate ? _self.stringExpirationDate : stringExpirationDate // ignore: cast_nullable_to_non_nullable
as String,expirationDate: null == expirationDate ? _self.expirationDate : expirationDate // ignore: cast_nullable_to_non_nullable
as DateTime,dateRatio: null == dateRatio ? _self.dateRatio : dateRatio // ignore: cast_nullable_to_non_nullable
as double,
  ));
}


}

// dart format on

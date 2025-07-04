// dart format width=80
// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'setting.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$Setting {

 String get sortData; bool get isNotification;
/// Create a copy of Setting
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$SettingCopyWith<Setting> get copyWith => _$SettingCopyWithImpl<Setting>(this as Setting, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is Setting&&(identical(other.sortData, sortData) || other.sortData == sortData)&&(identical(other.isNotification, isNotification) || other.isNotification == isNotification));
}


@override
int get hashCode => Object.hash(runtimeType,sortData,isNotification);

@override
String toString() {
  return 'Setting(sortData: $sortData, isNotification: $isNotification)';
}


}

/// @nodoc
abstract mixin class $SettingCopyWith<$Res>  {
  factory $SettingCopyWith(Setting value, $Res Function(Setting) _then) = _$SettingCopyWithImpl;
@useResult
$Res call({
 String sortData, bool isNotification
});




}
/// @nodoc
class _$SettingCopyWithImpl<$Res>
    implements $SettingCopyWith<$Res> {
  _$SettingCopyWithImpl(this._self, this._then);

  final Setting _self;
  final $Res Function(Setting) _then;

/// Create a copy of Setting
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? sortData = null,Object? isNotification = null,}) {
  return _then(_self.copyWith(
sortData: null == sortData ? _self.sortData : sortData // ignore: cast_nullable_to_non_nullable
as String,isNotification: null == isNotification ? _self.isNotification : isNotification // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}

}


/// @nodoc


class _Setting implements Setting {
  const _Setting({required this.sortData, required this.isNotification});
  

@override final  String sortData;
@override final  bool isNotification;

/// Create a copy of Setting
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$SettingCopyWith<_Setting> get copyWith => __$SettingCopyWithImpl<_Setting>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _Setting&&(identical(other.sortData, sortData) || other.sortData == sortData)&&(identical(other.isNotification, isNotification) || other.isNotification == isNotification));
}


@override
int get hashCode => Object.hash(runtimeType,sortData,isNotification);

@override
String toString() {
  return 'Setting(sortData: $sortData, isNotification: $isNotification)';
}


}

/// @nodoc
abstract mixin class _$SettingCopyWith<$Res> implements $SettingCopyWith<$Res> {
  factory _$SettingCopyWith(_Setting value, $Res Function(_Setting) _then) = __$SettingCopyWithImpl;
@override @useResult
$Res call({
 String sortData, bool isNotification
});




}
/// @nodoc
class __$SettingCopyWithImpl<$Res>
    implements _$SettingCopyWith<$Res> {
  __$SettingCopyWithImpl(this._self, this._then);

  final _Setting _self;
  final $Res Function(_Setting) _then;

/// Create a copy of Setting
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? sortData = null,Object? isNotification = null,}) {
  return _then(_Setting(
sortData: null == sortData ? _self.sortData : sortData // ignore: cast_nullable_to_non_nullable
as String,isNotification: null == isNotification ? _self.isNotification : isNotification // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}


}

// dart format on

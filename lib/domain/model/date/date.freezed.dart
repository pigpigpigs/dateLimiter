// dart format width=80
// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'date.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$Date {

 String get year; String get month; String get day;
/// Create a copy of Date
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$DateCopyWith<Date> get copyWith => _$DateCopyWithImpl<Date>(this as Date, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is Date&&(identical(other.year, year) || other.year == year)&&(identical(other.month, month) || other.month == month)&&(identical(other.day, day) || other.day == day));
}


@override
int get hashCode => Object.hash(runtimeType,year,month,day);

@override
String toString() {
  return 'Date(year: $year, month: $month, day: $day)';
}


}

/// @nodoc
abstract mixin class $DateCopyWith<$Res>  {
  factory $DateCopyWith(Date value, $Res Function(Date) _then) = _$DateCopyWithImpl;
@useResult
$Res call({
 String year, String month, String day
});




}
/// @nodoc
class _$DateCopyWithImpl<$Res>
    implements $DateCopyWith<$Res> {
  _$DateCopyWithImpl(this._self, this._then);

  final Date _self;
  final $Res Function(Date) _then;

/// Create a copy of Date
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? year = null,Object? month = null,Object? day = null,}) {
  return _then(_self.copyWith(
year: null == year ? _self.year : year // ignore: cast_nullable_to_non_nullable
as String,month: null == month ? _self.month : month // ignore: cast_nullable_to_non_nullable
as String,day: null == day ? _self.day : day // ignore: cast_nullable_to_non_nullable
as String,
  ));
}

}


/// @nodoc


class _Date implements Date {
  const _Date({required this.year, required this.month, required this.day});
  

@override final  String year;
@override final  String month;
@override final  String day;

/// Create a copy of Date
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$DateCopyWith<_Date> get copyWith => __$DateCopyWithImpl<_Date>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _Date&&(identical(other.year, year) || other.year == year)&&(identical(other.month, month) || other.month == month)&&(identical(other.day, day) || other.day == day));
}


@override
int get hashCode => Object.hash(runtimeType,year,month,day);

@override
String toString() {
  return 'Date(year: $year, month: $month, day: $day)';
}


}

/// @nodoc
abstract mixin class _$DateCopyWith<$Res> implements $DateCopyWith<$Res> {
  factory _$DateCopyWith(_Date value, $Res Function(_Date) _then) = __$DateCopyWithImpl;
@override @useResult
$Res call({
 String year, String month, String day
});




}
/// @nodoc
class __$DateCopyWithImpl<$Res>
    implements _$DateCopyWith<$Res> {
  __$DateCopyWithImpl(this._self, this._then);

  final _Date _self;
  final $Res Function(_Date) _then;

/// Create a copy of Date
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? year = null,Object? month = null,Object? day = null,}) {
  return _then(_Date(
year: null == year ? _self.year : year // ignore: cast_nullable_to_non_nullable
as String,month: null == month ? _self.month : month // ignore: cast_nullable_to_non_nullable
as String,day: null == day ? _self.day : day // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

// dart format on

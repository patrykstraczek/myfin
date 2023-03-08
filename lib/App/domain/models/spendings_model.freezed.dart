// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'spendings_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

/// @nodoc
mixin _$SpendingsModel {
  String get id => throw _privateConstructorUsedError;
  String get spendingName => throw _privateConstructorUsedError;
  double get spendingValue => throw _privateConstructorUsedError;
  DateTime get spendingDate => throw _privateConstructorUsedError;
  int get selectedSpendingIcon => throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $SpendingsModelCopyWith<SpendingsModel> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $SpendingsModelCopyWith<$Res> {
  factory $SpendingsModelCopyWith(
          SpendingsModel value, $Res Function(SpendingsModel) then) =
      _$SpendingsModelCopyWithImpl<$Res, SpendingsModel>;
  @useResult
  $Res call(
      {String id,
      String spendingName,
      double spendingValue,
      DateTime spendingDate,
      int selectedSpendingIcon});
}

/// @nodoc
class _$SpendingsModelCopyWithImpl<$Res, $Val extends SpendingsModel>
    implements $SpendingsModelCopyWith<$Res> {
  _$SpendingsModelCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? spendingName = null,
    Object? spendingValue = null,
    Object? spendingDate = null,
    Object? selectedSpendingIcon = null,
  }) {
    return _then(_value.copyWith(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      spendingName: null == spendingName
          ? _value.spendingName
          : spendingName // ignore: cast_nullable_to_non_nullable
              as String,
      spendingValue: null == spendingValue
          ? _value.spendingValue
          : spendingValue // ignore: cast_nullable_to_non_nullable
              as double,
      spendingDate: null == spendingDate
          ? _value.spendingDate
          : spendingDate // ignore: cast_nullable_to_non_nullable
              as DateTime,
      selectedSpendingIcon: null == selectedSpendingIcon
          ? _value.selectedSpendingIcon
          : selectedSpendingIcon // ignore: cast_nullable_to_non_nullable
              as int,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$_SpendingsModelCopyWith<$Res>
    implements $SpendingsModelCopyWith<$Res> {
  factory _$$_SpendingsModelCopyWith(
          _$_SpendingsModel value, $Res Function(_$_SpendingsModel) then) =
      __$$_SpendingsModelCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String id,
      String spendingName,
      double spendingValue,
      DateTime spendingDate,
      int selectedSpendingIcon});
}

/// @nodoc
class __$$_SpendingsModelCopyWithImpl<$Res>
    extends _$SpendingsModelCopyWithImpl<$Res, _$_SpendingsModel>
    implements _$$_SpendingsModelCopyWith<$Res> {
  __$$_SpendingsModelCopyWithImpl(
      _$_SpendingsModel _value, $Res Function(_$_SpendingsModel) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? spendingName = null,
    Object? spendingValue = null,
    Object? spendingDate = null,
    Object? selectedSpendingIcon = null,
  }) {
    return _then(_$_SpendingsModel(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      spendingName: null == spendingName
          ? _value.spendingName
          : spendingName // ignore: cast_nullable_to_non_nullable
              as String,
      spendingValue: null == spendingValue
          ? _value.spendingValue
          : spendingValue // ignore: cast_nullable_to_non_nullable
              as double,
      spendingDate: null == spendingDate
          ? _value.spendingDate
          : spendingDate // ignore: cast_nullable_to_non_nullable
              as DateTime,
      selectedSpendingIcon: null == selectedSpendingIcon
          ? _value.selectedSpendingIcon
          : selectedSpendingIcon // ignore: cast_nullable_to_non_nullable
              as int,
    ));
  }
}

/// @nodoc

class _$_SpendingsModel implements _SpendingsModel {
  _$_SpendingsModel(
      {required this.id,
      required this.spendingName,
      required this.spendingValue,
      required this.spendingDate,
      required this.selectedSpendingIcon});

  @override
  final String id;
  @override
  final String spendingName;
  @override
  final double spendingValue;
  @override
  final DateTime spendingDate;
  @override
  final int selectedSpendingIcon;

  @override
  String toString() {
    return 'SpendingsModel(id: $id, spendingName: $spendingName, spendingValue: $spendingValue, spendingDate: $spendingDate, selectedSpendingIcon: $selectedSpendingIcon)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_SpendingsModel &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.spendingName, spendingName) ||
                other.spendingName == spendingName) &&
            (identical(other.spendingValue, spendingValue) ||
                other.spendingValue == spendingValue) &&
            (identical(other.spendingDate, spendingDate) ||
                other.spendingDate == spendingDate) &&
            (identical(other.selectedSpendingIcon, selectedSpendingIcon) ||
                other.selectedSpendingIcon == selectedSpendingIcon));
  }

  @override
  int get hashCode => Object.hash(runtimeType, id, spendingName, spendingValue,
      spendingDate, selectedSpendingIcon);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_SpendingsModelCopyWith<_$_SpendingsModel> get copyWith =>
      __$$_SpendingsModelCopyWithImpl<_$_SpendingsModel>(this, _$identity);
}

abstract class _SpendingsModel implements SpendingsModel {
  factory _SpendingsModel(
      {required final String id,
      required final String spendingName,
      required final double spendingValue,
      required final DateTime spendingDate,
      required final int selectedSpendingIcon}) = _$_SpendingsModel;

  @override
  String get id;
  @override
  String get spendingName;
  @override
  double get spendingValue;
  @override
  DateTime get spendingDate;
  @override
  int get selectedSpendingIcon;
  @override
  @JsonKey(ignore: true)
  _$$_SpendingsModelCopyWith<_$_SpendingsModel> get copyWith =>
      throw _privateConstructorUsedError;
}

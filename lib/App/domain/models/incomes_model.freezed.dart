// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'incomes_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

/// @nodoc
mixin _$IncomesModel {
  String get id => throw _privateConstructorUsedError;
  String get incomeName => throw _privateConstructorUsedError;
  double get incomeValue => throw _privateConstructorUsedError;
  DateTime get incomeDate => throw _privateConstructorUsedError;
  int get selectedIncomesIcon => throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $IncomesModelCopyWith<IncomesModel> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $IncomesModelCopyWith<$Res> {
  factory $IncomesModelCopyWith(
          IncomesModel value, $Res Function(IncomesModel) then) =
      _$IncomesModelCopyWithImpl<$Res, IncomesModel>;
  @useResult
  $Res call(
      {String id,
      String incomeName,
      double incomeValue,
      DateTime incomeDate,
      int selectedIncomesIcon});
}

/// @nodoc
class _$IncomesModelCopyWithImpl<$Res, $Val extends IncomesModel>
    implements $IncomesModelCopyWith<$Res> {
  _$IncomesModelCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? incomeName = null,
    Object? incomeValue = null,
    Object? incomeDate = null,
    Object? selectedIncomesIcon = null,
  }) {
    return _then(_value.copyWith(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      incomeName: null == incomeName
          ? _value.incomeName
          : incomeName // ignore: cast_nullable_to_non_nullable
              as String,
      incomeValue: null == incomeValue
          ? _value.incomeValue
          : incomeValue // ignore: cast_nullable_to_non_nullable
              as double,
      incomeDate: null == incomeDate
          ? _value.incomeDate
          : incomeDate // ignore: cast_nullable_to_non_nullable
              as DateTime,
      selectedIncomesIcon: null == selectedIncomesIcon
          ? _value.selectedIncomesIcon
          : selectedIncomesIcon // ignore: cast_nullable_to_non_nullable
              as int,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$_IncomesModelCopyWith<$Res>
    implements $IncomesModelCopyWith<$Res> {
  factory _$$_IncomesModelCopyWith(
          _$_IncomesModel value, $Res Function(_$_IncomesModel) then) =
      __$$_IncomesModelCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String id,
      String incomeName,
      double incomeValue,
      DateTime incomeDate,
      int selectedIncomesIcon});
}

/// @nodoc
class __$$_IncomesModelCopyWithImpl<$Res>
    extends _$IncomesModelCopyWithImpl<$Res, _$_IncomesModel>
    implements _$$_IncomesModelCopyWith<$Res> {
  __$$_IncomesModelCopyWithImpl(
      _$_IncomesModel _value, $Res Function(_$_IncomesModel) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? incomeName = null,
    Object? incomeValue = null,
    Object? incomeDate = null,
    Object? selectedIncomesIcon = null,
  }) {
    return _then(_$_IncomesModel(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      incomeName: null == incomeName
          ? _value.incomeName
          : incomeName // ignore: cast_nullable_to_non_nullable
              as String,
      incomeValue: null == incomeValue
          ? _value.incomeValue
          : incomeValue // ignore: cast_nullable_to_non_nullable
              as double,
      incomeDate: null == incomeDate
          ? _value.incomeDate
          : incomeDate // ignore: cast_nullable_to_non_nullable
              as DateTime,
      selectedIncomesIcon: null == selectedIncomesIcon
          ? _value.selectedIncomesIcon
          : selectedIncomesIcon // ignore: cast_nullable_to_non_nullable
              as int,
    ));
  }
}

/// @nodoc

class _$_IncomesModel implements _IncomesModel {
  _$_IncomesModel(
      {required this.id,
      required this.incomeName,
      required this.incomeValue,
      required this.incomeDate,
      required this.selectedIncomesIcon});

  @override
  final String id;
  @override
  final String incomeName;
  @override
  final double incomeValue;
  @override
  final DateTime incomeDate;
  @override
  final int selectedIncomesIcon;

  @override
  String toString() {
    return 'IncomesModel(id: $id, incomeName: $incomeName, incomeValue: $incomeValue, incomeDate: $incomeDate, selectedIncomesIcon: $selectedIncomesIcon)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_IncomesModel &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.incomeName, incomeName) ||
                other.incomeName == incomeName) &&
            (identical(other.incomeValue, incomeValue) ||
                other.incomeValue == incomeValue) &&
            (identical(other.incomeDate, incomeDate) ||
                other.incomeDate == incomeDate) &&
            (identical(other.selectedIncomesIcon, selectedIncomesIcon) ||
                other.selectedIncomesIcon == selectedIncomesIcon));
  }

  @override
  int get hashCode => Object.hash(runtimeType, id, incomeName, incomeValue,
      incomeDate, selectedIncomesIcon);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_IncomesModelCopyWith<_$_IncomesModel> get copyWith =>
      __$$_IncomesModelCopyWithImpl<_$_IncomesModel>(this, _$identity);
}

abstract class _IncomesModel implements IncomesModel {
  factory _IncomesModel(
      {required final String id,
      required final String incomeName,
      required final double incomeValue,
      required final DateTime incomeDate,
      required final int selectedIncomesIcon}) = _$_IncomesModel;

  @override
  String get id;
  @override
  String get incomeName;
  @override
  double get incomeValue;
  @override
  DateTime get incomeDate;
  @override
  int get selectedIncomesIcon;
  @override
  @JsonKey(ignore: true)
  _$$_IncomesModelCopyWith<_$_IncomesModel> get copyWith =>
      throw _privateConstructorUsedError;
}

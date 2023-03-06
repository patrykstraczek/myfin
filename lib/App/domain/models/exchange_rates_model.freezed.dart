// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'exchange_rates_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

ExchangeRatesModel _$ExchangeRatesModelFromJson(Map<String, dynamic> json) {
  return _ExchangeRatesModel.fromJson(json);
}

/// @nodoc
mixin _$ExchangeRatesModel {
  String get code => throw _privateConstructorUsedError;
  @JsonKey(name: 'mid')
  double get averageRate => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $ExchangeRatesModelCopyWith<ExchangeRatesModel> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ExchangeRatesModelCopyWith<$Res> {
  factory $ExchangeRatesModelCopyWith(
          ExchangeRatesModel value, $Res Function(ExchangeRatesModel) then) =
      _$ExchangeRatesModelCopyWithImpl<$Res, ExchangeRatesModel>;
  @useResult
  $Res call({String code, @JsonKey(name: 'mid') double averageRate});
}

/// @nodoc
class _$ExchangeRatesModelCopyWithImpl<$Res, $Val extends ExchangeRatesModel>
    implements $ExchangeRatesModelCopyWith<$Res> {
  _$ExchangeRatesModelCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? code = null,
    Object? averageRate = null,
  }) {
    return _then(_value.copyWith(
      code: null == code
          ? _value.code
          : code // ignore: cast_nullable_to_non_nullable
              as String,
      averageRate: null == averageRate
          ? _value.averageRate
          : averageRate // ignore: cast_nullable_to_non_nullable
              as double,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$_ExchangeRatesModelCopyWith<$Res>
    implements $ExchangeRatesModelCopyWith<$Res> {
  factory _$$_ExchangeRatesModelCopyWith(_$_ExchangeRatesModel value,
          $Res Function(_$_ExchangeRatesModel) then) =
      __$$_ExchangeRatesModelCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String code, @JsonKey(name: 'mid') double averageRate});
}

/// @nodoc
class __$$_ExchangeRatesModelCopyWithImpl<$Res>
    extends _$ExchangeRatesModelCopyWithImpl<$Res, _$_ExchangeRatesModel>
    implements _$$_ExchangeRatesModelCopyWith<$Res> {
  __$$_ExchangeRatesModelCopyWithImpl(
      _$_ExchangeRatesModel _value, $Res Function(_$_ExchangeRatesModel) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? code = null,
    Object? averageRate = null,
  }) {
    return _then(_$_ExchangeRatesModel(
      null == code
          ? _value.code
          : code // ignore: cast_nullable_to_non_nullable
              as String,
      null == averageRate
          ? _value.averageRate
          : averageRate // ignore: cast_nullable_to_non_nullable
              as double,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$_ExchangeRatesModel implements _ExchangeRatesModel {
  _$_ExchangeRatesModel(this.code, @JsonKey(name: 'mid') this.averageRate);

  factory _$_ExchangeRatesModel.fromJson(Map<String, dynamic> json) =>
      _$$_ExchangeRatesModelFromJson(json);

  @override
  final String code;
  @override
  @JsonKey(name: 'mid')
  final double averageRate;

  @override
  String toString() {
    return 'ExchangeRatesModel(code: $code, averageRate: $averageRate)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_ExchangeRatesModel &&
            (identical(other.code, code) || other.code == code) &&
            (identical(other.averageRate, averageRate) ||
                other.averageRate == averageRate));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, code, averageRate);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_ExchangeRatesModelCopyWith<_$_ExchangeRatesModel> get copyWith =>
      __$$_ExchangeRatesModelCopyWithImpl<_$_ExchangeRatesModel>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$_ExchangeRatesModelToJson(
      this,
    );
  }
}

abstract class _ExchangeRatesModel implements ExchangeRatesModel {
  factory _ExchangeRatesModel(
          final String code, @JsonKey(name: 'mid') final double averageRate) =
      _$_ExchangeRatesModel;

  factory _ExchangeRatesModel.fromJson(Map<String, dynamic> json) =
      _$_ExchangeRatesModel.fromJson;

  @override
  String get code;
  @override
  @JsonKey(name: 'mid')
  double get averageRate;
  @override
  @JsonKey(ignore: true)
  _$$_ExchangeRatesModelCopyWith<_$_ExchangeRatesModel> get copyWith =>
      throw _privateConstructorUsedError;
}

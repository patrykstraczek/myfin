// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'api_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

ApiModel _$ApiModelFromJson(Map<String, dynamic> json) {
  return _ApiModel.fromJson(json);
}

/// @nodoc
mixin _$ApiModel {
  String get table => throw _privateConstructorUsedError;
  String get no => throw _privateConstructorUsedError;
  String get effectiveDate => throw _privateConstructorUsedError;
  List<ExchangeRatesModel> get rates => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $ApiModelCopyWith<ApiModel> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ApiModelCopyWith<$Res> {
  factory $ApiModelCopyWith(ApiModel value, $Res Function(ApiModel) then) =
      _$ApiModelCopyWithImpl<$Res, ApiModel>;
  @useResult
  $Res call(
      {String table,
      String no,
      String effectiveDate,
      List<ExchangeRatesModel> rates});
}

/// @nodoc
class _$ApiModelCopyWithImpl<$Res, $Val extends ApiModel>
    implements $ApiModelCopyWith<$Res> {
  _$ApiModelCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? table = null,
    Object? no = null,
    Object? effectiveDate = null,
    Object? rates = null,
  }) {
    return _then(_value.copyWith(
      table: null == table
          ? _value.table
          : table // ignore: cast_nullable_to_non_nullable
              as String,
      no: null == no
          ? _value.no
          : no // ignore: cast_nullable_to_non_nullable
              as String,
      effectiveDate: null == effectiveDate
          ? _value.effectiveDate
          : effectiveDate // ignore: cast_nullable_to_non_nullable
              as String,
      rates: null == rates
          ? _value.rates
          : rates // ignore: cast_nullable_to_non_nullable
              as List<ExchangeRatesModel>,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$_ApiModelCopyWith<$Res> implements $ApiModelCopyWith<$Res> {
  factory _$$_ApiModelCopyWith(
          _$_ApiModel value, $Res Function(_$_ApiModel) then) =
      __$$_ApiModelCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String table,
      String no,
      String effectiveDate,
      List<ExchangeRatesModel> rates});
}

/// @nodoc
class __$$_ApiModelCopyWithImpl<$Res>
    extends _$ApiModelCopyWithImpl<$Res, _$_ApiModel>
    implements _$$_ApiModelCopyWith<$Res> {
  __$$_ApiModelCopyWithImpl(
      _$_ApiModel _value, $Res Function(_$_ApiModel) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? table = null,
    Object? no = null,
    Object? effectiveDate = null,
    Object? rates = null,
  }) {
    return _then(_$_ApiModel(
      null == table
          ? _value.table
          : table // ignore: cast_nullable_to_non_nullable
              as String,
      null == no
          ? _value.no
          : no // ignore: cast_nullable_to_non_nullable
              as String,
      null == effectiveDate
          ? _value.effectiveDate
          : effectiveDate // ignore: cast_nullable_to_non_nullable
              as String,
      null == rates
          ? _value._rates
          : rates // ignore: cast_nullable_to_non_nullable
              as List<ExchangeRatesModel>,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$_ApiModel implements _ApiModel {
  _$_ApiModel(this.table, this.no, this.effectiveDate,
      final List<ExchangeRatesModel> rates)
      : _rates = rates;

  factory _$_ApiModel.fromJson(Map<String, dynamic> json) =>
      _$$_ApiModelFromJson(json);

  @override
  final String table;
  @override
  final String no;
  @override
  final String effectiveDate;
  final List<ExchangeRatesModel> _rates;
  @override
  List<ExchangeRatesModel> get rates {
    if (_rates is EqualUnmodifiableListView) return _rates;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_rates);
  }

  @override
  String toString() {
    return 'ApiModel(table: $table, no: $no, effectiveDate: $effectiveDate, rates: $rates)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_ApiModel &&
            (identical(other.table, table) || other.table == table) &&
            (identical(other.no, no) || other.no == no) &&
            (identical(other.effectiveDate, effectiveDate) ||
                other.effectiveDate == effectiveDate) &&
            const DeepCollectionEquality().equals(other._rates, _rates));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, table, no, effectiveDate,
      const DeepCollectionEquality().hash(_rates));

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_ApiModelCopyWith<_$_ApiModel> get copyWith =>
      __$$_ApiModelCopyWithImpl<_$_ApiModel>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$_ApiModelToJson(
      this,
    );
  }
}

abstract class _ApiModel implements ApiModel {
  factory _ApiModel(
      final String table,
      final String no,
      final String effectiveDate,
      final List<ExchangeRatesModel> rates) = _$_ApiModel;

  factory _ApiModel.fromJson(Map<String, dynamic> json) = _$_ApiModel.fromJson;

  @override
  String get table;
  @override
  String get no;
  @override
  String get effectiveDate;
  @override
  List<ExchangeRatesModel> get rates;
  @override
  @JsonKey(ignore: true)
  _$$_ApiModelCopyWith<_$_ApiModel> get copyWith =>
      throw _privateConstructorUsedError;
}

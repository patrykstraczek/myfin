// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'home_cubit.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

/// @nodoc
mixin _$HomeState {
  List<SpendingsModel> get spendingDocs => throw _privateConstructorUsedError;
  List<IncomesModel> get incomesDocs => throw _privateConstructorUsedError;
  Status get status => throw _privateConstructorUsedError;
  String? get errorMessage => throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $HomeStateCopyWith<HomeState> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $HomeStateCopyWith<$Res> {
  factory $HomeStateCopyWith(HomeState value, $Res Function(HomeState) then) =
      _$HomeStateCopyWithImpl<$Res, HomeState>;
  @useResult
  $Res call(
      {List<SpendingsModel> spendingDocs,
      List<IncomesModel> incomesDocs,
      Status status,
      String? errorMessage});
}

/// @nodoc
class _$HomeStateCopyWithImpl<$Res, $Val extends HomeState>
    implements $HomeStateCopyWith<$Res> {
  _$HomeStateCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? spendingDocs = null,
    Object? incomesDocs = null,
    Object? status = freezed,
    Object? errorMessage = freezed,
  }) {
    return _then(_value.copyWith(
      spendingDocs: null == spendingDocs
          ? _value.spendingDocs
          : spendingDocs // ignore: cast_nullable_to_non_nullable
              as List<SpendingsModel>,
      incomesDocs: null == incomesDocs
          ? _value.incomesDocs
          : incomesDocs // ignore: cast_nullable_to_non_nullable
              as List<IncomesModel>,
      status: freezed == status
          ? _value.status
          : status // ignore: cast_nullable_to_non_nullable
              as Status,
      errorMessage: freezed == errorMessage
          ? _value.errorMessage
          : errorMessage // ignore: cast_nullable_to_non_nullable
              as String?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$_HomeStateCopyWith<$Res> implements $HomeStateCopyWith<$Res> {
  factory _$$_HomeStateCopyWith(
          _$_HomeState value, $Res Function(_$_HomeState) then) =
      __$$_HomeStateCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {List<SpendingsModel> spendingDocs,
      List<IncomesModel> incomesDocs,
      Status status,
      String? errorMessage});
}

/// @nodoc
class __$$_HomeStateCopyWithImpl<$Res>
    extends _$HomeStateCopyWithImpl<$Res, _$_HomeState>
    implements _$$_HomeStateCopyWith<$Res> {
  __$$_HomeStateCopyWithImpl(
      _$_HomeState _value, $Res Function(_$_HomeState) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? spendingDocs = null,
    Object? incomesDocs = null,
    Object? status = freezed,
    Object? errorMessage = freezed,
  }) {
    return _then(_$_HomeState(
      spendingDocs: null == spendingDocs
          ? _value._spendingDocs
          : spendingDocs // ignore: cast_nullable_to_non_nullable
              as List<SpendingsModel>,
      incomesDocs: null == incomesDocs
          ? _value._incomesDocs
          : incomesDocs // ignore: cast_nullable_to_non_nullable
              as List<IncomesModel>,
      status: freezed == status
          ? _value.status
          : status // ignore: cast_nullable_to_non_nullable
              as Status,
      errorMessage: freezed == errorMessage
          ? _value.errorMessage
          : errorMessage // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// @nodoc

class _$_HomeState implements _HomeState {
  const _$_HomeState(
      {final List<SpendingsModel> spendingDocs = const [],
      final List<IncomesModel> incomesDocs = const [],
      this.status = Status.initial,
      this.errorMessage})
      : _spendingDocs = spendingDocs,
        _incomesDocs = incomesDocs;

  final List<SpendingsModel> _spendingDocs;
  @override
  @JsonKey()
  List<SpendingsModel> get spendingDocs {
    if (_spendingDocs is EqualUnmodifiableListView) return _spendingDocs;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_spendingDocs);
  }

  final List<IncomesModel> _incomesDocs;
  @override
  @JsonKey()
  List<IncomesModel> get incomesDocs {
    if (_incomesDocs is EqualUnmodifiableListView) return _incomesDocs;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_incomesDocs);
  }

  @override
  @JsonKey()
  final Status status;
  @override
  final String? errorMessage;

  @override
  String toString() {
    return 'HomeState(spendingDocs: $spendingDocs, incomesDocs: $incomesDocs, status: $status, errorMessage: $errorMessage)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_HomeState &&
            const DeepCollectionEquality()
                .equals(other._spendingDocs, _spendingDocs) &&
            const DeepCollectionEquality()
                .equals(other._incomesDocs, _incomesDocs) &&
            const DeepCollectionEquality().equals(other.status, status) &&
            (identical(other.errorMessage, errorMessage) ||
                other.errorMessage == errorMessage));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType,
      const DeepCollectionEquality().hash(_spendingDocs),
      const DeepCollectionEquality().hash(_incomesDocs),
      const DeepCollectionEquality().hash(status),
      errorMessage);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_HomeStateCopyWith<_$_HomeState> get copyWith =>
      __$$_HomeStateCopyWithImpl<_$_HomeState>(this, _$identity);
}

abstract class _HomeState implements HomeState {
  const factory _HomeState(
      {final List<SpendingsModel> spendingDocs,
      final List<IncomesModel> incomesDocs,
      final Status status,
      final String? errorMessage}) = _$_HomeState;

  @override
  List<SpendingsModel> get spendingDocs;
  @override
  List<IncomesModel> get incomesDocs;
  @override
  Status get status;
  @override
  String? get errorMessage;
  @override
  @JsonKey(ignore: true)
  _$$_HomeStateCopyWith<_$_HomeState> get copyWith =>
      throw _privateConstructorUsedError;
}

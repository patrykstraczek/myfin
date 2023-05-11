// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'all_items_cubit.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

/// @nodoc
mixin _$AllItemsState {
  List<SpendingsModel> get spendingDocs => throw _privateConstructorUsedError;
  List<IncomesModel> get incomesDocs => throw _privateConstructorUsedError;
  Status get status => throw _privateConstructorUsedError;
  String? get errorMessage => throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $AllItemsStateCopyWith<AllItemsState> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $AllItemsStateCopyWith<$Res> {
  factory $AllItemsStateCopyWith(
          AllItemsState value, $Res Function(AllItemsState) then) =
      _$AllItemsStateCopyWithImpl<$Res, AllItemsState>;
  @useResult
  $Res call(
      {List<SpendingsModel> spendingDocs,
      List<IncomesModel> incomesDocs,
      Status status,
      String? errorMessage});
}

/// @nodoc
class _$AllItemsStateCopyWithImpl<$Res, $Val extends AllItemsState>
    implements $AllItemsStateCopyWith<$Res> {
  _$AllItemsStateCopyWithImpl(this._value, this._then);

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
abstract class _$$_AllItemsStateCopyWith<$Res>
    implements $AllItemsStateCopyWith<$Res> {
  factory _$$_AllItemsStateCopyWith(
          _$_AllItemsState value, $Res Function(_$_AllItemsState) then) =
      __$$_AllItemsStateCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {List<SpendingsModel> spendingDocs,
      List<IncomesModel> incomesDocs,
      Status status,
      String? errorMessage});
}

/// @nodoc
class __$$_AllItemsStateCopyWithImpl<$Res>
    extends _$AllItemsStateCopyWithImpl<$Res, _$_AllItemsState>
    implements _$$_AllItemsStateCopyWith<$Res> {
  __$$_AllItemsStateCopyWithImpl(
      _$_AllItemsState _value, $Res Function(_$_AllItemsState) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? spendingDocs = null,
    Object? incomesDocs = null,
    Object? status = freezed,
    Object? errorMessage = freezed,
  }) {
    return _then(_$_AllItemsState(
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

class _$_AllItemsState implements _AllItemsState {
  const _$_AllItemsState(
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
    return 'AllItemsState(spendingDocs: $spendingDocs, incomesDocs: $incomesDocs, status: $status, errorMessage: $errorMessage)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_AllItemsState &&
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
  _$$_AllItemsStateCopyWith<_$_AllItemsState> get copyWith =>
      __$$_AllItemsStateCopyWithImpl<_$_AllItemsState>(this, _$identity);
}

abstract class _AllItemsState implements AllItemsState {
  const factory _AllItemsState(
      {final List<SpendingsModel> spendingDocs,
      final List<IncomesModel> incomesDocs,
      final Status status,
      final String? errorMessage}) = _$_AllItemsState;

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
  _$$_AllItemsStateCopyWith<_$_AllItemsState> get copyWith =>
      throw _privateConstructorUsedError;
}

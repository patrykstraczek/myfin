// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'spendings_cubit.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

/// @nodoc
mixin _$SpendingsState {
  List<SpendingsModel> get docs => throw _privateConstructorUsedError;
  Status get status => throw _privateConstructorUsedError;
  String? get errorMessage => throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $SpendingsStateCopyWith<SpendingsState> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $SpendingsStateCopyWith<$Res> {
  factory $SpendingsStateCopyWith(
          SpendingsState value, $Res Function(SpendingsState) then) =
      _$SpendingsStateCopyWithImpl<$Res, SpendingsState>;
  @useResult
  $Res call({List<SpendingsModel> docs, Status status, String? errorMessage});
}

/// @nodoc
class _$SpendingsStateCopyWithImpl<$Res, $Val extends SpendingsState>
    implements $SpendingsStateCopyWith<$Res> {
  _$SpendingsStateCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? docs = null,
    Object? status = freezed,
    Object? errorMessage = freezed,
  }) {
    return _then(_value.copyWith(
      docs: null == docs
          ? _value.docs
          : docs // ignore: cast_nullable_to_non_nullable
              as List<SpendingsModel>,
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
abstract class _$$_SpendingsStateCopyWith<$Res>
    implements $SpendingsStateCopyWith<$Res> {
  factory _$$_SpendingsStateCopyWith(
          _$_SpendingsState value, $Res Function(_$_SpendingsState) then) =
      __$$_SpendingsStateCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({List<SpendingsModel> docs, Status status, String? errorMessage});
}

/// @nodoc
class __$$_SpendingsStateCopyWithImpl<$Res>
    extends _$SpendingsStateCopyWithImpl<$Res, _$_SpendingsState>
    implements _$$_SpendingsStateCopyWith<$Res> {
  __$$_SpendingsStateCopyWithImpl(
      _$_SpendingsState _value, $Res Function(_$_SpendingsState) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? docs = null,
    Object? status = freezed,
    Object? errorMessage = freezed,
  }) {
    return _then(_$_SpendingsState(
      docs: null == docs
          ? _value._docs
          : docs // ignore: cast_nullable_to_non_nullable
              as List<SpendingsModel>,
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

class _$_SpendingsState implements _SpendingsState {
  _$_SpendingsState(
      {final List<SpendingsModel> docs = const [],
      this.status = Status.initial,
      this.errorMessage})
      : _docs = docs;

  final List<SpendingsModel> _docs;
  @override
  @JsonKey()
  List<SpendingsModel> get docs {
    if (_docs is EqualUnmodifiableListView) return _docs;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_docs);
  }

  @override
  @JsonKey()
  final Status status;
  @override
  final String? errorMessage;

  @override
  String toString() {
    return 'SpendingsState(docs: $docs, status: $status, errorMessage: $errorMessage)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_SpendingsState &&
            const DeepCollectionEquality().equals(other._docs, _docs) &&
            const DeepCollectionEquality().equals(other.status, status) &&
            (identical(other.errorMessage, errorMessage) ||
                other.errorMessage == errorMessage));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType,
      const DeepCollectionEquality().hash(_docs),
      const DeepCollectionEquality().hash(status),
      errorMessage);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_SpendingsStateCopyWith<_$_SpendingsState> get copyWith =>
      __$$_SpendingsStateCopyWithImpl<_$_SpendingsState>(this, _$identity);
}

abstract class _SpendingsState implements SpendingsState {
  factory _SpendingsState(
      {final List<SpendingsModel> docs,
      final Status status,
      final String? errorMessage}) = _$_SpendingsState;

  @override
  List<SpendingsModel> get docs;
  @override
  Status get status;
  @override
  String? get errorMessage;
  @override
  @JsonKey(ignore: true)
  _$$_SpendingsStateCopyWith<_$_SpendingsState> get copyWith =>
      throw _privateConstructorUsedError;
}

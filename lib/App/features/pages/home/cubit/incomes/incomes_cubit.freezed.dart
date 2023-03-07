// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'incomes_cubit.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

/// @nodoc
mixin _$IncomesState {
  List<IncomesModel> get docs => throw _privateConstructorUsedError;
  Status get status => throw _privateConstructorUsedError;
  String? get errorMessage => throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $IncomesStateCopyWith<IncomesState> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $IncomesStateCopyWith<$Res> {
  factory $IncomesStateCopyWith(
          IncomesState value, $Res Function(IncomesState) then) =
      _$IncomesStateCopyWithImpl<$Res, IncomesState>;
  @useResult
  $Res call({List<IncomesModel> docs, Status status, String? errorMessage});
}

/// @nodoc
class _$IncomesStateCopyWithImpl<$Res, $Val extends IncomesState>
    implements $IncomesStateCopyWith<$Res> {
  _$IncomesStateCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? docs = null,
    Object? status = null,
    Object? errorMessage = freezed,
  }) {
    return _then(_value.copyWith(
      docs: null == docs
          ? _value.docs
          : docs // ignore: cast_nullable_to_non_nullable
              as List<IncomesModel>,
      status: null == status
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
abstract class _$$_IncomesStateCopyWith<$Res>
    implements $IncomesStateCopyWith<$Res> {
  factory _$$_IncomesStateCopyWith(
          _$_IncomesState value, $Res Function(_$_IncomesState) then) =
      __$$_IncomesStateCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({List<IncomesModel> docs, Status status, String? errorMessage});
}

/// @nodoc
class __$$_IncomesStateCopyWithImpl<$Res>
    extends _$IncomesStateCopyWithImpl<$Res, _$_IncomesState>
    implements _$$_IncomesStateCopyWith<$Res> {
  __$$_IncomesStateCopyWithImpl(
      _$_IncomesState _value, $Res Function(_$_IncomesState) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? docs = null,
    Object? status = null,
    Object? errorMessage = freezed,
  }) {
    return _then(_$_IncomesState(
      docs: null == docs
          ? _value._docs
          : docs // ignore: cast_nullable_to_non_nullable
              as List<IncomesModel>,
      status: null == status
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

class _$_IncomesState implements _IncomesState {
  _$_IncomesState(
      {final List<IncomesModel> docs = const [],
      this.status = Status.initial,
      this.errorMessage})
      : _docs = docs;

  final List<IncomesModel> _docs;
  @override
  @JsonKey()
  List<IncomesModel> get docs {
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
    return 'IncomesState(docs: $docs, status: $status, errorMessage: $errorMessage)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_IncomesState &&
            const DeepCollectionEquality().equals(other._docs, _docs) &&
            (identical(other.status, status) || other.status == status) &&
            (identical(other.errorMessage, errorMessage) ||
                other.errorMessage == errorMessage));
  }

  @override
  int get hashCode => Object.hash(runtimeType,
      const DeepCollectionEquality().hash(_docs), status, errorMessage);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_IncomesStateCopyWith<_$_IncomesState> get copyWith =>
      __$$_IncomesStateCopyWithImpl<_$_IncomesState>(this, _$identity);
}

abstract class _IncomesState implements IncomesState {
  factory _IncomesState(
      {final List<IncomesModel> docs,
      final Status status,
      final String? errorMessage}) = _$_IncomesState;

  @override
  List<IncomesModel> get docs;
  @override
  Status get status;
  @override
  String? get errorMessage;
  @override
  @JsonKey(ignore: true)
  _$$_IncomesStateCopyWith<_$_IncomesState> get copyWith =>
      throw _privateConstructorUsedError;
}

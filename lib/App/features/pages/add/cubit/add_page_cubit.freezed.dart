// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'add_page_cubit.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

/// @nodoc
mixin _$AddPageState {
  bool get saved => throw _privateConstructorUsedError;
  String? get errorMessage => throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $AddPageStateCopyWith<AddPageState> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $AddPageStateCopyWith<$Res> {
  factory $AddPageStateCopyWith(
          AddPageState value, $Res Function(AddPageState) then) =
      _$AddPageStateCopyWithImpl<$Res, AddPageState>;
  @useResult
  $Res call({bool saved, String? errorMessage});
}

/// @nodoc
class _$AddPageStateCopyWithImpl<$Res, $Val extends AddPageState>
    implements $AddPageStateCopyWith<$Res> {
  _$AddPageStateCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? saved = null,
    Object? errorMessage = freezed,
  }) {
    return _then(_value.copyWith(
      saved: null == saved
          ? _value.saved
          : saved // ignore: cast_nullable_to_non_nullable
              as bool,
      errorMessage: freezed == errorMessage
          ? _value.errorMessage
          : errorMessage // ignore: cast_nullable_to_non_nullable
              as String?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$_AddPageStateCopyWith<$Res>
    implements $AddPageStateCopyWith<$Res> {
  factory _$$_AddPageStateCopyWith(
          _$_AddPageState value, $Res Function(_$_AddPageState) then) =
      __$$_AddPageStateCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({bool saved, String? errorMessage});
}

/// @nodoc
class __$$_AddPageStateCopyWithImpl<$Res>
    extends _$AddPageStateCopyWithImpl<$Res, _$_AddPageState>
    implements _$$_AddPageStateCopyWith<$Res> {
  __$$_AddPageStateCopyWithImpl(
      _$_AddPageState _value, $Res Function(_$_AddPageState) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? saved = null,
    Object? errorMessage = freezed,
  }) {
    return _then(_$_AddPageState(
      saved: null == saved
          ? _value.saved
          : saved // ignore: cast_nullable_to_non_nullable
              as bool,
      errorMessage: freezed == errorMessage
          ? _value.errorMessage
          : errorMessage // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// @nodoc

class _$_AddPageState implements _AddPageState {
  _$_AddPageState({this.saved = false, this.errorMessage});

  @override
  @JsonKey()
  final bool saved;
  @override
  final String? errorMessage;

  @override
  String toString() {
    return 'AddPageState(saved: $saved, errorMessage: $errorMessage)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_AddPageState &&
            (identical(other.saved, saved) || other.saved == saved) &&
            (identical(other.errorMessage, errorMessage) ||
                other.errorMessage == errorMessage));
  }

  @override
  int get hashCode => Object.hash(runtimeType, saved, errorMessage);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_AddPageStateCopyWith<_$_AddPageState> get copyWith =>
      __$$_AddPageStateCopyWithImpl<_$_AddPageState>(this, _$identity);
}

abstract class _AddPageState implements AddPageState {
  factory _AddPageState({final bool saved, final String? errorMessage}) =
      _$_AddPageState;

  @override
  bool get saved;
  @override
  String? get errorMessage;
  @override
  @JsonKey(ignore: true)
  _$$_AddPageStateCopyWith<_$_AddPageState> get copyWith =>
      throw _privateConstructorUsedError;
}

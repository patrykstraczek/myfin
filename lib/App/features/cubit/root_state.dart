part of 'root_cubit.dart';

@freezed
class RootState with _$RootState {
  factory RootState({
    @Default(null)User? user,
    @Default(Status.initial) Status status,
    String? errorMessage,
  }) = _RootState;
}

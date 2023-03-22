part of 'spendings_cubit.dart';

@freezed
class SpendingsState with _$SpendingsState {
  factory SpendingsState({
    @Default([]) List<SpendingsModel> docs,
    @Default(Status.initial) Status status,
    String? errorMessage,
  }) = _SpendingsState;
}


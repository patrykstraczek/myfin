part of 'incomes_cubit.dart';


@freezed
class IncomesState with _$IncomesState {
  factory IncomesState({
    @Default([]) List<IncomesModel> docs,
    @Default(Status.initial) Status status,
    String? errorMessage,
  }) = _IncomesState;
}

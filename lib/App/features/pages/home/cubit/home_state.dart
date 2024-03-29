part of 'home_cubit.dart';

@freezed
class HomeState with _$HomeState {
  const factory HomeState({
    @Default([]) List<SpendingsModel> spendingDocs,
    @Default([]) List<IncomesModel> incomesDocs,
    @Default(Status.initial) Status status,
    String? errorMessage,
  }) = _HomeState;
}

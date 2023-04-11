part of 'daily_reports_cubit.dart';

@freezed
class DailyReportsState with _$DailyReportsState {
  const factory DailyReportsState({
    @Default([]) List<SpendingsModel> spendingDocs,
    @Default([]) List<IncomesModel> incomesDocs,
    @Default(Status.initial) Status status,
    String? errorMessage,
  }) = _DailyReportsState;
}



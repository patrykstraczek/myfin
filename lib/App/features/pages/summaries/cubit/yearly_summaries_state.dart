part of 'yearly_summaries_cubit.dart';

@freezed
class YearlySummariesState with _$YearlySummariesState {
  const factory YearlySummariesState({
    @Default([]) List<SpendingsModel> spendingDocs,
    @Default([]) List<IncomesModel> incomesDocs,
    @Default(Status.initial) Status status,
    String? errorMessage,
  }) = _YearlySummariesState;
}

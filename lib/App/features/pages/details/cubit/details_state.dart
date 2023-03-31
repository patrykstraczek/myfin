part of 'details_cubit.dart';

@freezed
class DetailsState with _$DetailsState {
  factory DetailsState({
    @Default([]) List<SpendingsModel> spendingDocs,
    @Default([]) List<IncomesModel> incomesDocs,
    @Default(Status.initial) Status status,
    String? errorMessage,
  }) = _DetailsState;
}

part of 'all_items_cubit.dart';


@freezed
class AllItemsState with _$AllItemsState {
  const factory AllItemsState({
    @Default([]) List<SpendingsModel> spendingDocs,
    @Default([]) List<IncomesModel> incomesDocs,
    @Default(Status.initial) Status status,
    String? errorMessage,
  }) = _AllItemsState;
}


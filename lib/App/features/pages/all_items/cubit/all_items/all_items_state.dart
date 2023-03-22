part of 'all_items_cubit.dart';


@freezed
class AllItemsState with _$AllItemsState {
  factory AllItemsState({
    @Default([]) List<QueryDocumentSnapshot<Object?>> documents,
    @Default(Status.initial) Status status,
    String? errorMessage,
  }) = _AllItemsState;
}


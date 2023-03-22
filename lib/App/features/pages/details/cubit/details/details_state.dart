part of 'details_cubit.dart';


@freezed
class DetailsState with _$DetailsState {
  factory DetailsState({
    @Default([]) List<QueryDocumentSnapshot<Object?>> documents,
    @Default(Status.initial) Status status,
    String? errorMessage,
  }) = _DetailsState;
}


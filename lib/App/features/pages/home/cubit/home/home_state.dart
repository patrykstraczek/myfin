part of 'home_cubit.dart';


@freezed
class HomeState with _$HomeState {
  factory HomeState({
    @Default([]) List<QueryDocumentSnapshot<Object?>> documents,
    @Default(Status.initial) Status status,
    String? errorMessage,
  }) = _HomeState;
}


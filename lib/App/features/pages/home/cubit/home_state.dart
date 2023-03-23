part of 'home_cubit.dart';

@freezed
class HomeState with _$HomeState {
  const factory HomeState({
    @Default([]) List<SpendingsModel> docs,
    @Default(Status.initial) Status status,
    String? errorMessage,
  }) = _HomeState;
}

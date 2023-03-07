part of 'exchange_rates_cubit.dart';

@freezed
class ExchangeRatesState with _$ExchangeRatesState {
  factory ExchangeRatesState({
    @Default([]) List<ExchangeRatesModel> results,
    @Default(Status.initial) Status status,
    String? errorMessage,
  }) = _ExchangeRatesState;
}
part of 'exchange_rates_cubit.dart';

@immutable
class ExchangeRatesState {
  const ExchangeRatesState({
    this.results = const [],
    this.status = Status.initial,
    this.errorMessage,
  });
  final List<ExchangeRatesModel> results;
  final Status status;
  final String? errorMessage;
}

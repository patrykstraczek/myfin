import 'package:myfin/App/domain/models/exchange_rates_model.dart';
import 'package:myfin/App/domain/remote_data_sources/exchange_rates_data_source.dart';

class ExchangeRatesRepository {
  ExchangeRatesRepository({
    required this.remoteDataSource,
  });

  final ExchangeRatesDTO remoteDataSource;

  Future<List<ExchangeRatesModel>> getExchangeRatesModel() async {
    final exchangeRatesResponse = await remoteDataSource.getDataFromApi();

    final exchangeRates = exchangeRatesResponse.expand((e) => e.rates).toList();

    return exchangeRates
        .map((rate) => ExchangeRatesModel(
              rate.code,
              rate.currency,
              rate.averageRate,
            ))
        .toList();
  }
}

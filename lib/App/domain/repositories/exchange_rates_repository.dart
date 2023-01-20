import 'package:myfin/App/domain/models/exchange_rates_model.dart';
import 'package:myfin/App/domain/remote_data_sources/exchange_rates_data_source.dart';

class ExchangeRatesRepository {
  ExchangeRatesRepository({
    required this.remoteDataSource,
  });

  final ExchangeRatesDioDataSource remoteDataSource;

  Future<List<ExchangeRatesModel>> getExchangeRatesModel() async {
    final json = await remoteDataSource.getExchangeRatesModel();

    return json.map((rates) => ExchangeRatesModel.fromJson(rates)).toList();
  }
}

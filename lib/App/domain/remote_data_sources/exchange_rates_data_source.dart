import 'package:dio/dio.dart';

class ExchangeRatesDioDataSource {
  Future<List<dynamic>> getExchangeRatesModel() async {
    final response =
        await Dio().get('http://api.nbp.pl/api/exchangerates/tables/A/');
    final responseData = response.data;
    final ratesData = responseData[0]['rates'];

    return ratesData;
  }
}

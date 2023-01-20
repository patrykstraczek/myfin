import 'package:dio/dio.dart';

class ExchangeRatesDioDataSource {
  Future<List<Map<String, dynamic>>?> getExchangeRatesModel() async {
    final response = await Dio().get<List<dynamic>>(
        'http://api.nbp.pl/api/exchangerates/tables/C?format=json');
    final listDynamic = response.data;
    if (listDynamic == null) {
      return null;
    }
    return listDynamic.map((e) => e as Map<String, dynamic>).toList();
  }
}

//  http://api.nbp.pl/api/exchangerates/tables/C/

//http://api.nbp.pl/api/exchangerates/rates/c/usd/today

//http://api.nbp.pl/api/exchangerates/tables/C?format=json

//final result = json.decode(response.data);

class ExchangeRatesDataSource {
  Future<List<Map<String, dynamic>>?> getExchangeRatesModel() async {
    return [
      {
        "code": "USD",
        "bid": 4.2910,
        "ask": 4.3776,
      },
      {
        "code": "AUD",
        "bid": 2.9862,
        "ask": 3.0466,
      },
    ];
  }
}

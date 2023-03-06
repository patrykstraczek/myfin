import 'package:dio/dio.dart';
import 'package:myfin/App/domain/models/api_model.dart';
import 'package:myfin/App/domain/models/exchange_rates_model.dart';
import 'package:retrofit/retrofit.dart';

part 'exchange_rates_data_source.g.dart';

@RestApi(baseUrl: "http://api.nbp.pl/api/exchangerates/tables")
abstract class ExchangeRatesDTO {
  factory ExchangeRatesDTO(Dio dio, {String baseUrl}) = _ExchangeRatesDTO;

  @GET('/A')
  Future<List<ApiModel>> getExchangeRates();
}
















// class ExchangeRatesDioDataSource {
//   Future<List<ExchangeRatesApiResponse>> getExchangeRates() async {
//     final response =
//         await Dio().get('http://api.nbp.pl/api/exchangerates/tables/A/');
//     final responseData = response.data as List<dynamic>;
//     final exchangeRatesData = responseData
//         .map((json) => ExchangeRatesApiResponse.fromJson(json))
//         .toList();

//     return exchangeRatesData;
//   }
// }
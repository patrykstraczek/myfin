import 'package:dio/dio.dart';
import 'package:myfin/app/domain/models/api_model.dart';
import 'package:retrofit/retrofit.dart';

part 'exchange_rates_data_source.g.dart';

@RestApi(baseUrl: "http://api.nbp.pl/api/exchangerates/tables")
abstract class ExchangeRatesDTO {
  factory ExchangeRatesDTO(Dio dio, {String baseUrl}) = _ExchangeRatesDTO;

  @GET('/A')
  Future<List<ApiModel>> getDataFromApi();
}



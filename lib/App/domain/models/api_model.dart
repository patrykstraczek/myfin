import 'package:myfin/App/domain/models/exchange_rates_model.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'api_model.g.dart';
part 'api_model.freezed.dart';

@freezed
class ApiModel with _$ApiModel {
  factory ApiModel(
    String table,
    String no,
    String effectiveDate,
    List<ExchangeRatesModel> rates,
  ) = _ApiModel;

  factory ApiModel.fromJson(Map<String, dynamic> json) =>
      _$ApiModelFromJson(json);
}




// class ApiModel {
//   final String table;
//   final String no;
//   final String effectiveDate;
//   final List<ExchangeRatesModel> rates;

//   ApiModel({
//     required this.table,
//     required this.no,
//     required this.effectiveDate,
//     required this.rates,
//   });

//   factory ApiModel.fromJson(Map<String, dynamic> json) {
//     final ratesJson = json['rates'] as List<dynamic>;
//     final rates = ratesJson
//         .map((rateJson) => ExchangeRatesModel.fromJson(rateJson))
//         .toList();
//     return ApiModel(
//       table: json['table'] as String,
//       no: json['no'] as String,
//       effectiveDate: json['effectiveDate'] as String,
//       rates: rates,
//     );
//   }
// }
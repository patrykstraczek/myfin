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

import 'package:freezed_annotation/freezed_annotation.dart';

part 'exchange_rates_model.g.dart';
part 'exchange_rates_model.freezed.dart';

@freezed
class ExchangeRatesModel with _$ExchangeRatesModel {
  factory ExchangeRatesModel(
    @JsonKey(name: 'currency') String currency,
    String code,
    @JsonKey(name: 'mid') double averageRate,
  ) = _ExchangeRatesModel;

  factory ExchangeRatesModel.fromJson(Map<String, dynamic> json) =>
      _$ExchangeRatesModelFromJson(json);
}

class ExchangeRatesModel {
  ExchangeRatesModel({
    required this.code,
    required this.averageRate,
  });
  final String code;
  final double averageRate;

  ExchangeRatesModel.fromJson(Map<String, dynamic> json)
      : code = json['code'],
        averageRate = json['mid'];
}

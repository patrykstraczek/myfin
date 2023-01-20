class ExchangeRatesModel {
  ExchangeRatesModel({
    required this.code,
    required this.purchaseRate,
    required this.sellingRate,
  });
  final String code;
  final double purchaseRate;
  final double sellingRate;

  ExchangeRatesModel.fromJson(Map<String, dynamic> json)
      : code = json['rates'][0]['code'],
        purchaseRate = json['rates'][0]['bid'],
        sellingRate = json['rates'][0]['ask'];
}

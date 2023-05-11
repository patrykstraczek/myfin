// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'exchange_rates_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_ExchangeRatesModel _$$_ExchangeRatesModelFromJson(
        Map<String, dynamic> json) =>
    _$_ExchangeRatesModel(
      json['code'] as String,
      (json['mid'] as num).toDouble(),
    );

Map<String, dynamic> _$$_ExchangeRatesModelToJson(
        _$_ExchangeRatesModel instance) =>
    <String, dynamic>{
      'code': instance.code,
      'mid': instance.averageRate,
    };

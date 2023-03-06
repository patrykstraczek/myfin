// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'api_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_ApiModel _$$_ApiModelFromJson(Map<String, dynamic> json) => _$_ApiModel(
      json['table'] as String,
      json['no'] as String,
      json['effectiveDate'] as String,
      (json['rates'] as List<dynamic>)
          .map((e) => ExchangeRatesModel.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$$_ApiModelToJson(_$_ApiModel instance) =>
    <String, dynamic>{
      'table': instance.table,
      'no': instance.no,
      'effectiveDate': instance.effectiveDate,
      'rates': instance.rates,
    };

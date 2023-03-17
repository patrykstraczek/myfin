import 'package:freezed_annotation/freezed_annotation.dart';

part 'spendings_model.freezed.dart';


@freezed
class SpendingsModel with _$SpendingsModel {
  factory SpendingsModel({
    required String id,
    required String spendingName,
    required double spendingValue,
    required DateTime spendingDate,
    required int selectedSpendingIcon,
  }) = _SpendingsModel;
}


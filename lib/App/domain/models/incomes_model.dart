import 'package:freezed_annotation/freezed_annotation.dart';

part 'incomes_model.freezed.dart';

@freezed
class IncomesModel with _$IncomesModel {
  factory IncomesModel({
    required String id,
    required String incomeName,
    required double incomeValue,
    required DateTime incomeDate,
    required int selectedIncomesIcon,
  }) = _IncomesModel;
}
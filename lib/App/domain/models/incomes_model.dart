class IncomesModel {
  IncomesModel({
    required this.id,
    required this.incomeName,
    required this.incomeValue,
    required this.incomeDate,
    required this.selectedIncomesIcon,
  });

  final String id;
  final String incomeName;
  final double incomeValue;
  final DateTime incomeDate;
  final int selectedIncomesIcon;
}

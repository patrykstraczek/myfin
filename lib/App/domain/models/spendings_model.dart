class SpendingsModel {
  SpendingsModel({
    required this.id,
    required this.spendingName,
    required this.spendingValue,
    required this.spendingDate,
    required this.selectedSpendingIcon,
  });

  final String id;
  final String spendingName;
  final double spendingValue;
  final DateTime spendingDate;
  final int selectedSpendingIcon;
}

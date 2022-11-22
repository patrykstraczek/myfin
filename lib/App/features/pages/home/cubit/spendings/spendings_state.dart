part of 'spendings_cubit.dart';

@immutable
class SpendingsState {
  const SpendingsState({
    required this.docs,
    required this.isLoading,
    required this.errorMessage,
  });
  final List<SpendingsModel> docs;
  final bool isLoading;
  final String errorMessage;
}

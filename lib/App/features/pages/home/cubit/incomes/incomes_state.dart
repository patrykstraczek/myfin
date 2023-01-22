part of 'incomes_cubit.dart';

@immutable
class IncomesState {
  const IncomesState({
    required this.docs,
    required this.isLoading,
    required this.errorMessage,
  });

  final List<IncomesModel> docs;
  final bool isLoading;
  final String errorMessage;
}

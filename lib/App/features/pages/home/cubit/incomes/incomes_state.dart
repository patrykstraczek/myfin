part of 'incomes_cubit.dart';

@immutable
class IncomesState {
  final List<QueryDocumentSnapshot<Map<String, dynamic>>> documents;
  final bool isLoading;
  final String errorMessage;

  const IncomesState({
    required this.documents,
    required this.isLoading,
    required this.errorMessage,
  });
}

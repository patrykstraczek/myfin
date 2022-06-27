part of 'spendings_cubit.dart';

@immutable
class SpendingsState {
  final List<QueryDocumentSnapshot<Map<String, dynamic>>> documents;
  final bool isLoading;
  final String errorMessage;

  const SpendingsState({
    required this.documents,
    required this.isLoading,
    required this.errorMessage,
  });
}

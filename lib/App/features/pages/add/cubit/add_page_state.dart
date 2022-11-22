part of 'add_page_cubit.dart';

@immutable
class AddPageState {
  const AddPageState({
    this.saved = false,
    this.errorMessage = '',
  });

  final bool saved;
  final String errorMessage;
}

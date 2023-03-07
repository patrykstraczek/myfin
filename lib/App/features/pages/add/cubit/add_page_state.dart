part of 'add_page_cubit.dart';

@freezed
class AddPageState with _$AddPageState {
  factory AddPageState({
    @Default(false) bool saved,
    String? errorMessage,
  }) = _AddPageState;
}


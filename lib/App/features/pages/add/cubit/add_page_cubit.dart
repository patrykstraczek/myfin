// ignore_for_file: depend_on_referenced_packages

import 'package:bloc/bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

import 'package:myfin/App/domain/repositories/incomes_repository.dart';
import 'package:myfin/App/domain/repositories/spendings_repository.dart';

part 'add_page_state.dart';
part 'add_page_cubit.freezed.dart';

class AddPageCubit extends Cubit<AddPageState> {
  AddPageCubit(this._spendingsRepository, this._incomesRepository)
      : super( AddPageState());

  final SpendingsRepository _spendingsRepository;
  final IncomesRepository _incomesRepository;

  Future<void> addSpending(
    String name,
    String value,
    DateTime selectedDate,
    var spendingIcon,
  ) async {
    try {
      await _spendingsRepository.addSpending(
        name,
        value,
        selectedDate,
        spendingIcon,
      );
      emit( AddPageState(saved: true));
    } catch (error) {
      emit(AddPageState(errorMessage: error.toString()));
    }
  }

  Future<void> addIncome(
    String name,
    String value,
    DateTime selectedDate,
    var incomeIcon,
  ) async {
    try {
      await _incomesRepository.addIncome(
        name,
        value,
        selectedDate,
        incomeIcon,
      );
      emit( AddPageState(saved: true));
    } catch (error) {
      emit(AddPageState(errorMessage: error.toString()));
    }
  }
}

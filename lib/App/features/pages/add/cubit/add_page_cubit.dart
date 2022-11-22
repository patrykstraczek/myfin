// ignore_for_file: depend_on_referenced_packages

import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:meta/meta.dart';

part 'add_page_state.dart';

class AddSpendingPageCubit extends Cubit<AddPageState> {
  AddSpendingPageCubit() : super(const AddPageState());

  Future<void> addSpending(
    String name,
    String value,
    DateTime selectedDate,
    var spendingIcon,
  ) async {
    try {
      await FirebaseFirestore.instance
          .collection('users')
          .doc('2SHBQGWMo4JZleshrllF')
          .collection('spendings')
          .add({
        'icon': spendingIcon,
        'spendingName': name,
        'spendingValue': double.parse(value),
        'date': selectedDate,
      });
      emit(const AddPageState(saved: true));
    } catch (error) {
      emit(
        AddPageState(
          errorMessage: error.toString(),
        ),
      );
    }
  }
}

class AddIncomePageCubit extends Cubit<AddPageState> {
  AddIncomePageCubit() : super(const AddPageState());

  Future<void> addIncome(
      String name, String value, DateTime selectedDate, var incomeIcon) async {
    try {
      await FirebaseFirestore.instance
          .collection('users')
          .doc('2SHBQGWMo4JZleshrllF')
          .collection('incomes')
          .add({
        'icon': incomeIcon,
        'incomeName': name,
        'incomeValue': double.parse(value),
        'date': selectedDate,
      });
      emit(const AddPageState(saved: true));
    } catch (error) {
      emit(
        AddPageState(
          errorMessage: error.toString(),
        ),
      );
    }
  }
}

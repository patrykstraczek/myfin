// ignore_for_file: depend_on_referenced_packages, unused_import

import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:myfin/App/core/enums.dart';
import 'package:myfin/App/domain/models/spendings_model.dart';
import 'package:myfin/App/domain/remote_data_sources/incomes_data_source.dart';
import 'package:myfin/App/domain/remote_data_sources/spending_data_source.dart';

part 'home_state.dart';
part 'home_cubit.freezed.dart';

class HomeCubit extends Cubit<HomeState> {
  final userID = FirebaseAuth.instance.currentUser?.uid;
  final now = DateTime.now();
  final spendingDataSource = FirebaseSpendingsDataSource();
  final incomeDataSource = FirebaseIncomeDataSource();

  HomeCubit() : super(HomeState());

  StreamSubscription? _homeSpendingsSubscription;
  StreamSubscription? _homeIncomesSubscription;

  StreamSubscription<QuerySnapshot<Map<String, dynamic>>>
      _handleSpendingsStream(
          Stream<QuerySnapshot<Map<String, dynamic>>> stream) {
    emit(
      HomeState(status: Status.loading),
    );
    return stream.listen((data) {
      try {
        emit(HomeState(
          status: Status.success,
          documents: data.docs,
        ));
      } catch (error) {
        emit(HomeState(
          status: Status.error,
          errorMessage: error.toString(),
        ));
      }
    });
  }

  StreamSubscription<QuerySnapshot<Map<String, dynamic>>> _handleIncomesStream(
      Stream<QuerySnapshot<Map<String, dynamic>>> stream) {
    emit(
      HomeState(
        status: Status.loading,
      ),
    );
    return stream.listen((data) {
      try {
        emit(HomeState(
          status: Status.success,
          documents: data.docs,
        ));
      } catch (error) {
        emit(HomeState(
          status: Status.error,
          errorMessage: error.toString(),
        ));
      }
    });
  }

//getSpendings
  Future<void> getTodaySpendings() async {
    final start = DateTime(now.year, now.month, now.day);
    final end = DateTime(now.year, now.month, now.day, 23, 59, 59);
    final stream = spendingDataSource.getSpendings(start, end);
    _homeSpendingsSubscription = _handleSpendingsStream(stream);
  }

  Future<void> getThisMonthSpendings() async {
    final start = DateTime(now.year, now.month, 1);
    final end = DateTime(now.year, now.month + 1, 0, 23, 59, 59);
    final stream = spendingDataSource.getSpendings(start, end);
    _homeSpendingsSubscription = _handleSpendingsStream(stream);
  }

  Future<void> getPreviousMonthSpendings() async {
    final start = DateTime(now.year, now.month - 1, 1);
    final end = DateTime(now.year, now.month, 0, 23, 59, 59);
    final stream = spendingDataSource.getSpendings(start, end);
    _homeSpendingsSubscription = _handleSpendingsStream(stream);
  }

//getIncome
  Future<void> getTodayIncome() async {
    final start = DateTime(now.year, now.month, now.day);
    final end = DateTime(now.year, now.month, now.day, 23, 59, 59);
    final stream = incomeDataSource.getIncomes(start, end);
    _homeIncomesSubscription = _handleIncomesStream(stream);
  }

  Future<void> getThisMonthIncome() async {
    final start = DateTime(now.year, now.month, 1);
    final end = DateTime(now.year, now.month + 1, 0, 23, 59, 59);
    final stream = incomeDataSource.getIncomes(start, end);
    _homeIncomesSubscription = _handleIncomesStream(stream);
  }

  Future<void> getPreviousMonthIncome() async {
    final start = DateTime(now.year, now.month - 1, 1);
    final end = DateTime(now.year, now.month, 0, 23, 59, 59);
    final stream = incomeDataSource.getIncomes(start, end);
    _homeIncomesSubscription = _handleIncomesStream(stream);
  }
  
//close
  @override
  Future<void> close() {
    _homeSpendingsSubscription?.cancel();
    _homeIncomesSubscription?.cancel();
    return super.close();
  }
}

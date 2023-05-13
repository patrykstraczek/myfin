// ignore_for_file: depend_on_referenced_packages

import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:myfin/App/core/enums.dart';
import 'package:myfin/App/domain/models/spendings_model.dart';
import 'package:myfin/App/domain/remote_data_sources/incomes_data_source.dart';
import 'package:myfin/App/domain/remote_data_sources/spending_data_source.dart';
import 'package:myfin/App/domain/repositories/incomes_repository.dart';
import 'package:myfin/App/domain/repositories/spendings_repository.dart';
import 'package:myfin/App/domain/models/incomes_model.dart';

part 'all_items_state.dart';
part 'all_items_cubit.freezed.dart';

class AllItemsCubit extends Cubit<AllItemsState> {
  final userID = FirebaseAuth.instance.currentUser?.uid;
  final now = DateTime.now();
  final spendingDataSource = FirebaseSpendingsDataSource();
  final incomeDataSource = FirebaseIncomeDataSource();

  AllItemsCubit(this._incomesRepository, this._spendingsRepository)
      : super(const AllItemsState());

  StreamSubscription? _homeSpendingsSubscription;
  StreamSubscription? _homeIncomesSubscription;
  final SpendingsRepository _spendingsRepository;
  final IncomesRepository _incomesRepository;

  Future<void> getDailyStream({required selectedDay}) async {
    _homeSpendingsSubscription = _spendingsRepository
        .getDailySpendingStream(selectedDay: selectedDay)
        .listen((dailySpendings) {
      _homeIncomesSubscription = _incomesRepository
          .getDailyIncomeStream(selectedDay: selectedDay)
          .listen((dailyIncome) async {
        emit(const AllItemsState(status: Status.loading));
        try {
          final dailyIncomes = await _incomesRepository
              .getDailyIncomeStream(selectedDay: selectedDay)
              .first;
          final dailySpendings = await _spendingsRepository
              .getDailySpendingStream(selectedDay: selectedDay)
              .first;
          emit(
            AllItemsState(
              status: Status.success,
              incomesDocs: dailyIncomes,
              spendingDocs: dailySpendings,
            ),
          );
        } catch (error) {
          emit(
            AllItemsState(
              status: Status.error,
              errorMessage: error.toString(),
            ),
          );
        }
      });
    });
  }

  Future<void> getThisMonthStream() async {
    _homeSpendingsSubscription = _spendingsRepository
        .getMontlySpendingsStream(month: now.month, year: now.year)
        .listen((monthlySpendings) {
      _homeIncomesSubscription = _incomesRepository
          .getMontlyIncomeStream(month: now.month, year: now.year)
          .listen((monthlyIncomes) async {
        emit(const AllItemsState(status: Status.loading));
        try {
          emit(
            AllItemsState(
              status: Status.success,
              incomesDocs: monthlyIncomes,
              spendingDocs: monthlySpendings,
            ),
          );
        } catch (error) {
          emit(
            AllItemsState(
              status: Status.error,
              errorMessage: error.toString(),
            ),
          );
        }
      });
    });
  }

  Future<void> getPreviousMonthStream() async {
    _homeSpendingsSubscription = _spendingsRepository
        .getMontlySpendingsStream(month: now.month - 1, year: now.year)
        .listen((monthlySpendings) {
      _homeIncomesSubscription = _incomesRepository
          .getMontlyIncomeStream(month: now.month - 1, year: now.year)
          .listen((monthlyIncomes) async {
        emit(const AllItemsState(status: Status.loading));
        try {
          emit(
            AllItemsState(
              status: Status.success,
              incomesDocs: monthlyIncomes,
              spendingDocs: monthlySpendings,
            ),
          );
        } catch (error) {
          emit(
            AllItemsState(
              status: Status.error,
              errorMessage: error.toString(),
            ),
          );
        }
      });
    });
  }

  @override
  Future<void> close() {
    _homeSpendingsSubscription?.cancel();
    _homeIncomesSubscription?.cancel();
    return super.close();
  }
}

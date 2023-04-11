// ignore_for_file: depend_on_referenced_packages
import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:myfin/App/core/enums.dart';
import 'package:myfin/App/domain/remote_data_sources/incomes_data_source.dart';
import 'package:myfin/App/domain/remote_data_sources/spending_data_source.dart';
import 'package:myfin/App/domain/repositories/spendings_repository.dart';
import 'package:myfin/App/domain/models/spendings_model.dart';
import 'package:myfin/App/domain/models/incomes_model.dart';
import 'package:myfin/App/domain/repositories/incomes_repository.dart';

part 'daily_reports_state.dart';
part 'daily_reports_cubit.freezed.dart';

class DailyReportsCubit extends Cubit<DailyReportsState> {
  final userID = FirebaseAuth.instance.currentUser?.uid;
  final now = DateTime.now();
  final spendingDataSource = FirebaseSpendingsDataSource();
  final incomeDataSource = FirebaseIncomeDataSource();

  DailyReportsCubit({
    required this.incomesRepository,
    required this.spendingsRepository,
  }) : super(const DailyReportsState());

  StreamSubscription? _spendingsSubscription;
  StreamSubscription? _incomesSubscription;
  final SpendingsRepository spendingsRepository;
  final IncomesRepository incomesRepository;

  Future<void> getMonthlyData({required int month, required int year}) async {
    emit(const DailyReportsState(status: Status.loading));
    try {
      final monthlyIncomes = await incomesRepository
          .getMontlyIncomeStream(month: month, year: year)
          .first;
      final monthlySpendings = await spendingsRepository
          .getMontlySpendingsStream(month: month, year: year)
          .first;
      emit(
        DailyReportsState(
          status: Status.success,
          incomesDocs: monthlyIncomes,
          spendingDocs: monthlySpendings,
        ),
      );
    } catch (error) {
      emit(
        DailyReportsState(
          status: Status.error,
          errorMessage: error.toString(),
        ),
      );
    }
  }

  Future<void> getDailyStream({required selectedDay}) async {
    emit(const DailyReportsState(status: Status.loading));
    try {
      final dailyIncomes = await incomesRepository
          .getDailyIncomeStream(selectedDate: selectedDay)
          .first;
      final dailySpendings = await spendingsRepository
          .getDailySpendingStream(selectedDay: selectedDay)
          .first;
      emit(
        DailyReportsState(
          status: Status.success,
          incomesDocs: dailyIncomes,
          spendingDocs: dailySpendings,
        ),
      );
    } catch (error) {
      emit(
        DailyReportsState(
          status: Status.error,
          errorMessage: error.toString(),
        ),
      );
    }
  }

//getSpendings

//getIncome

//close
  @override
  Future<void> close() {
    _spendingsSubscription?.cancel();
    _incomesSubscription?.cancel();
    return super.close();
  }
}

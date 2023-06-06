// ignore_for_file: depend_on_referenced_packages

import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:myfin/App/core/enums.dart';
import 'package:myfin/App/domain/models/incomes_model.dart';
import 'package:myfin/App/domain/models/spendings_model.dart';
import 'package:myfin/App/domain/repositories/spendings_repository.dart';
import 'package:myfin/App/domain/repositories/incomes_repository.dart';

part 'yearly_summaries_state.dart';
part 'yearly_summaries_cubit.freezed.dart';

class YearlySummariesCubit extends Cubit<YearlySummariesState> {
  final now = DateTime.now();

  final SpendingsRepository spendingsRepository;
  StreamSubscription? spendingsSubscription;
  final IncomesRepository incomesRepository;
  StreamSubscription? incomesSubscription;

  YearlySummariesCubit(
      {required this.incomesRepository, required this.spendingsRepository})
      : super(const YearlySummariesState());

  Future<void> getYearlyData({required int year}) async {
    emit(const YearlySummariesState(status: Status.loading));
    try {
      final yearlyIncomes =
          await incomesRepository.getYearlyIncomeStream(year: year).first;
      final yearlySpendings =
          await spendingsRepository.getYearlySpendingsStream(year: year).first;
      emit(
        YearlySummariesState(
          status: Status.success,
          incomesDocs: yearlyIncomes,
          spendingDocs: yearlySpendings,
        ),
      );
    } catch (error) {
      emit(
        YearlySummariesState(
          status: Status.error,
          errorMessage: error.toString(),
        ),
      );
    }
  }

  Future<void> getMonthlyData({required int month, required int year}) async {
    emit(const YearlySummariesState(status: Status.loading));
    try {
      final monthlyIncomes = await incomesRepository
          .getMontlyIncomeStream(month: month, year: year)
          .first;
      final monthlySpendings = await spendingsRepository
          .getMontlySpendingsStream(month: month, year: year)
          .first;
      emit(
        YearlySummariesState(
          status: Status.success,
          incomesDocs: monthlyIncomes,
          spendingDocs: monthlySpendings,
        ),
      );
    } catch (error) {
      emit(
        YearlySummariesState(
          status: Status.error,
          errorMessage: error.toString(),
        ),
      );
    }
  }

  @override
  Future<void> close() {
    spendingsSubscription?.cancel();
    incomesSubscription?.cancel();
    return super.close();
  }
}

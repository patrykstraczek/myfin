// ignore_for_file: depend_on_referenced_packages

import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:myfin/App/core/enums.dart';
import 'package:myfin/App/domain/models/incomes_model.dart';
import 'package:myfin/App/domain/remote_data_sources/incomes_data_source.dart';
import 'package:myfin/App/domain/remote_data_sources/spending_data_source.dart';
import 'package:myfin/App/domain/models/spendings_model.dart';
import 'package:myfin/app/domain/repositories/spendings_repository.dart';
import 'package:myfin/app/domain/repositories/incomes_repository.dart';

part 'home_state.dart';
part 'home_cubit.freezed.dart';

class HomeCubit extends Cubit<HomeState> {
  final userID = FirebaseAuth.instance.currentUser?.uid;
  final now = DateTime.now();
  final spendingDataSource = FirebaseSpendingsDataSource();
  final incomeDataSource = FirebaseIncomeDataSource();

  final SpendingsRepository spendingsRepository;
  StreamSubscription? spendingsSubscription;
  final IncomesRepository incomesRepository;
  StreamSubscription? incomesSubscription;

  HomeCubit(this.incomesRepository, {required this.spendingsRepository})
      : super(const HomeState());

  Future<void> monthlySpendings({required int month, required int year}) async {
    spendingsSubscription = spendingsRepository
        .getMontlySpendingsStream(month: month, year: year)
        .listen((spendings) {
      emit(
        HomeState(
          status: Status.success,
          spendingDocs: spendings,
        ),
      );
    }, onError: (error) {
      emit(
        HomeState(
          status: Status.error,
          errorMessage: error.toString(),
        ),
      );
    });
  }

  Future<void> monthlyIncomes({required int month, required int year}) async {
    incomesSubscription = incomesRepository
        .getMontlyIncomeStream(month: month, year: year)
        .listen((incomes) {
      emit(
        HomeState(
          status: Status.success,
          incomesDocs: incomes,
        ),
      );
    }, onError: (error) {
      emit(
        HomeState(
          status: Status.error,
          errorMessage: error.toString(),
        ),
      );
    });
  }

  Future<void> getMonthlyData({required int month, required int year}) async {
    emit(const HomeState(status: Status.loading));
    try {
      final monthlyIncomes = await incomesRepository
          .getMontlyIncomeStream(month: month, year: year)
          .first;
      final monthlySpendings = await spendingsRepository
          .getMontlySpendingsStream(month: month, year: year)
          .first;
      emit(
        HomeState(
          status: Status.success,
          incomesDocs: monthlyIncomes,
          spendingDocs: monthlySpendings,
        ),
      );
    } catch (error) {
      emit(
        HomeState(
          status: Status.error,
          errorMessage: error.toString(),
        ),
      );
    }
  }

  // @override
  // Future<void> close() {
  //   spendingsSubscription?.cancel();
  //   incomesSubscription?.cancel();
  //   return super.close();
  // }
}

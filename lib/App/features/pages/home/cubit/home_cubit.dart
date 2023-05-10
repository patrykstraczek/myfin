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
  StreamSubscription? _spendingsSubscription;
  final IncomesRepository incomesRepository;
  StreamSubscription? _incomesSubscription;

  HomeCubit(
      {required this.incomesRepository, required this.spendingsRepository})
      : super(const HomeState());

  Future<void> getMonthlyData({required int month, required int year}) async {
    _spendingsSubscription = spendingsRepository
        .getMontlySpendingsStream(month: month, year: year)
        .listen((monthlySpendings) {
      _incomesSubscription = incomesRepository
          .getMontlyIncomeStream(month: month, year: year)
          .listen((monthlyIncomes) {
        emit(const HomeState(status: Status.loading));
        try {
          emit(HomeState(
            spendingDocs: monthlySpendings,
            incomesDocs: monthlyIncomes,
            status: Status.success,
          ));
        } catch (error) {
          emit(HomeState(errorMessage: error.toString(), status: Status.error));
        }
      });
    });
  }

  @override
  Future<void> close() {
    _spendingsSubscription?.cancel();
    _incomesSubscription?.cancel();
    return super.close();
  }
}

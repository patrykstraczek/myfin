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

part 'daily_reports_state.dart';
part 'daily_reports_cubit.freezed.dart';

class DailyReportsCubit extends Cubit<DailyReportsState> {
  final userID = FirebaseAuth.instance.currentUser?.uid;
  final now = DateTime.now();
  final spendingDataSource = FirebaseSpendingsDataSource();
  final incomeDataSource = FirebaseIncomeDataSource();

  DailyReportsCubit({required this.spendingsRepository})
      : super(const DailyReportsState());

  StreamSubscription? _spendingsSubscription;
  StreamSubscription? _incomesSubscription;
  final SpendingsRepository spendingsRepository;
  StreamSubscription? spendingsSubscription;

  Future<void> start() async {
    _spendingsSubscription =
        spendingsRepository.getSpendingsStream().listen((spendings) {
      emit(
        const DailyReportsState(status: Status.loading),
      );
      try {
        emit(
          DailyReportsState(
            status: Status.success,
            docs: spendings,
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
    });
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

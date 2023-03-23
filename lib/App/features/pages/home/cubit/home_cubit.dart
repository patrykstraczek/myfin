// ignore_for_file: depend_on_referenced_packages

import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:myfin/App/core/enums.dart';
import 'package:myfin/App/domain/remote_data_sources/incomes_data_source.dart';
import 'package:myfin/App/domain/remote_data_sources/spending_data_source.dart';
import 'package:myfin/App/domain/models/spendings_model.dart';
import 'package:myfin/App/domain/repositories/spendings_repository.dart';

part 'home_state.dart';
part 'home_cubit.freezed.dart';

class HomeCubit extends Cubit<HomeState> {
  final userID = FirebaseAuth.instance.currentUser?.uid;
  final now = DateTime.now();
  final spendingDataSource = FirebaseSpendingsDataSource();
  final incomeDataSource = FirebaseIncomeDataSource();

  HomeCubit({required this.spendingsRepository}) : super(const HomeState());

  final SpendingsRepository spendingsRepository;
  StreamSubscription? spendingsSubscription;

  Future<void> start() async {
    spendingsSubscription =
        spendingsRepository.getSpendingsStream().listen((spendings) {
      emit(
        const HomeState(status: Status.loading),
      );
      try {
        emit(
          HomeState(
            status: Status.success,
            docs: spendings,
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
    });
  }

  @override
  Future<void> close() {
    spendingsSubscription?.cancel();
    return super.close();
  }
}

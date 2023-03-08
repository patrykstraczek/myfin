// ignore_for_file: depend_on_referenced_packages

import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:myfin/App/core/enums.dart';
import 'package:myfin/App/domain/models/incomes_model.dart';
import 'package:myfin/App/domain/repositories/incomes_repository.dart';

part 'incomes_state.dart';
part 'incomes_cubit.freezed.dart';

class IncomesCubit extends Cubit<IncomesState> {
  IncomesCubit({required this.incomesRepository}) : super(IncomesState());

  final IncomesRepository incomesRepository;

  StreamSubscription? incomesSubscription;

  Future<void> start() async {
    incomesSubscription =
        incomesRepository.getIncomesStream().listen((incomes) {
      emit(
        IncomesState(
          status: Status.loading,
        ),
      );
      try {
        emit(
          IncomesState(
            status: Status.success,
            docs: incomes,
          ),
        );
      } catch (error) {
        emit(
          IncomesState(
            status: Status.error,
            errorMessage: error.toString(),
          ),
        );
      }
    });
  }

  Future<void> remove({required String documentID}) async {
    try {
      await incomesRepository.remove(id: documentID);
    } catch (error) {
      emit(
        IncomesState(
          status: Status.error,
          errorMessage: error.toString(),
        ),
      );
      start();
    }
  }

  @override
  Future<void> close() {
    incomesSubscription?.cancel();
    return super.close();
  }
}

// ignore_for_file: depend_on_referenced_packages

import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:myfin/App/domain/models/incomes_model.dart';
import 'package:myfin/App/domain/repositories/incomes_repository.dart';

part 'incomes_state.dart';

class IncomesCubit extends Cubit<IncomesState> {
  IncomesCubit(this._incomesRepository)
      : super(
          const IncomesState(
            docs: [],
            errorMessage: '',
            isLoading: false,
          ),
        );
  final IncomesRepository _incomesRepository;
  StreamSubscription? incomesSubscription;

  Future<void> start() async {
    incomesSubscription =
        _incomesRepository.getIncomesStream().listen((incomes) {
      emit(
        IncomesState(
          docs: incomes,
          isLoading: false,
          errorMessage: '',
        ),
      );
    })
          ..onError((error) {
            emit(
              IncomesState(
                docs: const [],
                isLoading: false,
                errorMessage: error.toString(),
              ),
            );
          });
  }

  Future<void> remove({required String documentID}) async {
    try {
      await _incomesRepository.remove(id: documentID);
    } catch (error) {
      emit(
        IncomesState(
          docs: const [],
          isLoading: false,
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

// ignore_for_file: depend_on_referenced_packages

import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:myfin/App/domain/models/spendings_model.dart';

import 'package:myfin/App/domain/repositories/spendings_repository.dart';

part 'spendings_state.dart';

class SpendingsCubit extends Cubit<SpendingsState> {
  SpendingsCubit(this._spendingsRepository)
      : super(
          const SpendingsState(
            docs: [],
            isLoading: false,
            errorMessage: '',
          ),
        );
  final SpendingsRepository _spendingsRepository;
  StreamSubscription? spendingsSubscription;

  Future<void> start() async {
    spendingsSubscription =
        _spendingsRepository.getSpendingsStream().listen((spendings) {
      emit(
        SpendingsState(
          docs: spendings,
          isLoading: false,
          errorMessage: '',
        ),
      );
    })
          ..onError((error) {
            emit(
              SpendingsState(
                docs: const [],
                isLoading: false,
                errorMessage: error.toString(),
              ),
            );
          });
  }

  Future<void> remove({required String documentID}) async {
    try {
      await _spendingsRepository.remove(id: documentID);
    } catch (error) {
      emit(
        SpendingsState(
          docs: const [],
          isLoading: false,
          errorMessage: error.toString(),
        ),
      );
    }
  }
}

// ignore_for_file: depend_on_referenced_packages

import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:myfin/App/core/enums.dart';
import 'package:myfin/App/domain/models/spendings_model.dart';

import 'package:myfin/App/domain/repositories/spendings_repository.dart';

part 'spendings_state.dart';
part 'spendings_cubit.freezed.dart';

class SpendingsCubit extends Cubit<SpendingsState> {
  SpendingsCubit({required this.spendingsRepository}) : super(SpendingsState());

  final SpendingsRepository spendingsRepository;
  StreamSubscription? spendingsSubscription;

  Future<void> start() async {
    spendingsSubscription =
        spendingsRepository.getSpendingsStream().listen((spendings) {
      emit(
        SpendingsState(status: Status.loading),
      );
      try {
        emit(
          SpendingsState(
            status: Status.success,
            docs: spendings,
          ),
        );
      } catch (error) {
        emit(
          SpendingsState(
            status: Status.error,
            errorMessage: error.toString(),
          ),
        );
      }
    });
  }

  Future<void> remove({required String documentID}) async {
    try {
      await spendingsRepository.remove(id: documentID);
    } catch (error) {
      emit(
        SpendingsState(
          docs: const [],
          errorMessage: error.toString(),
        ),
      );
    }
  }
  @override
  Future<void> close() {
    spendingsSubscription?.cancel();
    return super.close();
  }
}


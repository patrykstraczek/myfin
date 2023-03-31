import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:myfin/App/core/enums.dart';
import 'package:myfin/App/domain/models/incomes_model.dart';
import 'package:myfin/App/domain/models/spendings_model.dart';
import 'package:myfin/App/domain/repositories/spendings_repository.dart';
import 'package:myfin/App/domain/repositories/incomes_repository.dart';

part 'details_state.dart';
part 'details_cubit.freezed.dart';

class DetailsCubit extends Cubit<DetailsState> {
  DetailsCubit(this.spendingsRepository, this.incomesRepository)
      : super(DetailsState());

  final SpendingsRepository spendingsRepository;
  StreamSubscription? spendingsSubscription;

  final IncomesRepository incomesRepository;

  StreamSubscription? incomesSubscription;

  Future<void> streamSpendings({required DateTime selectedDay}) async {
    spendingsSubscription =
        spendingsRepository.getSpendingsStream().listen((spendings) {
      emit(
        DetailsState(status: Status.loading),
      );
      try {
        emit(
          DetailsState(
            status: Status.success,
            spendingDocs: spendings,
          ),
        );
      } catch (error) {
        emit(
          DetailsState(
            status: Status.error,
            errorMessage: error.toString(),
          ),
        );
      }
    });
  }

  Future<void> removeSpendings({required String documentID}) async {
    try {
      await spendingsRepository.remove(id: documentID);
    } catch (error) {
      emit(
        DetailsState(
          errorMessage: error.toString(),
        ),
      );
    }
  }

  Future<void> streamIncomes() async {
    incomesSubscription =
        incomesRepository.getIncomesStream().listen((incomes) {
      emit(
        DetailsState(
          status: Status.loading,
        ),
      );
      try {
        emit(
          DetailsState(
            status: Status.success,
            incomesDocs: incomes,
          ),
        );
      } catch (error) {
        emit(
          DetailsState(
            status: Status.error,
            errorMessage: error.toString(),
          ),
        );
      }
    });
  }

  Future<void> removeIncomes({required String documentID}) async {
    try {
      await incomesRepository.remove(id: documentID);
    } catch (error) {
      emit(
        DetailsState(
          status: Status.error,
          errorMessage: error.toString(),
        ),
      );
      streamIncomes();
    }
  }

  @override
  Future<void> close() {
    incomesSubscription?.cancel();
    spendingsSubscription?.cancel();
    return super.close();
  }
}

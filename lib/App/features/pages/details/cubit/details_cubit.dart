import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:myfin/App/core/enums.dart';
import 'package:myfin/App/domain/models/incomes_model.dart';
import 'package:myfin/App/domain/models/spendings_model.dart';
import 'package:myfin/app/domain/repositories/spendings_repository.dart';
import 'package:myfin/app/domain/repositories/incomes_repository.dart';
import 'package:myfin/app/features/pages/add/pages/add_page.dart';

part 'details_state.dart';
part 'details_cubit.freezed.dart';

class DetailsCubit extends Cubit<DetailsState> {
  DetailsCubit(this.spendingsRepository, this.incomesRepository)
      : super(DetailsState());

  final SpendingsRepository spendingsRepository;
  StreamSubscription? spendingsSubscription;

  final IncomesRepository incomesRepository;

  StreamSubscription? incomesSubscription;

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

  Future<void> spendings({required DateTime selectedDay}) async {
    spendingsSubscription = spendingsRepository
        .getDailySpendingStream(selectedDay: selectedDay)
        .listen((spendings) {
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

  Future<void> getDailyStream({required selectedDay}) async {
    emit(DetailsState(status: Status.loading));
    try {
      final dailyIncomes = await incomesRepository
          .getDailyIncomeStream(selectedDate: selectedDay)
          .first;
      final dailySpendings = await spendingsRepository
          .getDailySpendingStream(selectedDay: selectedDay)
          .first;
      emit(
        DetailsState(
          status: Status.success,
          incomesDocs: dailyIncomes,
          spendingDocs: dailySpendings,
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
    }
  }

  @override
  Future<void> close() {
    incomesSubscription?.cancel();
    spendingsSubscription?.cancel();
    return super.close();
  }
}

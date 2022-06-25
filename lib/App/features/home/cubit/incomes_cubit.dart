import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:meta/meta.dart';

part 'incomes_state.dart';

class IncomesCubit extends Cubit<IncomesState> {
  IncomesCubit()
      : super(
          const IncomesState(
            documents: [],
            errorMessage: '',
            isLoading: false,
          ),
        );
  StreamSubscription? incomesSubscription;

  Future<void> start() async {
    emit(
      const IncomesState(
        documents: [],
        errorMessage: '',
        isLoading: true,
      ),
    );
    incomesSubscription = FirebaseFirestore.instance
        .collection('users')
        .doc('2SHBQGWMo4JZleshrllF')
        .collection('incomes')
        .snapshots()
        .listen((data) {
      emit(
        IncomesState(
          documents: data.docs,
          isLoading: false,
          errorMessage: '',
        ),
      );
    })
      ..onError((error) {
        emit(
          IncomesState(
            documents: const [],
            isLoading: false,
            errorMessage: error.toString(),
          ),
        );
      });
  }

  @override
  Future<void> close() {
    incomesSubscription?.cancel();
    return super.close();
  }
}
// ignore_for_file: depend_on_referenced_packages

import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:meta/meta.dart';
import 'package:firebase_auth/firebase_auth.dart';

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
    final userID = FirebaseAuth.instance.currentUser?.uid;
    if (userID == null) {
      throw Exception('Użytkownik niezalogowany');
    }
    emit(
      const IncomesState(
        documents: [],
        errorMessage: '',
        isLoading: true,
      ),
    );
    incomesSubscription = FirebaseFirestore.instance
        .collection('users')
        .doc(userID)
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

  Future<void> remove({required String documentID}) async {
    final userID = FirebaseAuth.instance.currentUser?.uid;
    if (userID == null) {
      throw Exception('Użytkownik niezalogowany');
    }
    try {
      await FirebaseFirestore.instance
          .collection('users')
          .doc(userID)
          .collection('incomes')
          .doc(documentID)
          .delete();
    } catch (error) {
      emit(
        IncomesState(
            documents: const [],
            isLoading: false,
            errorMessage: error.toString()),
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

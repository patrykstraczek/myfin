// ignore_for_file: depend_on_referenced_packages

import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:myfin/App/models/spendings_model.dart';

part 'spendings_state.dart';

class SpendingsCubit extends Cubit<SpendingsState> {
  SpendingsCubit()
      : super(
          const SpendingsState(
            docs: [],
            isLoading: false,
            errorMessage: '',
          ),
        );
  StreamSubscription? spendingsSubscription;

  Future<void> start() async {
    emit(
      const SpendingsState(
        docs: [],
        isLoading: true,
        errorMessage: '',
      ),
    );
    spendingsSubscription = FirebaseFirestore.instance
        .collection('users')
        .doc('2SHBQGWMo4JZleshrllF')
        .collection('spendings')
        .snapshots()
        .listen((data) {
      final spendingsModels = data.docs.map((doc) {
        return SpendingsModel(
          id: doc.id,
          spendingName: doc['spendingName'],
          spendingValue: doc['spendingValue'],
          spendingDate: (doc['date'] as Timestamp).toDate(),
          selectedSpendingIcon: doc['icon'],
        );
      }).toList();
      emit(
        SpendingsState(
          docs: spendingsModels,
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
      await FirebaseFirestore.instance
          .collection('users')
          .doc('2SHBQGWMo4JZleshrllF')
          .collection('spendings')
          .doc(documentID)
          .delete();
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

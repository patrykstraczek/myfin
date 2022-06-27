import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

part 'spendings_state.dart';

class SpendingsCubit extends Cubit<SpendingsState> {
  SpendingsCubit()
      : super(
          const SpendingsState(
            documents: [],
            isLoading: false,
            errorMessage: '',
          ),
        );
  StreamSubscription? spendingsSubscription;

  Future<void> start() async {
    emit(
      const SpendingsState(
        documents: [],
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
      emit(
        SpendingsState(
          documents: data.docs,
          isLoading: false,
          errorMessage: '',
        ),
      );
    })
      ..onError((error) {
        emit(
          SpendingsState(
            documents: const [],
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
          documents: const [],
          isLoading: false,
          errorMessage: error.toString(),
        ),
      );
    }
  }
}

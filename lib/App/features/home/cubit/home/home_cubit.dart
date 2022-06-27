import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:meta/meta.dart';

part 'home_state.dart';

class HomeCubit extends Cubit<HomeState> {
  HomeCubit()
      : super(
          const HomeState(
            documents: [],
            errorMessage: '',
            isLoading: false,
          ),
        );

  StreamSubscription? _homeSpendingsSubscription;

  Future<void> start() async {
    emit(
      const HomeState(
        documents: [],
        errorMessage: '',
        isLoading: true,
      ),
    );

    _homeSpendingsSubscription = FirebaseFirestore.instance
        .collection('users')
        .doc('2SHBQGWMo4JZleshrllF')
        .collection('spendings')
        .snapshots()
        .listen((data) {
      emit(
        HomeState(
          documents: data.docs,
          isLoading: false,
          errorMessage: '',
        ),
      );
    })
      ..onError((error) {
        emit(
          HomeState(
            documents: const [],
            isLoading: false,
            errorMessage: error.toString(),
          ),
        );
      });
  }

  @override
  Future<void> close() {
    _homeSpendingsSubscription?.cancel();
    return super.close();
  }
}

class HomeIncomeCubit extends Cubit<HomeState> {
  HomeIncomeCubit()
      : super(
          const HomeState(
            documents: [],
            errorMessage: '',
            isLoading: false,
          ),
        );

  StreamSubscription? _homeIncomesSubscription;

  Future<void> start() async {
    emit(
      const HomeState(
        documents: [],
        errorMessage: '',
        isLoading: true,
      ),
    );

    _homeIncomesSubscription = FirebaseFirestore.instance
        .collection('users')
        .doc('2SHBQGWMo4JZleshrllF')
        .collection('incomes')
        .snapshots()
        .listen((data) {
      emit(
        HomeState(
          documents: data.docs,
          isLoading: false,
          errorMessage: '',
        ),
      );
    })
      ..onError((error) {
        emit(
          HomeState(
            documents: const [],
            isLoading: false,
            errorMessage: error.toString(),
          ),
        );
      });
  }

  @override
  Future<void> close() {
    _homeIncomesSubscription?.cancel();
    return super.close();
  }
}

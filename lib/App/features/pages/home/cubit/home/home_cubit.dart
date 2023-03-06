// ignore_for_file: depend_on_referenced_packages, unused_import

import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:meta/meta.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:myfin/App/domain/models/spendings_model.dart';

part 'home_state.dart';

class HomeCubit extends Cubit<HomeState> {
  final userID = FirebaseAuth.instance.currentUser?.uid;
  final now = DateTime.now();
  HomeCubit()
      : super(
          const HomeState(
            documents: [],
            errorMessage: '',
            isLoading: false,
          ),
        );

  StreamSubscription? _homeSpendingsSubscription;

  Future<void> getTodaySpendings() async {
    if (userID == null) {
      throw Exception('User is not logged in');
    }
    emit(
      const HomeState(
        documents: [],
        errorMessage: '',
        isLoading: true,
      ),
    );

    _homeSpendingsSubscription = FirebaseFirestore.instance
        .collection('users')
        .doc(userID)
        .collection('spendings')
        .where("date",
            isGreaterThanOrEqualTo: DateTime(now.year, now.month, now.day))
        .where("date",
            isLessThanOrEqualTo:
                DateTime(now.year, now.month, now.day, 23, 59, 59))
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

  Future<void> getThisMonthSpendings() async {
    if (userID == null) {
      throw Exception('User is not logged in');
    }
    emit(
      const HomeState(
        documents: [],
        errorMessage: '',
        isLoading: true,
      ),
    );

    _homeSpendingsSubscription = FirebaseFirestore.instance
        .collection('users')
        .doc(userID)
        .collection('spendings')
        .where("date", isGreaterThanOrEqualTo: DateTime(now.year, now.month, 1))
        .where("date",
            isLessThanOrEqualTo:
                DateTime(now.year, now.month + 1, 0, 23, 59, 59))
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

  Future<void> getPreviousMonthSpendings() async {
    var previousMonthStart = DateTime(now.year, now.month - 1, 1);
    var previousMonthEnd = DateTime(now.year, now.month, 0, 23, 59, 59);
    if (userID == null) {
      throw Exception('User is not logged in');
    }
    emit(
      const HomeState(
        documents: [],
        errorMessage: '',
        isLoading: true,
      ),
    );

    _homeSpendingsSubscription = FirebaseFirestore.instance
        .collection('users')
        .doc(userID)
        .collection('spendings')
        .where("date", isGreaterThanOrEqualTo: previousMonthStart)
        .where("date", isLessThanOrEqualTo: previousMonthEnd)
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
  final now = DateTime.now();
  final userID = FirebaseAuth.instance.currentUser?.uid;
  HomeIncomeCubit()
      : super(
          const HomeState(
            documents: [],
            errorMessage: '',
            isLoading: false,
          ),
        );

  StreamSubscription? _homeIncomesSubscription;

  Future<void> getTodayIncome() async {
    if (userID == null) {
      throw Exception('User is not logged in');
    }
    emit(
      const HomeState(
        documents: [],
        errorMessage: '',
        isLoading: true,
      ),
    );

    _homeIncomesSubscription = FirebaseFirestore.instance
        .collection('users')
        .doc(userID)
        .collection('incomes')
        .where("date",
            isGreaterThanOrEqualTo: DateTime(now.year, now.month, now.day))
        .where("date",
            isLessThanOrEqualTo:
                DateTime(now.year, now.month, now.day, 23, 59, 59))
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

  Future<void> getThisMonthIncome() async {
    if (userID == null) {
      throw Exception('User is not logged in');
    }
    emit(
      const HomeState(
        documents: [],
        errorMessage: '',
        isLoading: true,
      ),
    );

    _homeIncomesSubscription = FirebaseFirestore.instance
        .collection('users')
        .doc(userID)
        .collection('incomes')
        .where("date", isGreaterThanOrEqualTo: DateTime(now.year, now.month, 1))
        .where("date",
            isLessThanOrEqualTo:
                DateTime(now.year, now.month + 1, 0, 23, 59, 59))
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

  Future<void> getPreviousMonthIncome() async {
    var previousMonthStart = DateTime(now.year, now.month - 1, 1);
    var previousMonthEnd = DateTime(now.year, now.month, 0, 23, 59, 59);
    if (userID == null) {
      throw Exception('User is not logged in');
    }
    emit(
      const HomeState(
        documents: [],
        errorMessage: '',
        isLoading: true,
      ),
    );

    _homeIncomesSubscription = FirebaseFirestore.instance
        .collection('users')
        .doc(userID)
        .collection('incomes')
        .where("date", isGreaterThanOrEqualTo: previousMonthStart)
        .where("date", isLessThanOrEqualTo: previousMonthEnd)
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

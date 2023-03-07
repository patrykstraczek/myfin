// ignore_for_file: depend_on_referenced_packages, unused_import

import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:myfin/App/core/enums.dart';
import 'package:myfin/App/domain/models/spendings_model.dart';

part 'home_state.dart';
part 'home_cubit.freezed.dart';

class HomeCubit extends Cubit<HomeState> {
  final userID = FirebaseAuth.instance.currentUser?.uid;
  final now = DateTime.now();

  HomeCubit() : super(HomeState());

  StreamSubscription? _homeSpendingsSubscription;

  StreamSubscription<QuerySnapshot<Map<String, dynamic>>>
      _handleSpendingsStream(
          Stream<QuerySnapshot<Map<String, dynamic>>> stream) {
    emit(
      HomeState(status: Status.loading),
    );
    return stream.listen((data) {
      try {
        emit(HomeState(
          status: Status.success,
          documents: data.docs,
        ));
      } catch (error) {
        emit(HomeState(
          status: Status.error,
          errorMessage: error.toString(),
        ));
      }
    });
  }

  void getTodaySpendings() {
    final start = DateTime(now.year, now.month, now.day);
    final end = DateTime(now.year, now.month, now.day, 23, 59, 59);
    final stream = _getSpendings(start, end);
    _homeSpendingsSubscription = _handleSpendingsStream(stream);
  }

  void getThisMonthSpendings() {
    final start = DateTime(now.year, now.month, 1);
    final end = DateTime(now.year, now.month + 1, 0, 23, 59, 59);
    final stream = _getSpendings(start, end);
    _homeSpendingsSubscription = _handleSpendingsStream(stream);
  }

  void getPreviousMonthSpendings() {
    final start = DateTime(now.year, now.month - 1, 1);
    final end = DateTime(now.year, now.month, 0, 23, 59, 59);
    final stream = _getSpendings(start, end);
    _homeSpendingsSubscription = _handleSpendingsStream(stream);
  }

  Stream<QuerySnapshot<Map<String, dynamic>>> _getSpendings(
      DateTime start, DateTime end) {
    if (userID == null) {
      throw Exception('User is not logged in');
    }
    return FirebaseFirestore.instance
        .collection('users')
        .doc(userID)
        .collection('spendings')
        .where("date", isGreaterThanOrEqualTo: start)
        .where("date", isLessThanOrEqualTo: end)
        .snapshots();
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

  HomeIncomeCubit() : super(HomeState());

  StreamSubscription? _homeIncomesSubscription;

  StreamSubscription<QuerySnapshot<Map<String, dynamic>>> _handleIncomesStream(
      Stream<QuerySnapshot<Map<String, dynamic>>> stream) {
    emit(
      HomeState(
        status: Status.loading,
      ),
    );
    return stream.listen((data) {
      try {
        emit(HomeState(
          status: Status.success,
          documents: data.docs,
        ));
      } catch (error) {
        emit(HomeState(
          status: Status.error,
          errorMessage: error.toString(),
        ));
      }
    });
  }

  Future<void> getTodayIncome() async {
    final start = DateTime(now.year, now.month, now.day);
    final end = DateTime(now.year, now.month, now.day, 23, 59, 59);
    final stream = _getIncomes(start, end);
    _homeIncomesSubscription = _handleIncomesStream(stream);
  }

  Future<void> getThisMonthIncome() async {
    final start = DateTime(now.year, now.month, 1);
    final end = DateTime(now.year, now.month + 1, 0, 23, 59, 59);
    final stream = _getIncomes(start, end);
    _homeIncomesSubscription = _handleIncomesStream(stream);
  }

  Future<void> getPreviousMonthIncome() async {
    final start = DateTime(now.year, now.month - 1, 1);
    final end = DateTime(now.year, now.month, 0, 23, 59, 59);
    final stream = _getIncomes(start, end);
    _homeIncomesSubscription = _handleIncomesStream(stream);
  }

  Stream<QuerySnapshot<Map<String, dynamic>>> _getIncomes(
      DateTime start, DateTime end) {
    if (userID == null) {
      throw Exception('User is not logged in');
    }
    return FirebaseFirestore.instance
        .collection('users')
        .doc(userID)
        .collection('incomes')
        .where("date", isGreaterThanOrEqualTo: start)
        .where("date", isLessThanOrEqualTo: end)
        .snapshots();
  }

  @override
  Future<void> close() {
    _homeIncomesSubscription?.cancel();
    return super.close();
  }
}

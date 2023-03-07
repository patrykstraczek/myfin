// ignore_for_file: depend_on_referenced_packages

import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:myfin/App/core/enums.dart';

part 'root_state.dart';
part 'root_cubit.freezed.dart';

class RootCubit extends Cubit<RootState> {
  RootCubit() : super(RootState());

  StreamSubscription? _streamsubscription;

  Future<void> signOut() async {
    FirebaseAuth.instance.signOut();
  }

  Future<void> start() async {
    emit(RootState(status: Status.loading));

    _streamsubscription =
        FirebaseAuth.instance.authStateChanges().listen((user) {
      try {
        emit(
          RootState(
            status: Status.success,
            user: user,
          ),
        );
      } catch (error) {
        emit(
          RootState(
            status: Status.error,
            errorMessage: error.toString(),
          ),
        );
      }
    });
  }

  @override
  Future<void> close() {
    _streamsubscription?.cancel();
    return super.close();
  }
}

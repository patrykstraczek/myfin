// ignore_for_file: depend_on_referenced_packages

import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:meta/meta.dart';

part 'root_state.dart';

class RootCubit extends Cubit<RootState> {
  RootCubit()
      : super(
          const RootState(
            user: null,
            isLoading: false,
            errorMessage: '',
          ),
        );

  StreamSubscription? _streamsubscription;

  Future<void> signOut() async {
    FirebaseAuth.instance.signOut();
  }

  Future<void> start() async {
    emit(
      const RootState(
        user: null,
        isLoading: true,
        errorMessage: '',
      ),
    );

    _streamsubscription =
        FirebaseAuth.instance.authStateChanges().listen((user) {
      emit(
        RootState(
          user: user,
          isLoading: false,
          errorMessage: '',
        ),
      );
    })
          ..onError((error) {
            emit(
              RootState(
                user: null,
                isLoading: false,
                errorMessage: error.toString(),
              ),
            );
          });
  }

  @override
  Future<void> close() {
    _streamsubscription?.cancel();
    return super.close();
  }
}

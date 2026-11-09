import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';

import '../../../data/repositories/auth_repository.dart';
import 'authentication_state.dart';

@singleton
class AuthenticationCubit extends Cubit<AuthenticationState> {
  final AuthRepository _repository;

  AuthenticationCubit(this._repository)
      : super(const AuthenticationState.initial());

  Future<void> loadData() async {
    emit(const AuthenticationState.loading());

    try {
      final user = await _repository.getCurrentUser();

      if (user == null) {
        emit(const AuthenticationState.unauthenticated());
      } else {
        emit(AuthenticationState.authenticated(user));
      }
    } catch (e) {
      emit(AuthenticationState.error(e.toString()));
    }
  }

  Future<void> logout() async {
    try {
      await _repository.logout();
      await loadData();
    } catch (e) {
      emit(AuthenticationState.error(e.toString()));
    }
  }
}
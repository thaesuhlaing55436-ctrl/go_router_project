
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';

import '../../../../data/repositories/auth_repository.dart';
import '../../../blocs/authentication/authentication_cubit.dart';
import 'login_state.dart';

@injectable
class LoginCubit extends Cubit<LoginState> {
  final AuthRepository _repository;
  final AuthenticationCubit _authenticationCubit;

  LoginCubit(
      this._repository,
      this._authenticationCubit,
      ) : super(const LoginState.initial());

  Future<void> login({
    required String email,
    required String password,
  }) async {
    if (email.trim().isEmpty) {
      emit(const LoginState.error('Please enter your email'));
      return;
    }

    if (!_isValidEmail(email.trim())) {
      emit(const LoginState.error('Please enter a valid email'));
      return;
    }

    if (password.isEmpty) {
      emit(const LoginState.error('Please enter your password'));
      return;
    }

    emit(const LoginState.loading());

    try {
      await _repository.login(
        email: email.trim(),
        password: password,
      );

      await _authenticationCubit.loadData();

      if (!isClosed) {
        emit(const LoginState.success());
      }
    } catch (e) {
      if (!isClosed) {
        emit(LoginState.error(
          e.toString().replaceFirst('Exception: ', ''),
        ));
      }
    }
  }

  bool _isValidEmail(String email) {
    return RegExp(
      r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$',
    ).hasMatch(email);
  }
}

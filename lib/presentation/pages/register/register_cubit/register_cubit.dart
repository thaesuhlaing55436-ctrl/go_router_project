
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';

import '../../../../data/repositories/auth_repository.dart';
import '../../../blocs/authentication/authentication_cubit.dart';
import 'register_state.dart';

@injectable
class RegisterCubit extends Cubit<RegisterState> {
  final AuthRepository _repository;
  final AuthenticationCubit _authenticationCubit;

  RegisterCubit(
      this._repository,
      this._authenticationCubit,
      ) : super(const RegisterState.initial());

  Future<void> register({
    required String name,
    required String email,
    required String password,
  }) async {
    if (name.trim().isEmpty) {
      emit(const RegisterState.error('Please enter your name'));
      return;
    }

    if (email.trim().isEmpty) {
      emit(const RegisterState.error('Please enter your email'));
      return;
    }

    if (!_isValidEmail(email.trim())) {
      emit(const RegisterState.error('Please enter a valid email'));
      return;
    }

    if (password.isEmpty) {
      emit(const RegisterState.error('Please enter your password'));
      return;
    }

    if (password.length < 6) {
      emit(const RegisterState.error(
        'Password must be at least 6 characters',
      ));
      return;
    }

    emit(const RegisterState.loading());

    try {
      await _repository.register(
        name: name.trim(),
        email: email.trim(),
        password: password,
      );

      await _authenticationCubit.loadData();

      if (!isClosed) {
        emit(const RegisterState.success());
      }
    } catch (e) {
      if (!isClosed) {
        emit(RegisterState.error(
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

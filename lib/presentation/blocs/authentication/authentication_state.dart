import 'package:freezed_annotation/freezed_annotation.dart';

import '../../../data/models/user_model.dart';

part 'authentication_state.freezed.dart';

@freezed
abstract class AuthenticationState with _$AuthenticationState {
  const factory AuthenticationState.initial() = _Initial;

  const factory AuthenticationState.loading() = _Loading;

  const factory AuthenticationState.authenticated(
      UserModel user,
      ) = _Authenticated;

  const factory AuthenticationState.unauthenticated() =
  _Unauthenticated;

  const factory AuthenticationState.error(String message) = _Error;
}
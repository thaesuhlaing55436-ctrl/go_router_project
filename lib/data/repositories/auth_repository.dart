import 'package:firebase_auth/firebase_auth.dart';
import 'package:injectable/injectable.dart';

import '../models/user_model.dart';
import '../services/auth_service.dart';
import '../services/storage_service.dart';

@lazySingleton
class AuthRepository {
  final AuthService _authService;
  final StorageService _storageService;

  AuthRepository(
      this._authService,
      this._storageService,
      );

  UserModel _mapUser(User user) {
    return UserModel(
      uid: user.uid,
      email: user.email ?? '',
      displayName: user.displayName,
    );
  }


  Future<UserModel?> getCurrentUser() async {
    final user = FirebaseAuth.instance.currentUser;

    if (user == null) {
      await _storageService.clearUser();
      return null;
    }

    final userModel = _mapUser(user);

    await _storageService.saveUser(userModel);

    return userModel;
  }

  Future<void> login({
    required String email,
    required String password,
  }) async {
    await _authService.login(
      email: email,
      password: password,
    );
  }

  Future<void> register({
    required String email,
    required String password,
    required String name,
  }) async {
    await _authService.register(
      email: email,
      password: password,
      name: name,
    );
  }

  Future<void> logout() async {
    await _authService.logout();
  }
}
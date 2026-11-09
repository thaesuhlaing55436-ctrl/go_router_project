import 'dart:convert';

import 'package:injectable/injectable.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../models/user_model.dart';

@lazySingleton
class StorageService {
  final SharedPreferences _preferences;

  StorageService(this._preferences);

  Future<void> saveUser(UserModel user) async {
    await _preferences.setString(
      'user_data',
      jsonEncode(user.toJson()),
    );
  }

  Future<UserModel?> getUser() async {
    final data = _preferences.getString('user_data');

    if (data == null) return null;

    return UserModel.fromJson(jsonDecode(data));
  }

  Future<void> clearUser() async {
    await _preferences.remove('user_data');
  }
}
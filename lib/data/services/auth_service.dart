
import 'package:firebase_auth/firebase_auth.dart';
import 'package:injectable/injectable.dart';

@lazySingleton
class AuthService {
  final FirebaseAuth _firebaseAuth;

  AuthService(this._firebaseAuth);

  Stream<User?> get authStateChanges => _firebaseAuth.userChanges();

  Future<UserCredential> login({
    required String email,
    required String password,
  }) async {
    try {
      return await _firebaseAuth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
    } on FirebaseAuthException catch (e) {
      throw Exception(_loginErrorMessage(e.code));
    }
  }

  Future<UserCredential> register({
    required String email,
    required String password,
    required String name,
  }) async {
    try {
      final credential =
      await _firebaseAuth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );

      await credential.user!.updateDisplayName(name);
      await credential.user!.reload();

      return credential;
    } on FirebaseAuthException catch (e) {
      throw Exception(_registerErrorMessage(e.code));
    }
  }

  String _loginErrorMessage(String code) {
    switch (code) {
      case 'invalid-credential':
      case 'wrong-password':
      case 'user-not-found':
        return 'Invalid email or password';

      case 'invalid-email':
        return 'Please enter a valid email';

      case 'user-disabled':
        return 'This account has been disabled';

      case 'too-many-requests':
        return 'Too many attempts. Please try again later';

      case 'network-request-failed':
        return 'Please check your internet connection';

      default:
        return 'Login failed. Please try again';
    }
  }

  String _registerErrorMessage(String code) {
    switch (code) {
      case 'email-already-in-use':
        return 'This email is already registered';

      case 'invalid-email':
        return 'Please enter a valid email';

      case 'weak-password':
        return 'Password must be at least 6 characters';

      case 'operation-not-allowed':
        return 'Email registration is currently unavailable';

      case 'network-request-failed':
        return 'Please check your internet connection';

      default:
        return 'Registration failed. Please try again';
    }
  }

  Future<void> logout() async {
    await _firebaseAuth.signOut();
  }
}

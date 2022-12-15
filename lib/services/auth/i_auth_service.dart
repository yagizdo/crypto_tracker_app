import 'package:firebase_auth/firebase_auth.dart';

abstract class IAuthService{
  Future<void> reloadUser();
  Future<void> logout();
  Future<void> sendVerificationMail();
  Future<void> sendResetPasswordMail({required String userEmail});
  Stream<User?>? authStateChanges();
  Future<User?> registerWithEmailAndPassword({required String userEmail, required String userPassword});
  Future<User?> signInWithEmailAndPassword({required String userEmail, required String userPassword});
  Future<User?> signInWithGoogle();
  Future<User?> signInWithApple();
}
import 'package:crypto_tracker/services/auth/i_auth_service.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:google_sign_in/google_sign_in.dart';

import '../../utils/extensions/auth_exception_handler.dart';
import '../locator.dart';
import '../navigation_service.dart';

class AuthService extends IAuthService {
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  final NavigationService _navigationService = getIt<NavigationService>();
  late User? _user;
  get currentUser => _firebaseAuth.currentUser;
  get isUserEmailVerified => _firebaseAuth.currentUser?.emailVerified;



  @override
  Future<void> reloadUser() async {
    await _firebaseAuth.currentUser!.reload();
  }

  @override
  Future<void> logout() async {
    if (_firebaseAuth.currentUser != null) {
      await _firebaseAuth.signOut();
      await GoogleSignIn().signOut();
    }
  }

  @override
  Stream<User?>? authStateChanges() {
    return _firebaseAuth.authStateChanges();
  }


  @override
  Future<void> sendResetPasswordMail({required String userEmail}) async {
    try {
      await _firebaseAuth.sendPasswordResetEmail(email: userEmail);
      _navigationService.showSuccessSnackbar(errorMessage: 'If the email address is valid, you will receive a password reset email shortly.');
    } on FirebaseAuthException catch (e) {
      var exceptionMessage = AuthExceptionHandler.generateExceptionMessage(e);
      _navigationService.showSuccessSnackbar(errorMessage: 'If the email address is valid, you will receive a password reset email shortly.');
      debugPrint('Error: $exceptionMessage');

    } catch(e) {
      _navigationService.showErrorSnackbar(errorMessage: 'Tanimlanmamis bir hata olustu..');
      print('Tanimlanmamis hata kodu: ${e}');
    }

  }

  @override
  Future<void> sendVerificationMail() async {
    try {
      await _firebaseAuth.currentUser!.sendEmailVerification();
    } on FirebaseAuthException catch (e) {
      var exceptionMessage = AuthExceptionHandler.generateExceptionMessage(e);
      _navigationService.showErrorSnackbar(errorMessage: exceptionMessage);

    } catch(e) {
      _navigationService.showErrorSnackbar(errorMessage: 'Tanimlanmamis bir hata olustu..');
      print('Tanimlanmamis hata kodu: ${e}');
    }
  }


  @override
  Future<User?> registerWithEmailAndPassword({required String userEmail, required String userPassword}) async {
   UserCredential? userCredential;
    try {
      userCredential = await _firebaseAuth.createUserWithEmailAndPassword(
          email: userEmail, password: userPassword);
   } on FirebaseAuthException catch (e) {
      var exceptionMessage = AuthExceptionHandler.generateExceptionMessage(e);
      _navigationService.showErrorSnackbar(errorMessage: exceptionMessage);

    } catch(e) {
      _navigationService.showErrorSnackbar(errorMessage: 'Tanimlanmamis bir hata olustu..');
      print('Tanimlanmamis hata kodu: ${e}');
    }
   _user = userCredential?.user;
   return _user;
  }

  @override
  Future<User?> signInWithEmailAndPassword({required String userEmail, required String userPassword}) async {
    UserCredential? userCredential;
    try {
      userCredential = await _firebaseAuth.signInWithEmailAndPassword(
          email: userEmail, password: userPassword);
    } on FirebaseAuthException catch (e) {
      var exceptionMessage = AuthExceptionHandler.generateExceptionMessage(e);
      _navigationService.showErrorSnackbar(errorMessage: exceptionMessage);

    } catch(e) {
      _navigationService.showErrorSnackbar(errorMessage: 'Tanimlanmamis bir hata olustu..');
      print('Tanimlanmamis hata kodu: ${e}');
    }
    _user = userCredential?.user;
    return _user;
  }

  @override
  Future<User?> signInWithGoogle() async {
    UserCredential? userCredential;
    try {
      // Trigger the authentication flow
      final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();

      if(googleUser != null) {
        // Obtain the auth details from the request
        final GoogleSignInAuthentication? googleAuth = await googleUser?.authentication;

        // Create a new credential
        final OAuthCredential credential = GoogleAuthProvider.credential(
          accessToken: googleAuth?.accessToken,
          idToken: googleAuth?.idToken,
        );

        // Once signed in, return the UserCredential
        userCredential = await _firebaseAuth.signInWithCredential(credential);

      } else {
        return null;
      }
    } on FirebaseAuthException catch(e) {
      var exceptionMessage = AuthExceptionHandler.generateExceptionMessage(e);
      _navigationService.showErrorSnackbar(errorMessage: exceptionMessage);
    } catch(e) {
      _navigationService.showErrorSnackbar(errorMessage: 'Tanimlanamayan bir hata olustu..');
    }
    // Return Firebase User
    _user = userCredential?.user;

    return _user;
  }
  
}
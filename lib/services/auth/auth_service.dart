import 'dart:convert';
import 'dart:math';

import 'package:crypto/crypto.dart';
import 'package:crypto_tracker/services/auth/i_auth_service.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:sign_in_with_apple/sign_in_with_apple.dart';

import '../../utils/extensions/auth_exception_handler.dart';
import '../locator.dart';
import '../navigation_service.dart';

class AuthService extends IAuthService {
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  final NavigationService _navigationService = getIt<NavigationService>();
  late User? _user;
  get currentUser => _firebaseAuth.currentUser;
  get isUserEmailVerified => _firebaseAuth.currentUser?.emailVerified;


  // FOR APPLE SIGN IN //
  /// Generates a cryptographically secure random nonce, to be included in a
  /// credential request.
  String generateNonce([int length = 32]) {
    const charset =
        '0123456789ABCDEFGHIJKLMNOPQRSTUVXYZabcdefghijklmnopqrstuvwxyz-._';
    final random = Random.secure();
    return List.generate(length, (_) => charset[random.nextInt(charset.length)])
        .join();
  }

  /// Returns the sha256 hash of [input] in hex notation.
  String sha256ofString(String input) {
    final bytes = utf8.encode(input);
    final digest = sha256.convert(bytes);
    return digest.toString();
  }

  // END OF APPLE SIGN IN //

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

  @override
  Future<User?> signInWithApple() async {
    if(!await SignInWithApple.isAvailable()) {
      _navigationService.showErrorSnackbar(errorMessage: 'Apple ile giris yapilamadi..');
      return null;
    }
    UserCredential? userCredential;

    try {
      // To prevent replay attacks with the credential returned from Apple, we
      // include a nonce in the credential request. When signing in with
      // Firebase, the nonce in the id token returned by Apple, is expected to
      // match the sha256 hash of `rawNonce`.
      final rawNonce = generateNonce();
      final nonce = sha256ofString(rawNonce);

      // Request credential for the currently signed in Apple account.
      final appleCredential = await SignInWithApple.getAppleIDCredential(
        scopes: [
          AppleIDAuthorizationScopes.email,
          AppleIDAuthorizationScopes.fullName,
        ],
        nonce: nonce,
      );

      // Create an `OAuthCredential` from the credential returned by Apple.
      final oauthCredential = OAuthProvider("apple.com").credential(
        idToken: appleCredential.identityToken,
        rawNonce: rawNonce,
      );

      // Sign in the user with Firebase. If the nonce we generated earlier does
      // not match the nonce in `appleCredential.identityToken`, sign in will fail.
      userCredential = await _firebaseAuth.signInWithCredential(oauthCredential);
    } on FirebaseAuthException catch(e) {
      var exceptionMessage = AuthExceptionHandler.generateExceptionMessage(e);
      _navigationService.showErrorSnackbar(errorMessage: exceptionMessage);
    } on SignInWithAppleAuthorizationException catch(e) {
      print('Apple ile giris yapilamadi: ${e.code}');
      var exceptionMessage = AuthExceptionHandler.generateExceptionMessage(e);
      _navigationService.showErrorSnackbar(errorMessage: exceptionMessage);
    } catch(e) {
      _navigationService.showErrorSnackbar(errorMessage: 'Tanimlanamayan bir hata olustu..');
    }
    _user = userCredential?.user;
    return _user;
  }
  
}
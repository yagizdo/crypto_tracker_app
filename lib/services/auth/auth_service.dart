import 'dart:convert';
import 'dart:math';

import 'package:crypto/crypto.dart';
import 'package:crypto_tracker/i18n/locale_keys.g.dart';
import 'package:crypto_tracker/services/auth/i_auth_service.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:firebase_auth/firebase_auth.dart';
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
    if (_firebaseAuth.currentUser != null) {
      await _firebaseAuth.currentUser!.reload();
    }
  }

  @override
  Future<bool> getUserEmailStatus() async {
   return _firebaseAuth.currentUser?.emailVerified ?? false;

  }


  @override
  Future<void> logout() async {
    if (_firebaseAuth.currentUser != null) {
      await _firebaseAuth.signOut();
      await GoogleSignIn().signOut();
    }
  }

  @override
  Future<void> deleteAccount({required String userEmail, required String userPassword}) async {
    final currentUser = _firebaseAuth.currentUser;
    if (currentUser != null) {
      try {
        final credential = EmailAuthProvider.credential(
            email: userEmail, password: userPassword);
        await currentUser.reauthenticateWithCredential(credential);
        await currentUser.delete().then((value) => _navigationService.navigateBackToAuth());
      } on FirebaseAuthException catch (e) {
        var exceptionMessage = AuthExceptionHandler.generateExceptionMessage(e);
        _navigationService.showErrorSnackbar(errorMessage: exceptionMessage);

      } catch(e) {
        _navigationService.showErrorSnackbar(errorMessage: LocaleKeys.errors_undefinied.tr());
      }
    }
  }

  @override
  Stream<User?>? authStateChanges() {
    return _firebaseAuth.authStateChanges();
  }

  Future<void> updateUserName({required String name}) async {
    try {
      await _firebaseAuth.currentUser?.updateDisplayName(name);
    } catch (e) {
      var errorMessage = AuthExceptionHandler.generateExceptionMessage(e);
      _navigationService.showErrorSnackbar(errorMessage: errorMessage);
    }
  }


  @override
  Future<void> sendResetPasswordMail({required String userEmail}) async {
    try {
      await _firebaseAuth.sendPasswordResetEmail(email: userEmail);
      _navigationService.showSuccessSnackbar(errorMessage: LocaleKeys.errors_email_send.tr());
    } on FirebaseAuthException catch (e) {
      var exceptionMessage = AuthExceptionHandler.generateExceptionMessage(e);
      _navigationService.showSuccessSnackbar(errorMessage: exceptionMessage);

    } catch(e) {
      _navigationService.showErrorSnackbar(errorMessage: LocaleKeys.errors_undefinied.tr());
    }

  }

  @override
  Future<void> sendVerificationMail() async {
    try {
      await _firebaseAuth.currentUser!.sendEmailVerification();
      _navigationService.showSuccessSnackbar(errorMessage: LocaleKeys.errors_email_send.tr());
    } on FirebaseAuthException catch (e) {
      var exceptionMessage = AuthExceptionHandler.generateExceptionMessage(e);
      _navigationService.showErrorSnackbar(errorMessage: exceptionMessage);

    } catch(e) {
      _navigationService.showErrorSnackbar(errorMessage: LocaleKeys.errors_undefinied.tr());
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
      _navigationService.showErrorSnackbar(errorMessage: LocaleKeys.errors_undefinied.tr());
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
      _navigationService.showErrorSnackbar(errorMessage: LocaleKeys.errors_undefinied.tr());
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
      _navigationService.showErrorSnackbar(errorMessage: LocaleKeys.errors_undefinied.tr());
    }
    // Return Firebase User
    _user = userCredential?.user;

    return _user;
  }

  @override
  Future<User?> signInWithApple() async {
    if(!await SignInWithApple.isAvailable()) {
      _navigationService.showErrorSnackbar(errorMessage: LocaleKeys.errors_apple_unsupported_device.tr());
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

      // Because apple sign in return user's name on first time. But name is return null was creating firebase user.
      // So we need to update user's name.
      // If user's name is null and user's name (in Apple Credential) is not null, we update user's name.
      if (userCredential.user?.displayName == null && appleCredential.givenName != null) {
        await userCredential.user?.updateDisplayName(appleCredential.givenName);
      }
    } on FirebaseAuthException catch(e) {
      var exceptionMessage = AuthExceptionHandler.generateExceptionMessage(e);
      _navigationService.showErrorSnackbar(errorMessage: exceptionMessage);
    } on SignInWithAppleAuthorizationException catch(e) {
      var exceptionMessage = AuthExceptionHandler.generateExceptionMessage(e);
      _navigationService.showErrorSnackbar(errorMessage: exceptionMessage);
    } catch(e) {
      _navigationService.showErrorSnackbar(errorMessage: LocaleKeys.errors_undefinied.tr());
    }
    _user = userCredential?.user;
    return _user;
  }
  
}
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:crypto_tracker/i18n/locale_keys.g.dart';
import 'package:crypto_tracker/services/database/i_database_service.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';

import '../../utils/extensions/auth_exception_handler.dart';
import '../locator.dart';
import '../navigation_service.dart';

class DatabaseService extends IDatabaseService {
  final CollectionReference _users = FirebaseFirestore.instance.collection('users');
  final CollectionReference _favorites = FirebaseFirestore.instance.collection('favorites');
  final NavigationService _navigationService = getIt<NavigationService>();

  @override
  Future<void> saveUserInDatabase(User user) async {
    try {
      await _users.doc(user.uid).set(
        {
          'id': user.uid,
          'name': user.displayName,
          'email': user.email,
          'photoUrl': user.photoURL,
        },
      );
    } catch (e) {
      var errorMessage = AuthExceptionHandler.generateExceptionMessage(e);
      _navigationService.showErrorSnackbar(errorMessage: errorMessage);
      kDebugMode ? debugPrint(e.toString()) : null;
    }
  }

  @override
  Future<void> deleteUserInDatabase({required String userUID}) async {
    try {
      await _users.doc(userUID).delete();
    } catch (e) {
      var errorMessage = AuthExceptionHandler.generateExceptionMessage(e);
      _navigationService.showErrorSnackbar(errorMessage: errorMessage);
      kDebugMode ? debugPrint(e.toString()) : null;
    }
  }

  @override
  Future<void> updateUserInDatabase(User user) {
    // TODO: implement updateUserInDatabase
    throw UnimplementedError();
  }

  @override
  Future<List<dynamic>> getFavorites({required String userUID}) async {
    List favorites;
    try {
      favorites = await _favorites.doc(userUID).get().then((DocumentSnapshot documentSnapshot) {
        return documentSnapshot.exists ? documentSnapshot.get('favorites') : [];
      });
    } catch (e) {
      _navigationService.showErrorSnackbar(errorMessage: LocaleKeys.errors_custom_error.tr());
      kDebugMode ? debugPrint(e.toString()) : null;
      return [];
    }
    return favorites;
  }

  @override
  Future<void> saveFavorites({required List favorites, required String userUID}) async {
    await _favorites.doc(userUID).set({
      'favorites' : favorites
    });
  }


}

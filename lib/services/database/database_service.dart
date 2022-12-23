import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:crypto_tracker/services/database/i_database_service.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';

import '../../utils/extensions/auth_exception_handler.dart';
import '../locator.dart';
import '../navigation_service.dart';

class DatabaseService extends IDatabaseService {
  final CollectionReference _users =
      FirebaseFirestore.instance.collection('users');
  final CollectionReference _customLists =
      FirebaseFirestore.instance.collection('customLists');
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
  Future<List<dynamic>> getFavorites({required String userUID}) async {
    try {
      return await _customLists
          .doc(userUID)
          .get()
          .then((DocumentSnapshot documentSnapshot) {
        return documentSnapshot.exists ? documentSnapshot.get('favorites') : [];
      });
    } catch (e) {
      kDebugMode ? debugPrint(e.toString()) : null;
      rethrow;
    }
  }

  @override
  Future<void> saveFavorites(
      {required List favorites, required String userUID}) async {
    await _customLists.doc(userUID).set({
      'favorites': favorites,
    }, SetOptions(merge: true));
  }

  @override
  Future<List<String>> getAllCustomLists({required String userUID}) {
    try {
      return _customLists
          .doc(userUID)
          .get()
          .then((DocumentSnapshot documentSnapshot) {
        // documentSnapshot.data() is Object? so we need to convert to map first
        Map<String, dynamic> customListsMap =
            documentSnapshot.data() as Map<String, dynamic>;

        var keys = customListsMap.keys.toList();

        List<String> customListsNames = [];

        for (var i = 0; i < keys.length; i++) {
          customListsNames.add(keys[i]);
        }

        return customListsNames;
      });
    } catch (e) {
      kDebugMode ? debugPrint(e.toString()) : null;
      rethrow;
    }
  }

  @override
  Future<void> saveCustomLists(
      {required List listItems,
      required String userUID,
      required String customListName}) {
    try {
      return _customLists.doc(userUID).set({
        customListName: listItems,
      }, SetOptions(merge: true));
    } catch (e) {
      kDebugMode ? debugPrint(e.toString()) : null;
      rethrow;
    }
  }

  @override
  Future<List> getCustomList(
      {required String userUID, required String customListName}) {
    try {
      return _customLists
          .doc(userUID)
          .get()
          .then((DocumentSnapshot documentSnapshot) {
        return documentSnapshot.exists
            ? documentSnapshot.get(customListName)
            : [];
      });
    } catch (e) {
      kDebugMode ? debugPrint(e.toString()) : null;
      rethrow;
    }
  }
  @override
  Future<int> getListItemCount({required String listName, required String userUID}) async {
    List customList = await getCustomList(
        userUID: userUID, customListName: listName);

    return customList.length;
  }
}

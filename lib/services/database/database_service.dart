import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:crypto_tracker/services/database/i_database_service.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';

import '../../utils/extensions/auth_exception_handler.dart';
import '../locator.dart';
import '../navigation_service.dart';

class DatabaseService extends IDatabaseService {
  CollectionReference _users = FirebaseFirestore.instance.collection('users');
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
  Future<List<User>> getAllUsersInDatabase() async {
    List<User> users = [];

    _users.get().then((QuerySnapshot querySnapshot) {
      querySnapshot.docs.forEach((doc) {
        print(doc['id']);
      });
    });
    return users;
  }

  @override
  Future<User> getUserByIDInDatabase(String id) {
    // TODO: implement getUserInDatabase
    throw UnimplementedError();
  }

  @override
  Future<void> updateUserInDatabase(User user) {
    // TODO: implement updateUserInDatabase
    throw UnimplementedError();
  }
}

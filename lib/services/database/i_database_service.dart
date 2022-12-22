import 'package:firebase_auth/firebase_auth.dart';

abstract class IDatabaseService {
  Future<void> saveUserInDatabase(User user);
  Future<void> deleteUserInDatabase({required String userUID});
  Future<void> updateUserInDatabase(User user);
  Future<void> saveFavorites({required List<dynamic> favorites, required String userUID});
  Future<List<dynamic>> getFavorites({required String userUID});
}
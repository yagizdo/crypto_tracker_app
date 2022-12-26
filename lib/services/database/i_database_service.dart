import 'package:firebase_auth/firebase_auth.dart';

abstract class IDatabaseService {
  Future<void> saveUserInDatabase(User user);
  Future<void> deleteUserInDatabase({required String userUID});
  Future<void> saveFavorites({required List<dynamic> favorites, required String userUID});
  Future<void> saveCustomLists({required List<dynamic> listItems, required String userUID, required String customListName});
  Future<void> deleteCustomLists({required String userUID, required String customListName});
  Future<void> initializeUser({required String userUID});
  Future<List<dynamic>> getFavorites({required String userUID});
  Future<List<String>> getAllCustomLists({required String userUID});
  Future<List<dynamic>> getCustomList({required String userUID, required String customListName});
  Future<int> getListItemCount({required String listName, required String userUID});
}
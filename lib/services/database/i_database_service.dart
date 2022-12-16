import 'package:firebase_auth/firebase_auth.dart';

abstract class IDatabaseService {
  Future<void> saveUser(User user);
  Future<void> deleteUser(User user);
  Future<void> updateUser(User user);
  Future<User> getUser(String id);
  Future<List<User>> getAllUsers();
}
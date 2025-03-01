import '../../models/user.dart';

abstract class UserRepository {
  Future<Map<String, dynamic>> addUser(User user);
  Future<Map<String, String>> updateUser(User user);
  Future<Map<String, String>> deleteUser(String userId);
  Future<Map<String, dynamic>> getUserById(String userId);
  Future<Map<String, dynamic>> getUsers();
  Future<Map<String, String>> updateUserStatus(String userId, bool isActive);
  Future<Map<String, String>> updateUserPrivilege(String userId, Privilege privilege);
  Future<Map<String, dynamic>> getUserFavourites(String userId);
  Future<Map<String, String>> addTestToFavourites(String userId, String testId);
  Future<Map<String, String>> removeTestFromFavourites(String userId, String testId);
}

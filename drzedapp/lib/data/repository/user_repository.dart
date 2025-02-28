import '../../models/user.dart';

abstract class UserRepository {
  Future<void> addUser(User user);
  Future<void> updateUser(User user);
  Future<void> deleteUser(String userId);
  Future<User?> getUserById(String userId);
  Future<List<User>> getUsers();
  Future<void> updateUserStatus(String userId, bool isActive);
  Future<void> updateUserPrivilege(String userId, Privilege privilege);
  Future<List<String>> getUserFavourites(String userId);
  Future<void> addTestToFavourites(String userId, String testId);
  Future<void> removeTestFromFavourites(String userId, String testId);
}

import '../../data/repository/user_repository.dart';
import '../../models/user.dart';

class UserUseCase {
  final UserRepository _userRepository;

  UserUseCase(this._userRepository);

  Future<void> addUser(User user) async {
    await _userRepository.addUser(user);
  }

  Future<void> updateUser(User user) async {
    await _userRepository.updateUser(user);
  }

  Future<void> deleteUser(String userId) async {
    await _userRepository.deleteUser(userId);
  }

  Future<User?> getUserById(String userId) async {
    return await _userRepository.getUserById(userId);
  }

  Future<List<User>> getUsers() async {
    return await _userRepository.getUsers();
  }

  Future<void> updateUserStatus(String userId, bool isActive) async {
    await _userRepository.updateUserStatus(userId, isActive);
  }

  Future<void> updateUserPrivilege(String userId, Privilege privilege) async {
    await _userRepository.updateUserPrivilege(userId, privilege);
  }

  // Get a user's favorite test IDs
  Future<List<String>> getUserFavourites(String userId) async {
    return await _userRepository.getUserFavourites(userId);
  }

  // Add a test to user's favorites
  Future<void> addTestToFavourites(String userId, String testId) async {
    await _userRepository.addTestToFavourites(userId, testId);
  }

  // Remove a test from user's favorites
  Future<void> removeTestFromFavourites(String userId, String testId) async {
    await _userRepository.removeTestFromFavourites(userId, testId);
  }
}

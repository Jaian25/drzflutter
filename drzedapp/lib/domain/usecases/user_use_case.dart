import '../../data/repository/user_repository.dart';
import '../../models/user.dart';

class UserUseCase {
  final UserRepository _userRepository;

  UserUseCase(this._userRepository);

  Future<Map<String, dynamic>> addUser(User user) async {
    return await _userRepository.addUser(user);
  }

  Future<Map<String, String>> updateUser(User user) async {
    return await _userRepository.updateUser(user);
  }

  Future<Map<String, String>> deleteUser(String userId) async {
    return await _userRepository.deleteUser(userId);
  }

  Future<Map<String, dynamic>> getUserById(String userId) async {
    return await _userRepository.getUserById(userId);
  }

  Future<Map<String, dynamic>> getUsers() async {
    return await _userRepository.getUsers();
  }

  Future<Map<String, String>> updateUserStatus(String userId, bool isActive) async {
    return await _userRepository.updateUserStatus(userId, isActive);
  }

  Future<Map<String, String>> updateUserPrivilege(String userId, Privilege privilege) async {
    return await _userRepository.updateUserPrivilege(userId, privilege);
  }

  Future<Map<String, dynamic>> getUserFavourites(String userId) async {
    return await _userRepository.getUserFavourites(userId);
  }

  Future<Map<String, String>> addTestToFavourites(String userId, String testId) async {
    return await _userRepository.addTestToFavourites(userId, testId);
  }

  Future<Map<String, String>> removeTestFromFavourites(String userId, String testId) async {
    return await _userRepository.removeTestFromFavourites(userId, testId);
  }
}

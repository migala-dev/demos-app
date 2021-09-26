import 'dart:io';
import 'package:demos_app/core/api/user.api.dart';
import 'package:demos_app/core/models/user.model.dart';
import 'package:demos_app/core/repositories/users.repository.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class CurrentUserService {
  User? _currentUser;
  String _currentUserIdKey = 'current-user-id-key';
  final _storage = new FlutterSecureStorage();
  static CurrentUserService _userService = new CurrentUserService._internal();

  CurrentUserService._internal();

  factory CurrentUserService() {
    return _userService;
  }

  Future<User?> getCurrentUser() async {
    if (_currentUser == null) {
      String? currentUserId = await _storage.read(key: _currentUserIdKey);
      if (currentUserId != null) {
        User? user = await UsersRepository().findById(currentUserId);
        _currentUser = user;
        return user;
      }
    }

    return _currentUser;
  }

  Future<void> setCurrentUser(String? userId) async {
    await _storage.write(key: _currentUserIdKey, value: userId.toString());
  }

  Future<User?> updateUserName(String? name) async {
    User userSaved = await UserApi.updateUserName(name);
    
    UsersRepository().updateUser(userSaved);

    _currentUser = userSaved;

    return userSaved;
  }

  Future<User?> uploadProfileImage(File file) async {
    User? userSaved = await UserApi.uploadProfileImage(file);

    UsersRepository().updateUser(userSaved!);

    _currentUser = userSaved;

    return userSaved;
  }
}

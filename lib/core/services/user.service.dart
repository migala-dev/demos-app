import 'dart:io';

import 'package:demos_app/constans/api_path.dart';
import 'package:demos_app/core/models/user.model.dart';
import 'package:demos_app/core/repositories/users.repository.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

import 'api_service.dart';

class UserService {
  User? _currentUser;
  String _currentUserIdKey = 'current-user-id-key';
  final _storage = new FlutterSecureStorage();
  static UserService _userService = new UserService._internal();

  UserService._internal();

  factory UserService() {
    return _userService;
  }

  Future<User?> getCurrentUser() async {
    if (_currentUser == null) {
      String? currentUserId = await _storage.read(key: _currentUserIdKey);
      if (currentUserId != null) {
        User? user = await UsersRepository().findById(int.parse(currentUserId));
        _currentUser = user;
        return user;
      }
    }

    return _currentUser;
  }

  Future<void> setCurrentUser(int? userId) async {
    await _storage.write(key: _currentUserIdKey, value: userId.toString());
  }

  Future<User?> updateUserName(String? name) async {
    String endpoint = ApiPath().getUserPath();

    Object params = {'name': name};

    final httpResponse = await ApiSerivce().patch(endpoint, params);

    User userSaved = User.fromObject(httpResponse);

    UsersRepository().updateUser(userSaved);

    return userSaved;
  }

  Future<User?> uploadProfileImage(File file) async {
    String endpoint = ApiPath().getUpdateProfileImagePath();

    final httpResponse = await ApiSerivce().upload(endpoint, file);

    User userSaved = User.fromObject(httpResponse);

    UsersRepository().updateUser(userSaved);

    return userSaved;
  }
}

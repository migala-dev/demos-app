import 'dart:io';
import 'package:demos_app/core/api/user.api.dart';
import 'package:demos_app/core/models/user.model.dart';
import 'package:demos_app/core/repositories/users.repository.dart';

class CurrentUserService {
  static final CurrentUserService _userService = CurrentUserService._internal();
  CurrentUserService._internal();
  factory CurrentUserService() => _userService;

  Future<User?> updateUserName(String? name) async {
    User userSaved = await UserApi.updateUserName(name);

    UsersRepository().updateUser(userSaved);

    return userSaved;
  }

  Future<User?> uploadProfileImage(File file) async {
    User? userSaved = await UserApi.uploadProfileImage(file);

    UsersRepository().updateUser(userSaved!);

    return userSaved;
  }
}

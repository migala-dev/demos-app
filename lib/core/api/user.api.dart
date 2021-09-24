import 'dart:io';
import 'package:demos_app/constans/api_path.dart';
import 'package:demos_app/core/models/user.model.dart';
import 'api.dart';

class UserApi {
  static final UserApi _userApi = UserApi._internal();
  UserApi._internal();

  factory UserApi() {
    return _userApi;
  }

  static Future<User> updateUserName(String? name) async {
    String endpoint = ApiPath().getUserPath();

    Object params = {'name': name};

    final httpResponse = await Api.patch(endpoint, params);

    User user = User.fromObject(httpResponse);

    return user;
  }

  static Future<User?> uploadProfileImage(File file) async {
    String endpoint = ApiPath().getUpdateProfileImagePath();

    final httpResponse = await Api.upload(endpoint, file);

    User user = User.fromObject(httpResponse);

    return user;
  }
}

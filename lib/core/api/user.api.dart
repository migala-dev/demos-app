/*
  DEMOS
  Copyright (C) 2022 Julian Alejandro Ortega Zepeda, Erik Ivanov Domínguez Rivera, Luis Ángel Meza Acosta
  This file is part of DEMOS.

  DEMOS is free software: you can redistribute it and/or modify
  it under the terms of the GNU General Public License as published by
  the Free Software Foundation, either version 3 of the License, or
  (at your option) any later version.

  DEMOS is distributed in the hope that it will be useful,
  but WITHOUT ANY WARRANTY; without even the implied warranty of
  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
  GNU General Public License for more details.

  You should have received a copy of the GNU General Public License
  along with this program.  If not, see <https://www.gnu.org/licenses/>.
*/

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

    final httpResponse = await Api.patch(endpoint, params, null);

    User user = User.fromObject(httpResponse);

    return user;
  }

  static Future<User?> uploadProfileImage(File file) async {
    String endpoint = ApiPath().getUpdateProfileImagePath();

    final httpResponse = await Api.upload(endpoint, file, null);

    User user = User.fromObject(httpResponse);

    return user;
  }
}

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

import 'package:demos_app/config/themes/cubit/request_behavior.dart';
import 'package:demos_app/constans/paths/auth.path.dart';
import 'package:demos_app/core/api/api.dart';
import 'package:demos_app/modules/auth/models/verify_code_response.model.dart';

class AuthApi {
  static final AuthApi _authApi = AuthApi._internal();

  AuthApi._internal();

  factory AuthApi() {
    return _authApi;
  }

  Future<String> signIn(String phoneNumber) async {
    String endpoint = AuthPath.getLoginPath();
    Object params = {
      'phoneNumber': phoneNumber,
    };

    final response = await Api.post(endpoint, params, RequestBehavior(showLoading: false));

    return response['session'];
  }

  Future<VerifyCodeReponse> verifyCode(
      String code, String phoneNumber, String session) async {
    String endpoint = AuthPath.getVerifyCodePath();
    Object params = {
      'phoneNumber': phoneNumber,
      'code': code,
      'session': session,
    };
    final httpResponse = await Api.post(endpoint, params, RequestBehavior(showLoading: false));

    VerifyCodeReponse response = VerifyCodeReponse.fromObject(httpResponse);

    return response;
  }
}

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

import 'package:demos_app/enviroments/enviroment.interface.dart';
import 'package:demos_app/enviroments/get_enviroment.dart';

class ApiPath {
  //  Auth paths
  String _getAuthPath() {
    Enviroment enviroment = getEnviroment();
    return '${enviroment.authServiceUrl}/auth';
  }

  String getSignInPath() {
    return '${_getAuthPath()}/login';
  }

  String getVerifyCodePath() {
    return '${_getAuthPath()}/verify-code';
  }

  String getRefreshTokenPath() {
    return '${_getAuthPath()}/refresh-tokens';
  }

  String getUserDevicePath() {
    return '${_getAuthPath()}/user-device';
  }

  //  Users paths
  String getUserPath() {
    Enviroment enviroment = getEnviroment();
    return '${enviroment.authServiceUrl}/user';
  }

  String getUpdateProfileImagePath() {
    return '${getUserPath()}/avatar';
  }

  String getWebsocketServicePath(String userId) {
    Enviroment enviroment = getEnviroment();
    return '${enviroment.websocketServiceUrl}/$userId';
  }

  String getGetCachePath() {
    Enviroment enviroment = getEnviroment();
    return '${enviroment.cacheServiceUrl}/cache';
  }
}

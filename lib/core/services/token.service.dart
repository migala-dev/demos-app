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

import 'dart:async';
import 'package:demos_app/constans/paths/auth.path.dart';
import 'package:demos_app/core/api/api.dart';
import 'package:demos_app/core/models/tokens.model.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class TokenService {
  final String _refreshTokenKey = 'refresh-token';
  String? _accessToken;
  static final TokenService _tokenService = TokenService._internal();
  final _storage = const FlutterSecureStorage();

  TokenService._internal() {
    createJobToRequestNewAccessToken();
  }

  factory TokenService() {
    return _tokenService;
  }

  String? get accessToken => _accessToken;

  Future<void> saveTokens(Tokens tokens) async {
    _accessToken = tokens.accessToken;
    await _storage.write(key: _refreshTokenKey, value: tokens.refreshToken);
  }

  Future<bool> isAuthenticate() async {
    String? value = await _getRefreshToken();

    return value != null;
  }

  void createJobToRequestNewAccessToken() {
    Duration duration = const Duration(hours: 20);
    Timer.periodic(duration, (timer) {
      refreshTokens();
    });
  }

  Future<bool> refreshTokens() async {
    String endpoint = AuthPath.getRefreshTokenPath();
    String? refreshToken = await _getRefreshToken();

    if (refreshToken == null) {
      return false;
    }

    Object params = {
      'refreshToken': refreshToken,
    };

    final httpResponse = await Api.post(endpoint, params, null);

    Tokens tokens = Tokens.fromObject(httpResponse);

    saveTokens(tokens);

    return true;
  }

  Future<String?> _getRefreshToken() async {
    return await _storage.read(key: _refreshTokenKey);
  }
}

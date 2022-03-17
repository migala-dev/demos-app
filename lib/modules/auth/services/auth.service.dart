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

import 'package:demos_app/core/bloc/current_user_bloc/current_user_bloc.dart';
import 'package:demos_app/core/models/tokens.model.dart';
import 'package:demos_app/core/models/user.model.dart';
import 'package:demos_app/core/repositories/users.repository.dart';
import 'package:demos_app/core/services/bucket.service.dart';
import 'package:demos_app/core/services/cache.service.dart';
import 'package:demos_app/core/services/general_spaces.service.dart';
import 'package:demos_app/core/services/token.service.dart';
import 'package:demos_app/core/services/websocket.service.dart';
import 'package:demos_app/modules/auth/api/auth.api.dart';
import 'package:demos_app/modules/auth/models/verify_code_response.model.dart';
import 'package:demos_app/utils/ui/toast.util.dart';

class AuthService {
  String? _phoneNumber;
  String? _session;
  int _attemptCount = 0;
  final int _totalOfAttempts = 3;
  static final AuthService _authService = AuthService._internal();
  AuthService._internal();

  factory AuthService() {
    return _authService;
  }

  Future<bool> resendCode() async {
    return signIn(_phoneNumber ?? '');
  }

  Future<bool> signIn(String phoneNumber) async {
    _phoneNumber = phoneNumber;

    String session = await AuthApi().signIn(phoneNumber);
    _session = session;
    _attemptCount = _totalOfAttempts;

    return true;
  }

  Future<User?> verifyCode(String code) async {
    VerifyCodeReponse response =
        await AuthApi().verifyCode(code, _phoneNumber!, _session!);

    if (!_isCodeValid(response)) {
      _attemptCount -= 1;
      String message =
          'Código de verificación incorrecto, intentos restantes: $_attemptCount';
      _session = response.session;

      ToastUtil.showError(message);

      return null;
    }

    await _saveUser(response);

    await _saveTokens(response);

    await BucketService().setBucketName(response.bucketName!);

    await GeneralSpaceService().getUserSpaces();

    createWebSocketConnection(response.user);

    CacheService().getCache();

    return response.user;
  }

  bool _isCodeValid(VerifyCodeReponse response) {
    return response.session == null;
  }

  Future<void> _saveUser(VerifyCodeReponse response) async {
    User? user = response.user;
    if (user != null) {
      await UsersRepository().insert(user);

      CurrentUserBloc().add(CurrentUserSetted(user.userId!));
    }
  }

  Future<void> _saveTokens(VerifyCodeReponse response) async {
    Tokens? tokens = response.tokens;
    if (tokens != null) {
      await TokenService().saveTokens(tokens);
    }
  }

  void createWebSocketConnection(User? user) {
    WebSocketService webSocketService = WebSocketService();
    webSocketService.createConnection(user!.userId!);
  }

  String? getPhoneNumber() {
    return _phoneNumber;
  }
}

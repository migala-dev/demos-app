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

import 'package:demos_app/core/services/cache.service.dart';
import 'package:demos_app/core/services/current_user/current_user.storage.dart';
import 'package:demos_app/core/services/token.service.dart';
import 'package:demos_app/core/services/websocket.service.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'core/bloc/current_user_bloc/current_user_bloc.dart';
import 'core/services/current_user/current_user_private_key.dart';

class AppInitializer {
  static final _appInitializer = AppInitializer._internal();
  AppInitializer._internal();
  factory AppInitializer() => _appInitializer;

  bool isAlreadyInitialize = false;

  Future<void> initApp() async {
    await clearSecureCacheIfIsTheFirstRun();
    final bool userIsAuthenticate = await TokenService().isAuthenticate();
    final String? currentUserId = await CurrentUserStorage().getCurrentUserId();

    if (!isAlreadyInitialize && userIsAuthenticate && currentUserId != null) {
      WebSocketService webSocketService = WebSocketService();
      webSocketService.createConnection(currentUserId);
      await TokenService().refreshTokens();
      await CacheService().getCache();
      await UserPrivateKey(currentUserId).generatePrivateKey();
      CurrentUserBloc().add(CurrentUserLoaded());
      isAlreadyInitialize = true;
    }
  }

  void disconnectWebsocket() {
    WebSocketService webSocketService = WebSocketService();
    webSocketService.closeConnection();

    isAlreadyInitialize = false;
  }

  Future<void> clearSecureCacheIfIsTheFirstRun() async {
  final prefs = await SharedPreferences.getInstance();

  if (Platform.isIOS && (prefs.getBool('first_run') ?? true)) {
    const FlutterSecureStorage storage = FlutterSecureStorage();

    await storage.deleteAll();

    prefs.setBool('first_run', false);
  }
}
}

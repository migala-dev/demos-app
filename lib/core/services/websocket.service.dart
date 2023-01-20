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

import 'package:demos_app/constans/paths.depracted/api_path.deprecated.dart';
import 'package:demos_app/core/services/cache.service.dart';
import 'package:web_socket_channel/io.dart';

class WebSocketService {
  final Duration pingInterval = const Duration(seconds: 2);
  static final WebSocketService _webSocketService =
      WebSocketService._internal();
  IOWebSocketChannel? connection;
  bool _isConnected = false;

  WebSocketService._internal();

  factory WebSocketService() => _webSocketService;

  void createConnection(String userId) {
    if (!_isConnected) {
      String websocketPath = ApiPathDeprecated().getWebsocketServicePath(userId);
      connection =
          IOWebSocketChannel.connect(websocketPath, pingInterval: pingInterval);
      _startListening();
    }
  }

  void _startListening() {
    if (connection == null) {
      throw 'You have to create a connection first';
    }
    _isConnected = true;

    connection!.stream.listen((event) {
      CacheService().getCache();
    });
  }

  void closeConnection() {
    connection?.sink.close();
    _isConnected = false;
  }
}

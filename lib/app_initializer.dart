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

import 'package:demos_app/core/services/cache.service.dart';
import 'package:demos_app/core/services/current_user/current_user.storage.dart';
import 'package:demos_app/core/services/token.service.dart';
import 'package:demos_app/core/services/websocket.service.dart';
import 'package:demos_app/push_notification.serivce.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

import 'core/services/current_user/current_user_private_key.dart';

class AppInitializer {
  static final _appInitializer = AppInitializer._internal();
  AppInitializer._internal();
  factory AppInitializer() => _appInitializer;

  bool isAlreadyInitialize = false;

  Future<void> initApp() async {
    final bool userIsAuthenticate = await TokenService().isAuthenticate();
    final String? currentUserId = await CurrentUserStorage().getCurrentUserId();

    if (!isAlreadyInitialize && userIsAuthenticate && currentUserId != null) {
      WebSocketService webSocketService = WebSocketService();
      webSocketService.createConnection(currentUserId);
      await TokenService().refreshTokens();
      await CacheService().getCache();
      await UserPrivateKey(currentUserId).generatePrivateKey();
      isAlreadyInitialize = true;
      await Firebase.initializeApp();
      _initializeNotifications();
    }
  }

  void disconnectWebsocket() {
    WebSocketService webSocketService = WebSocketService();
    webSocketService.closeConnection();

    isAlreadyInitialize = false;
  }

  Future<void> _initializeNotifications() async {

    /// Create a [AndroidNotificationChannel] for heads up notifications
    late AndroidNotificationChannel channel;

    /// Initialize the [FlutterLocalNotificationsPlugin] package.
    late FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin;

    if (!kIsWeb) {
      channel = const AndroidNotificationChannel(
        'high_importance_channel', // id
        'High Importance Notifications', // title
        description:
            'This channel is used for important notifications.', // description
        importance: Importance.high,
      );

      flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();

      /// Create an Android Notification Channel.
      ///
      /// We use this channel in the `AndroidManifest.xml` file to override the
      /// default FCM channel to enable heads up notifications.
      await flutterLocalNotificationsPlugin
          .resolvePlatformSpecificImplementation<
              AndroidFlutterLocalNotificationsPlugin>()
          ?.createNotificationChannel(channel);

      /// Update the iOS foreground notification presentation options to allow
      /// heads up notifications.
      await FirebaseMessaging.instance
          .setForegroundNotificationPresentationOptions(
        alert: true,
        badge: true,
        sound: true,
      );
       final pushNotificationService = PushNotificationService(flutterLocalNotificationsPlugin, channel);
      pushNotificationService.initialise();
    }
  }
}


import 'package:demos_app/modules/auth/services/auth.service.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

class PushNotificationService {
  final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin;
  final AndroidNotificationChannel channel;
  
  PushNotificationService(this.flutterLocalNotificationsPlugin, this.channel);

  Future initialise() async {
    saveUserDevice();
    startOnMessageListener();
    startOnMessageOpenedAppListener();
  }

  Future<void> saveUserDevice() async {
    String? deviceId = await FirebaseMessaging.instance.getToken();
    if (deviceId != null) {
      AuthService().saveUserDevice(deviceId);
    }
  }

  void startOnMessageListener() {
 FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      RemoteNotification? notification = message.notification;
      AndroidNotification? android = message.notification?.android;
      if (notification != null && android != null && !kIsWeb) {
        flutterLocalNotificationsPlugin.show(
          notification.hashCode,
          notification.title,
          notification.body,
          NotificationDetails(
            android: AndroidNotificationDetails(
              channel.id,
              channel.name,
              channelDescription: channel.description,
              icon: 'demos'
            ),
          ),
        );
      }
    });
  }

  void startOnMessageOpenedAppListener() {
    FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {
      print('A new onMessageOpenedApp event was published!');
    });
  }
}
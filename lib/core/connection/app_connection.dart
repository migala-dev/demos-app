import 'package:demos_app/core/models/user.model.dart';
import 'package:demos_app/core/services/cache.service.dart';
import 'package:demos_app/core/services/current_user.service.dart';
import 'package:demos_app/core/services/token.service.dart';
import 'package:demos_app/core/services/websocket.service.dart';

class AppConnection {
  static final _appConnection = AppConnection._internal();
  AppConnection._internal();
  factory AppConnection() => _appConnection;

  bool isConnected = false;

  void connectApp() async {
    if (!isConnected) {
      User? currentUser = await CurrentUserService().getCurrentUser();
      WebSocketService webSocketService = WebSocketService();
      webSocketService.createConnection(currentUser!.userId!);
      await TokenService().refreshTokens();
      CacheService().getCache();

      isConnected = true;
    }
  }

  void disconnectApp() {
    WebSocketService webSocketService = WebSocketService();
    webSocketService.closeConnection();

    isConnected = false;
  }
}

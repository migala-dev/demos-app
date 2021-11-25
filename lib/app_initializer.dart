import 'package:demos_app/core/models/user.model.dart';
import 'package:demos_app/core/services/cache.service.dart';
import 'package:demos_app/core/services/current_user.service.dart';
import 'package:demos_app/core/services/token.service.dart';
import 'package:demos_app/core/services/websocket.service.dart';

class AppInitializer {
  static final _appInitializer = AppInitializer._internal();
  AppInitializer._internal();
  factory AppInitializer() => _appInitializer;

  bool isAlreadyInitialize = false;

  Future<void> initApp() async {
    final bool userIsAuthenticate = await TokenService().isAuthenticate();
    if (!isAlreadyInitialize && userIsAuthenticate) {
      User? currentUser = await CurrentUserService().getCurrentUser();
      WebSocketService webSocketService = WebSocketService();
      webSocketService.createConnection(currentUser!.userId!);
      await TokenService().refreshTokens();
      CacheService().getCache();

      isAlreadyInitialize = true;
    }
  }

  void disconnectWebsocket() {
    WebSocketService webSocketService = WebSocketService();
    webSocketService.closeConnection();

    isAlreadyInitialize = false;
  }
}

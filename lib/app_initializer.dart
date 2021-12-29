import 'package:demos_app/core/services/cache.service.dart';
import 'package:demos_app/core/services/current_user/current_user.storage.dart';
import 'package:demos_app/core/services/token.service.dart';
import 'package:demos_app/core/services/websocket.service.dart';

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

      isAlreadyInitialize = true;
    }
  }

  void disconnectWebsocket() {
    WebSocketService webSocketService = WebSocketService();
    webSocketService.closeConnection();

    isAlreadyInitialize = false;
  }
}

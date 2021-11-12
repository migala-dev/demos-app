import 'package:demos_app/constans/api_path.dart';
import 'package:demos_app/core/services/cache.service.dart';
import 'package:web_socket_channel/io.dart';

class WebSocketService {
  final Duration pingInterval = Duration(seconds: 2);
  static final WebSocketService _webSocketService =
      WebSocketService._internal();
  IOWebSocketChannel? connection;
  bool _isConnected = false;

  WebSocketService._internal();

  factory WebSocketService() => _webSocketService;

  void createConnection(String userId) {
    if (!_isConnected) {
      String websocketPath = ApiPath().getWebsocketServicePath(userId);
      connection =
          IOWebSocketChannel.connect(websocketPath, pingInterval: pingInterval);
      this._startListening();
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

import 'package:demos_app/constans/api_path.dart';
import 'package:demos_app/core/event_handlers/user_space/user_space_handler.dart';
import 'package:demos_app/core/models/data_event.model.dart';
import 'package:web_socket_channel/io.dart';

class WebSocketService {
  static final WebSocketService userSpaceEventListener =
      WebSocketService._internal();
  WebSocketService._internal();
  factory WebSocketService() => userSpaceEventListener;

  IOWebSocketChannel _getChannelConnection() {
    return IOWebSocketChannel.connect(
        Uri.parse(ApiPath().getWebsocketServicePath()),
        pingInterval: Duration(seconds: 2));
  }

  void listenToEvents() {
    final _channel = _getChannelConnection();
    final _userSpaceHandler = UserSpaceHandler();

    _channel.stream.listen((event) {
      final dataEvent = DataEvent.fromJson(event);
      _userSpaceHandler.handleEvent(dataEvent);
    });
  }
}
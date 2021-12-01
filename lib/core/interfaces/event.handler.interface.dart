import 'package:demos_app/core/models/cache.model.dart';

abstract class EventHandler {
  final String key = '';
  Future<void> handleEvent(Cache dataEvent);
}

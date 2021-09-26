import 'package:demos_app/core/models/data_event.model.dart';

abstract class EventHandler {
  String key = '';
  Future<void> handleEvent(DataEvent dataEvent);
}

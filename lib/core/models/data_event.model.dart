import 'dart:convert';

class DataEvent {
  String _entityName;
  String _eventName;
  Map<String, dynamic>? _data;

  String get entityName => this._entityName;
  String get eventName => this._eventName;
  Map<String, dynamic>? get data => this._data;

  DataEvent(
      {required String entityName,
      required String eventName,
      Map<String, dynamic>? data})
      : this._entityName = entityName,
        this._eventName = eventName,
        this._data = data;

  factory DataEvent.fromObject(Map<String, dynamic> o) => DataEvent(
      entityName: o["entityName"],
      eventName: o["eventName"],
      data: jsonDecode(o["data"]));

  factory DataEvent.fromJson(String str) {
    final o = json.decode(str);

    return DataEvent.fromObject(o);
  }
}

import 'dart:convert';

class Cache {
  String _cacheId;
  String _entityName;
  String _eventName;
  Map<String, dynamic>? _data;
  String _createdAt;

  String get cacheId => this._cacheId;
  String get entityName => this._entityName;
  String get eventName => this._eventName;
  Map<String, dynamic>? get data => this._data;
  String? get createdAt => this._createdAt;

  Cache(
      {required String cacheId,
      required String entityName,
      required String eventName,
      Map<String, dynamic>? data,
      required String createdAt})
      : this._cacheId = cacheId,
        this._entityName = entityName,
        this._eventName = eventName,
        this._data = data,
        this._createdAt = createdAt;

  factory Cache.fromObject(Map<String, dynamic> o) => Cache(
        cacheId: o["cacheId"],
        entityName: o["entityName"],
        eventName: o["eventName"],
        data: o["data"] != null ? jsonDecode(o["data"]) : null,
        createdAt: o["createdAt"],
      );

  factory Cache.fromJson(String str) {
    final o = json.decode(str);

    return Cache.fromObject(o);
  }

  Map<String, dynamic> toMap() {
    var map = Map<String, dynamic>();
    map["cacheId"] = _cacheId;
    map["entityName"] = _entityName;
    map["eventName"] = _eventName;
    map["createdAt"] = _createdAt;
    return map;
  }
}

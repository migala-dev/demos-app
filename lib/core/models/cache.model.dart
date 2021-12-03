import 'dart:convert';

class Cache {
  String _cacheId;
  String _entityName;
  String _eventName;
  Map<String, dynamic>? _data;
  String _createdAt;

  String get cacheId => _cacheId;
  String get entityName => _entityName;
  String get eventName => _eventName;
  Map<String, dynamic>? get data => _data;
  String? get createdAt => _createdAt;

  Cache(
      {required String cacheId,
      required String entityName,
      required String eventName,
      Map<String, dynamic>? data,
      required String createdAt})
      : _cacheId = cacheId,
        _entityName = entityName,
        _eventName = eventName,
        _data = data,
        _createdAt = createdAt;

  factory Cache.fromObject(Map<String, dynamic> o) => Cache(
        cacheId: o['cacheId'],
        entityName: o['entityName'],
        eventName: o['eventName'],
        data: o['data'] != null ? jsonDecode(o['data']) : null,
        createdAt: o['createdAt'],
      );

  factory Cache.fromJson(String str) {
    final o = json.decode(str);

    return Cache.fromObject(o);
  }

  Map<String, dynamic> toMap() {
    final Map<String, dynamic> map = <String, dynamic>{};
    map['cacheId'] = _cacheId;
    map['entityName'] = _entityName;
    map['eventName'] = _eventName;
    map['createdAt'] = _createdAt;
    return map;
  }
}

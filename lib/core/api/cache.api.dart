import 'dart:convert';
import 'package:demos_app/constans/api_path.dart';
import 'package:demos_app/core/models/data_event.model.dart';

import 'api.dart';

class CacheApi {
  static final CacheApi _cacheApi = CacheApi._internal();
  CacheApi._internal();

  factory CacheApi() {
    return _cacheApi;
  }

  Future<List<DataEvent>> getCache() async {
    String endpoint = ApiPath().getGetCache();
    final resp = await Api.get(endpoint);
    if (resp.statusCode != 200) {
      return [];
    }

    final List data = jsonDecode(resp.body);

    final events = data.map((event) => DataEvent.fromObject(event)).toList();

    return events;
  }
}

import 'dart:convert';

import 'package:demos_app/constans/api_path.dart';
import 'package:demos_app/core/models/data_event.model.dart';
import 'package:demos_app/core/services/api_service.dart';

class CacheApiService {
  static final CacheApiService _cacheApiService = CacheApiService._internal();
  CacheApiService._internal();

  factory CacheApiService() {
    return _cacheApiService;
  }

  Future<List<DataEvent>> getCache() async {
    final resp = await ApiSerivce().get(ApiPath().getGetCache());
    if (resp.statusCode != 200) {
      return [];
    }

    final List data = jsonDecode(resp.body);

    final events = data.map((event) => DataEvent.fromObject(event)).toList();

    return events;
  }
}

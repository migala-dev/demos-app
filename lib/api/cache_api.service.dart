import 'dart:math';

import 'package:demos_app/core/models/data_event.model.dart';
import 'package:demos_app/modules/spaces/models/space.model.dart';

class CacheApiService {
  static final CacheApiService _cacheApiService = CacheApiService._internal();
  CacheApiService._internal();

  factory CacheApiService() {
    return _cacheApiService;
  }

  Future<List<DataEvent>> getCache() async {
    return [];
  }

  Future<Space> getInvitation(String id) async {
    var rng = new Random();

    return Space(
        name: "Invitación ${rng.nextInt(100)}", members: rng.nextInt(50));
  }
}

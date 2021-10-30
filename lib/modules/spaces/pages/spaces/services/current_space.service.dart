

import 'package:demos_app/core/models/space.model.dart';
import 'package:demos_app/core/repositories/spaces.repository.dart';

class CurrentSpaceService {
  static final CurrentSpaceService _currentSpaceService = CurrentSpaceService._internal();
  Space? _currentSpace;

  CurrentSpaceService._internal();

  factory CurrentSpaceService() {
    return _currentSpaceService;
  }

  Future<void> setCurrentSpace(String spaceId) async {
    Space? space = await SpacesRepository().findById(spaceId);
    _currentSpace = space;
  }

  Space? getCurrentSpace() {
    return _currentSpace;
  }
}
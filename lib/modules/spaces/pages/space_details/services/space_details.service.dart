import 'package:demos_app/core/api/space.api.dart';
import 'package:demos_app/core/models/space.model.dart';

class SpaceDetailsService {
  Future<void> updateSpace(Space space) async {
    await SpaceApi().updateSpace(space);
  }
}

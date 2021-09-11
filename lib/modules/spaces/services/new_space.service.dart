import 'dart:io';

import 'package:demos_app/constans/space.path.dart';
import 'package:demos_app/core/models/role_user_space.model.dart';
import 'package:demos_app/core/models/space.model.dart';
import 'package:demos_app/core/models/user_space.dart';
import 'package:demos_app/core/repositories/role_user_space.repository.dart';
import 'package:demos_app/core/repositories/spaces.repository.dart';
import 'package:demos_app/core/repositories/user_space.dart';
import 'package:demos_app/core/services/api_service.dart';
import 'package:demos_app/modules/spaces/models/create_space_response.model.dart';

class NewSpaceService {
  Future<Space?> createSpace(Space newSpace) async {
    String endpoint = SpacePath().getSpacePath();
    Object params = {
      "name": newSpace.name,
      "description": newSpace.description,
      "participationPercentage": newSpace.participationPercentage.toString(),
      "approvalPercentage": newSpace.approvalPercentage.toString()
    };
    final httpResponse = await ApiSerivce().post(endpoint, params);

    CreateSpaceResponse response = CreateSpaceResponse.fromObject(httpResponse);

    await _saveSpace(response.space);
    await _saveUserSpace(response.userSpace);
    await _saveRoleUserSpace(response.roleUserSpace);

    return response.space;
  }

  Future<Space?> uploadPicture(String spaceId, File file) async {
    String endpoint = SpacePath().getUpdateSpaceImagePath(spaceId);

    final httpResponse = await ApiSerivce().upload(endpoint, file);

    Space spaceSaved = Space.fromObject(httpResponse);

    SpacesRepository().updateSpace(spaceSaved);

    return spaceSaved;
  }

  Future<void> _saveSpace(Space? space) async {
    if (space != null) {
      await SpacesRepository().insert(space);
    }
  }

  Future<void> _saveUserSpace(UserSpace? userSpace) async {
    if (userSpace != null) {
      await UserSpaceRepository().insert(userSpace);
    }
  }

  Future<void> _saveRoleUserSpace(RoleUserSpace? roleUserSpace) async {
    if (roleUserSpace != null) {
      await RoleUserSpaceRepository().insert(roleUserSpace);
    }
  }
}

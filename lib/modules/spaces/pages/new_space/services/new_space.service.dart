import 'dart:io';
import 'package:demos_app/core/models/role_user_space.model.dart';
import 'package:demos_app/core/models/space.model.dart';
import 'package:demos_app/core/models/user_space.dart';
import 'package:demos_app/core/repositories/role_user_space.repository.dart';
import 'package:demos_app/core/repositories/spaces.repository.dart';
import 'package:demos_app/core/repositories/user_space.dart';
import 'package:demos_app/modules/spaces/api/space.api.dart';
import 'package:demos_app/modules/spaces/pages/new_space/models/new_space_response.model.dart';

class NewSpaceService {
  Future<Space?> createSpace(Space newSpace) async {
    NewSpaceResponse response = await SpaceApi().createSpace(newSpace);
    
    await _saveSpace(response.space);
    await _saveUserSpace(response.userSpace);
    await _saveRoleUserSpace(response.roleUserSpace);

    return response.space;
  }

  Future<Space?> uploadPicture(String spaceId, File file) async {

    Space? spaceUpdated = await SpaceApi().uploadPicture(spaceId, file);

    SpacesRepository().updateSpace(spaceUpdated!);

    return spaceUpdated;
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

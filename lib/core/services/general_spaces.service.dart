import 'package:demos_app/core/api/space.api.dart';
import 'package:demos_app/core/enums/space-role.enum.dart';
import 'package:demos_app/core/models/responses/all_spaces_response.model.dart';
import 'package:demos_app/core/models/responses/space_response.model.dart';
import 'package:demos_app/core/models/role_user_space.model.dart';
import 'package:demos_app/core/models/space.model.dart';
import 'package:demos_app/core/repositories/role_user_space.repository.dart';
import 'package:demos_app/core/repositories/spaces.repository.dart';
import 'package:demos_app/core/repositories/user_space.repository.dart';
import 'package:demos_app/core/repositories/users.repository.dart';

import 'cache.service.dart';

class GeneralSpaceService {

  Future<void> getUserSpaces() async {
    List<Space> spaces = await SpacesRepository().getAll();
    if (spaces.isEmpty) {
      AllSpacesResponse response = await SpaceApi().getAllSpaces();

      for (final space in response.spaces) {
        await SpacesRepository().insert(space);
      }

       for (final userSpace in response.userSpaces) {
        await UserSpaceRepository().insert(userSpace);
      }

      for (final user in response.users) {
        await UsersRepository().insertOrUpdate(user);
      }

      for (final roleUser in response.roleUsers) {
        await RoleUserSpaceRepository().insert(roleUser);
      }

      await CacheService().updateLastUpdatedDate();
    }
  }

  Future<Space> updateSpace(String spaceId) async {
    SpaceResponse response = await SpaceApi().getSpace(spaceId);
    
    await SpacesRepository().updateSpace(response.space);
    
    return response.space;
  }

  Future<bool> isUserAdmin(String userId, String spaceId) async {
    RoleUserSpace? userRole = await RoleUserSpaceRepository()
        .findByUserIdAndSpaceId(userId, spaceId);

    return userRole != null ? userRole.role == SpaceRole.ADMIN : false;
  }

}
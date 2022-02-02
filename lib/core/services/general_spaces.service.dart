import 'package:demos_app/core/api/space.api.dart';
import 'package:demos_app/core/enums/space_role.enum.dart';
import 'package:demos_app/core/models/member.model.dart';
import 'package:demos_app/core/models/responses/all_spaces_response.model.dart';
import 'package:demos_app/core/models/responses/space_response.model.dart';
import 'package:demos_app/core/models/space.model.dart';
import 'package:demos_app/core/repositories/spaces.repository.dart';
import 'package:demos_app/core/repositories/members.repository.dart';
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

      for (final member in response.members) {
        await MembersRepository().insert(member);
      }

      for (final user in response.users) {
        await UsersRepository().insertOrUpdate(user);
      }

      await CacheService().updateLastUpdatedDate();
    }
  }

  Future<Space> updateSpace(String spaceId) async {
    SpaceResponse response = await SpaceApi().getSpace(spaceId);
    await SpacesRepository().updateSpace(response.space);

    return response.space;
  }
}

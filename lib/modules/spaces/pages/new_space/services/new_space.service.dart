import 'dart:io';
import 'package:demos_app/core/api/space.api.dart';
import 'package:demos_app/core/models/space.model.dart';
import 'package:demos_app/core/models/member.model.dart';
import 'package:demos_app/core/repositories/spaces.repository.dart';
import 'package:demos_app/core/repositories/members.repository.dart';
import 'package:demos_app/core/models/responses/space_response.model.dart';

class NewSpaceService {
  Future<Space?> createSpace(Space newSpace) async {
    SpaceResponse response = await SpaceApi().createSpace(newSpace);

    await addSpaceEntitiesFromResponse(response);

    return response.space;
  }

  Future<void> addSpaceEntitiesFromResponse(SpaceResponse response) async {
    await _saveSpace(response.space);
    await _saveMember(response.member);
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

  Future<void> _saveMember(Member? member) async {
    if (member != null) {
      await MembersRepository().insert(member);
    }
  }
}

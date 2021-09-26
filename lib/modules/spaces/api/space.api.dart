

import 'dart:io';

import 'package:demos_app/constans/space.path.dart';
import 'package:demos_app/core/api/api.dart';
import 'package:demos_app/core/models/space.model.dart';
import 'package:demos_app/modules/spaces/pages/new_space/models/new_space_response.model.dart';

class SpaceApi {
  static SpaceApi _spaceApi = SpaceApi._internal();

  SpaceApi._internal();

  factory SpaceApi() {
    return _spaceApi;
  }

  Future<NewSpaceResponse> createSpace(Space newSpace) async {
    String endpoint = SpacePath().getSpacePath();
    Object params = {
      "name": newSpace.name,
      "description": newSpace.description,
      "participationPercentage": newSpace.participationPercentage.toString(),
      "approvalPercentage": newSpace.approvalPercentage.toString()
    };
    final httpResponse = await Api.post(endpoint, params);

    NewSpaceResponse response = NewSpaceResponse.fromObject(httpResponse);

    return response;
  }

  Future<Space?> uploadPicture(String spaceId, File file) async {
    String endpoint = SpacePath().getUpdateSpaceImagePath(spaceId);

    final httpResponse = await Api.upload(endpoint, file);

    Space spaceUpdated = Space.fromObject(httpResponse);

    return spaceUpdated;
  }
}
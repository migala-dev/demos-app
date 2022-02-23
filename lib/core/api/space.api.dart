import 'dart:io';
import 'package:demos_app/config/themes/cubit/throw_behavior.dart';
import 'package:demos_app/constans/space.path.dart';
import 'package:demos_app/core/api/api.dart';
import 'package:demos_app/core/models/responses/all_spaces_response.model.dart';
import 'package:demos_app/core/models/space.model.dart';
import 'package:demos_app/core/models/responses/space_response.model.dart';

class SpaceApi {
  static final SpaceApi _spaceApi = SpaceApi._internal();

  SpaceApi._internal();

  factory SpaceApi() {
    return _spaceApi;
  }

  Future<AllSpacesResponse> getAllSpaces() async {
    String endpoint = SpacePath().getSpacesPath();
    final httpResponse = await Api.get(endpoint, null);

    AllSpacesResponse response = AllSpacesResponse.fromObject(httpResponse);

    return response;
  }

  Future<SpaceResponse> createSpace(Space newSpace) async {
    String endpoint = SpacePath().getSpacesPath();
    Object params = {
      'name': newSpace.name,
      'description': newSpace.description,
      'participationPercentage': newSpace.participationPercentage.toString(),
      'approvalPercentage': newSpace.approvalPercentage.toString()
    };
    final httpResponse = await Api.post(endpoint, params, null);

    SpaceResponse response = SpaceResponse.fromObject(httpResponse);

    return response;
  }

  Future<Space> updateSpaceName(String spaceId, String name) async {
    String endpoint = SpacePath().getSpacePath(spaceId);
    Object params = {
      'name': name,
    };

    final httpResponse = await Api.post(endpoint, params, null);

    Space spaceUpdated = Space.fromObject(httpResponse);

    return spaceUpdated;
  }

  Future<Space> updateSpaceDescription(
      String spaceId, String description) async {
    String endpoint = SpacePath().getSpacePath(spaceId);
    Object params = {
      'description': description,
    };

    final httpResponse = await Api.post(endpoint, params, null);

    Space spaceUpdated = Space.fromObject(httpResponse);

    return spaceUpdated;
  }

  Future<Space> updateSpacePercentages(String spaceId,
      int participationPercentage, int approvalPercentage) async {
    String endpoint = SpacePath().getSpacePath(spaceId);
    Object params = {
      'participationPercentage': participationPercentage.toString(),
      'approvalPercentage': approvalPercentage.toString()
    };

    final httpResponse = await Api.post(endpoint, params, null);

    Space spaceUpdated = Space.fromObject(httpResponse);

    return spaceUpdated;
  }

  Future<Space?> uploadPicture(String spaceId, File file) async {
    String endpoint = SpacePath().getUpdateSpaceImagePath(spaceId);

    final httpResponse = await Api.upload(endpoint, file, null);

    Space spaceUpdated = Space.fromObject(httpResponse);

    return spaceUpdated;
  }

  Future<SpaceResponse> getSpace(String spaceId) async {
    ThrowBehavior throwBehavior = ThrowBehavior(showError: false);
    String endpoint = SpacePath().getSpacePath(spaceId);
    final httpResponse = await Api.get(endpoint, throwBehavior);

    SpaceResponse response = SpaceResponse.fromObject(httpResponse);

    return response;
  }
}

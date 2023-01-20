/*
  DEMOS
  Copyright (C) 2022 Julian Alejandro Ortega Zepeda, Erik Ivanov Domínguez Rivera, Luis Ángel Meza Acosta
  This file is part of DEMOS.

  DEMOS is free software: you can redistribute it and/or modify
  it under the terms of the GNU General Public License as published by
  the Free Software Foundation, either version 3 of the License, or
  (at your option) any later version.

  DEMOS is distributed in the hope that it will be useful,
  but WITHOUT ANY WARRANTY; without even the implied warranty of
  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
  GNU General Public License for more details.

  You should have received a copy of the GNU General Public License
  along with this program.  If not, see <https://www.gnu.org/licenses/>.
*/

import 'dart:io';
import 'package:demos_app/config/themes/cubit/request_behavior.dart';
import 'package:demos_app/constans/paths.depracted/space.path.deprecated.dart';
import 'package:demos_app/constans/paths/space.path.dart';
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
    String endpoint = SpacePathDeprecated().getSpacesPath();
    final httpResponse = await Api.get(endpoint, null);

    AllSpacesResponse response = AllSpacesResponse.fromObject(httpResponse);

    return response;
  }

  Future<SpaceResponse> createSpace(Space newSpace) async {
    String endpoint = SpacePath.getSpacesPath();
    Object params = {
      'name': newSpace.name,
      'description': newSpace.description,
      'participationPercentage': newSpace.participationPercentage,
      'approvalPercentage': newSpace.approvalPercentage,
    };
    final httpResponse = await Api.post(endpoint, params, null);

    SpaceResponse response = SpaceResponse.fromObject(httpResponse);

    return response;
  }

  Future<Space> updateSpaceName(String spaceId, String name) async {
    String endpoint = SpacePath.getSpacePath(spaceId);
    Object params = {
      'name': name,
    };

    final httpResponse = await Api.post(endpoint, params, null);

    Space spaceUpdated = Space.fromObject(httpResponse);

    return spaceUpdated;
  }

  Future<Space> updateSpaceDescription(
      String spaceId, String description) async {
    String endpoint = SpacePath.getSpacePath(spaceId);
    Object params = {
      'description': description,
    };

    final httpResponse = await Api.post(endpoint, params, null);

    Space spaceUpdated = Space.fromObject(httpResponse);

    return spaceUpdated;
  }

  Future<Space> updateSpacePercentages(String spaceId,
      int participationPercentage, int approvalPercentage) async {
    String endpoint = SpacePath.getSpacePath(spaceId);
    Object params = {
      'participationPercentage': participationPercentage,
      'approvalPercentage': approvalPercentage,
    };

    final httpResponse = await Api.post(endpoint, params, null);

    Space spaceUpdated = Space.fromObject(httpResponse);

    return spaceUpdated;
  }

  Future<Space?> uploadPicture(String spaceId, File file) async {
    String endpoint = SpacePathDeprecated().getUpdateSpaceImagePath(spaceId);

    final httpResponse = await Api.upload(endpoint, file, null);

    Space spaceUpdated = Space.fromObject(httpResponse);

    return spaceUpdated;
  }

  Future<SpaceResponse> getSpace(String spaceId) async {
    RequestBehavior requestBehavior = RequestBehavior(showError: false, showLoading: false);
    String endpoint = SpacePath.getSpacePath(spaceId);
    final httpResponse = await Api.get(endpoint, requestBehavior);

    SpaceResponse response = SpaceResponse.fromObject(httpResponse);

    return response;
  }
}

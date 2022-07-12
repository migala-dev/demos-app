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

import 'package:demos_app/navigation.service.dart';
import 'package:flutter/material.dart';
import 'package:demos_app/config/routes/application.dart';
import 'package:demos_app/config/routes/routes.dart';
import 'package:demos_app/modules/spaces/models/space_view.model.dart';

Future<void> goToSpaceDetails(SpaceView spaceView) async {
    final BuildContext context = NavigationService.navigatorKey.currentContext!;
  Application.router.navigateTo(context, Routes.spacesDetails,
      routeSettings: RouteSettings(
        arguments: spaceView,
      ));
}


Future<void> goToSpaceDetailsBySpaceId(BuildContext context, String spaceId) async {
  Application.router.navigateTo(context, Routes.spacesDetails,
      routeSettings: RouteSettings(
        arguments: spaceId,
      ));
}


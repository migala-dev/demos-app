import 'package:flutter/material.dart';
import 'package:demos_app/config/routes/application.dart';
import 'package:demos_app/config/routes/routes.dart';
import 'package:demos_app/modules/spaces/models/space_view.model.dart';

Future<void> goToSpaceDetails(BuildContext context, SpaceView spaceView) async {
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


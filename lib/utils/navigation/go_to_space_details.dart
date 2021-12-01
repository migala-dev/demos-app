import 'package:flutter/material.dart';
import 'package:demos_app/config/routes/application.dart';
import 'package:demos_app/config/routes/routes.dart';
import 'package:demos_app/modules/spaces/models/space_view.model.dart';
import 'package:demos_app/modules/spaces/pages/spaces/services/current_space.service.dart';

Future<void> goToSpaceDetails(BuildContext context, SpaceView spaceView) async {
  await CurrentSpaceService().setCurrentSpace(spaceView.spaceId);

  Application.router.navigateTo(context, Routes.spacesDetails,
      routeSettings: RouteSettings(
        arguments: spaceView,
      ));
}

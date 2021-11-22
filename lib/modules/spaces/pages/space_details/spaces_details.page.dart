import 'package:flutter/material.dart';
import 'package:demos_app/config/routes/routes.dart';
import 'package:demos_app/modules/spaces/models/space_view.model.dart';
import 'package:demos_app/modules/spaces/pages/spaces/services/current_space.service.dart';
import 'package:demos_app/widgets/scaffolds/demos_scaffold.widget.dart';
import 'package:demos_app/widgets/space/space_picture.widget.dart';

class SpaceDetailsScreen extends StatelessWidget {
  const SpaceDetailsScreen({Key? key}) : super(key: key);

  void goToSpaceSettings(BuildContext context) {
    Navigator.pushNamed(context, Routes.spaceSettings);
  }

  @override
  Widget build(BuildContext context) {
    final SpaceView spaceView =
        ModalRoute.of(context)?.settings.arguments as SpaceView;

    CurrentSpaceService().setCurrentSpace(spaceView.spaceId);

    return Container(
      child: DemosScaffold(
        appBar: AppBar(
            titleSpacing: 0,
            title: GestureDetector(
              child: Row(
                children: [
                  Container(
                    child: SpacePicture(
                      width: 32,
                      pictureKey: spaceView.pictureKey,
                    ),
                    margin: EdgeInsets.only(right: 12.0),
                  ),
                  Text(spaceView.name)
                ],
              ),
              onTap: () => goToSpaceSettings(context),
            )),
      ),
    );
  }
}

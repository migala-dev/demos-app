import 'package:demos_app/config/routes/routes.dart';
import 'package:demos_app/modules/spaces/models/space_view.model.dart';
import 'package:demos_app/widgets/space/space_picture.widget.dart';
import 'package:flutter/material.dart';

class SpaceDetailsScreen extends StatelessWidget {
  const SpaceDetailsScreen({Key? key}) : super(key: key);

  void goToSpaceSettings(BuildContext context, SpaceView spaceView) {
    Navigator.pushNamed(context, Routes.spaceSettings, arguments: spaceView);
  }

  @override
  Widget build(BuildContext context) {
    final SpaceView spaceView =
        ModalRoute.of(context)?.settings.arguments as SpaceView;

    MaterialApp(
      routes: {Routes.spacesDetails: (context) => const SpaceDetailsScreen()},
    );

    return Container(
      child: Scaffold(
        appBar: AppBar(
          titleSpacing: 0,
          title: Row(
            children: [
              GestureDetector(
                child: SpacePicture(
                  width: 32,
                  pictureKey: spaceView.pictureKey,
                ),
                onTap: () => goToSpaceSettings(context, spaceView),
              ),
              SizedBox(width: 12),
              GestureDetector(
                child: Text(spaceView.name),
                onTap: () => goToSpaceSettings(context, spaceView),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

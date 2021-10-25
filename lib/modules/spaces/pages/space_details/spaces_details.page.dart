import 'package:demos_app/config/routes/routes.dart';
import 'package:demos_app/modules/spaces/models/space_view.model.dart';
import 'package:demos_app/widgets/space/space_picture.widget.dart';
import 'package:flutter/material.dart';

class SpaceDetails extends StatelessWidget {
  const SpaceDetails({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final SpaceView spaceView =
        ModalRoute.of(context)?.settings.arguments as SpaceView;

    MaterialApp(
      routes: {Routes.spacesDetails: (context) => const SpaceDetails()},
    );

    void goToSpaceSettings() {
      Navigator.pushNamed(context, Routes.spaceSettings, arguments: spaceView);
    }

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
                onTap: () => goToSpaceSettings(),
              ),
              SizedBox(width: 12),
              GestureDetector(
                child: Text(spaceView.name),
                onTap: () => goToSpaceSettings(),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

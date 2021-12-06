import 'package:demos_app/modules/spaces/models/space_view.model.dart';
import 'package:demos_app/widgets/space/space_picture.widget.dart';
import 'package:flutter/material.dart';

class SpacePictureHeader extends StatelessWidget {
  const SpacePictureHeader({Key? key, required this.spaceView})
      : super(key: key);
  final SpaceView spaceView;

  @override
  Widget build(BuildContext context) {
    if (spaceView.pictureKey != null) {
      return Container(
        child: SpacePicture(
          width: 32,
          pictureKey: spaceView.pictureKey,
        ),
        margin: const EdgeInsets.only(right: 12.0),
      );
    } else {
      return Container();
    }
  }
}
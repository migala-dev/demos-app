import 'package:demos_app/widgets/space/space_picture.widget.dart';
import 'package:flutter/material.dart';

class SpacePictureHeader extends StatelessWidget {
  const SpacePictureHeader({Key? key, required this.pictureKey})
      : super(key: key);
  final String? pictureKey;

  @override
  Widget build(BuildContext context) {
    if (pictureKey != null) {
      return Container(
        child: SpacePicture(
          width: 32,
          pictureKey: pictureKey,
        ),
        margin: const EdgeInsets.only(right: 12.0),
      );
    } else {
      return Container();
    }
  }
}

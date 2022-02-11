import 'package:demos_app/modules/spaces/models/space_view.model.dart';
import 'package:demos_app/widgets/space/space_picture.widget.dart';
import 'package:flutter/material.dart';

class SpaceTile<T extends SpaceView> extends StatelessWidget {
  final String Function(T) getSubtitle;
  final VoidCallback onSpaceTab;
  final T spaceView;

  const SpaceTile(
      {Key? key,
      required this.spaceView,
      required this.onSpaceTab,
      required this.getSubtitle})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: SpacePicture(
        width: 50.0,
        pictureKey: spaceView.pictureKey,
      ),
      title: Text(spaceView.name),
      subtitle: Text(getSubtitle(spaceView)),
      onTap: () {
        onSpaceTab();
      },
    );
  }
}

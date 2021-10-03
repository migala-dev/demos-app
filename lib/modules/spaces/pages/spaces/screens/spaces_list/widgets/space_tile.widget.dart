import 'package:demos_app/config/routes/routes.dart';
import 'package:demos_app/modules/spaces/models/space_view.model.dart';
import 'package:demos_app/widgets/space/space_picture.widget.dart';
import 'package:flutter/material.dart';

class SpaceTile extends StatelessWidget {
  final SpaceView space;

  const SpaceTile({Key? key, required this.space}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: SpacePicture(
        width: 50.0,
        pictureKey: space.pictureKey,
      ),
      title: Text(space.name),
      subtitle: Text('${space.membersCount} miembros'),
      onTap: () {
        Navigator.pushNamed(context, Routes.spaceInvitation, arguments: space);
      },
    );
  }
}

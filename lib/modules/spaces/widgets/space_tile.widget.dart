import 'package:demos_app/config/routes/routes.dart';
import 'package:demos_app/modules/spaces/models/space_view.model.dart';
import 'package:flutter/material.dart';

class SpaceTile extends StatelessWidget {
  final SpaceView space;

  const SpaceTile({Key? key, required this.space}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: ClipRRect(
        borderRadius: BorderRadius.circular(10.0),
        child: Container(
          width: 50,
          height: 50,
          child: Container(
            color: Colors.grey,
          ),
        ),
      ),
      title: Text(space.name),
      subtitle: Text('${space.membersCount} miembros'),
      onTap: () =>
          Navigator.pushNamed(context, Routes.spacesDetails, arguments: space),
    );
  }
}

import 'package:demos_app/config/routes/routes.dart';
import 'package:demos_app/modules/spaces/models/space.model.dart';
import 'package:flutter/material.dart';

class SpaceTile extends StatelessWidget {
  final Widget image;
  final String name;
  final int members;
  final VoidCallback? onTap;

  const SpaceTile(
      {Key? key,
      required this.image,
      required this.name,
      required this.members,
      this.onTap})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: ClipRRect(
        borderRadius: BorderRadius.circular(10.0),
        child: Container(width: 50, height: 50, child: image),
      ),
      title: Text(name),
      subtitle: Text('$members miembros'),
      onTap: () => Navigator.pushNamed(context, Routes.spacesDetails,
          arguments: Space(name: name, members: members)),
    );
  }
}

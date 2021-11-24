import 'package:flutter/material.dart';
import 'package:demos_app/core/enums/space-role.enum.dart';

class SelectRoleModal extends StatelessWidget {
  const SelectRoleModal({Key? key, required this.updateRole}) : super(key: key);

  final Function(SpaceRole) updateRole;

  @override
  Widget build(BuildContext context) {
    return Wrap(
      children: [
        Center(
            child: Container(
                margin: EdgeInsets.symmetric(vertical: 15),
                child: Text(
                  'Selecciona un nuevo rol',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ))),
        ...SpaceRole.values
            .map((SpaceRole spaceRole) => ListTile(
                  title: Text(getSpaceRoleName(spaceRole)),
                  onTap: () async {
                    await updateRole(spaceRole);
                    Navigator.pop(context);
                  },
                ))
            .toList(),
      ],
    );
  }
}

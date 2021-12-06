import 'package:flutter/material.dart';
import 'package:demos_app/core/enums/space-role.enum.dart';

class SelectRoleModal extends StatelessWidget {
  const SelectRoleModal(
      {Key? key, required this.updateRole, required this.currentRole})
      : super(key: key);

  final Function(SpaceRole) updateRole;
  final SpaceRole currentRole;

  @override
  Widget build(BuildContext context) {
    return Wrap(
      children: [
        Center(
            child: Container(
                margin: const EdgeInsets.symmetric(vertical: 15),
                child: const Text(
                  'Selecciona un nuevo rol',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ))),
        ...SpaceRole.values
            .map((SpaceRole spaceRole) => ListTile(
                  leading: _getCheckCurrentRoleLeading(spaceRole),
                  title: Text(getSpaceRoleName(spaceRole)),
                  onTap: () async {
                    if (currentRole != spaceRole) {
                      await updateRole(spaceRole);
                    }
                    Navigator.pop(context);
                  },
                ))
            .toList(),
      ],
    );
  }

  Widget? _getCheckCurrentRoleLeading(SpaceRole spaceRole) {
    if (currentRole == spaceRole) {
      return const Icon(Icons.check_circle, color: Colors.green);
    }

    return const SizedBox();
  }
}

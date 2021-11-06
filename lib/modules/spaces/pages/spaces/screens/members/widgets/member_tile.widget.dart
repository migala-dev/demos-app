import 'package:demos_app/core/enums/space-role.enum.dart';
import 'package:demos_app/modules/spaces/pages/spaces/screens/members/models/member_view.model.dart';
import 'package:demos_app/widgets/profile/profile_picture.widget.dart';
import 'package:flutter/material.dart';

class MemberTile extends StatelessWidget {
  final MemberView member;

  const MemberTile({
    Key? key,
    required this.member,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: ProfilePicture(
        width: 55,
        percentage: 0.9,
        imageKey: member.profilePictureKey,
      ),
      title: Row(
        children: [
          Text(_getMemberName(member.name)),
          SizedBox(
            width: 10,
          ),
          Chip(
            label: Text(_getRoleName(member.role)),
            backgroundColor: Colors.transparent,
            side: BorderSide(color: Colors.grey, width: 0.5),
          ),
        ],
      ),
      subtitle: _getSubtitle(),
    );
  }

  String _getMemberName(String? name) {
    if (name != null) {
      if (name.length > 0) return name;
    }

    return 'Miembro';
  }

  String _getRoleName(SpaceRole? role) {
    if (role == null) return 'Invitado';

    return getSpaceRoleString(role);
  }

  Widget _getSubtitle() {
    if (member.role == SpaceRole.INVITED) return Text('Invitación recibida');

    return Text('Ha participado en 0 votaciones');
  }
}

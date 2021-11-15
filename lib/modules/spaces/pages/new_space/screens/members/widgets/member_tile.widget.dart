import 'package:demos_app/core/enums/invitation-status.enum.dart';
import 'package:demos_app/core/enums/space-role.enum.dart';
import 'package:demos_app/modules/spaces/pages/new_space/screens/members/models/member.view.dart';
import 'package:demos_app/shared/services/date_formatter.service.dart';
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
          Text(
            _getMemberDisplayName(),
          ),
          SizedBox(
            width: 10,
          ),
          _getRoleTile(),
        ],
      ),
      subtitle: Text(_getSubtitle()),
    );
  }

  Widget _getRoleTile() {
    return Container(
      alignment: Alignment.center,
      padding: EdgeInsets.symmetric(horizontal: 5),
      height: 20,
      decoration: BoxDecoration(
        border: Border.all(color: Colors.grey),
        borderRadius: BorderRadius.all(Radius.circular(100)),
      ),
      child: Text(
        _getRoleName(),
        style: TextStyle(fontSize: 12, color: Colors.grey),
      ),
    );
  }

  String _getMemberDisplayName() {
    if (member.name != null) if (member.name!.length > 0) return member.name!;

    if (member.phoneNumber != null) return member.phoneNumber!;

    return 'Miembro';
  }

  String _getRoleName() {
    if (member.role == null) return 'INVITADO';
    if (member.invitationStatus == InvitationStatus.SENDED) return 'INVITADO';

    switch (member.role) {
      case SpaceRole.ADMIN:
        return "ADMIN";
      case SpaceRole.REPRESENTATIVE:
        return "REPR";
      case SpaceRole.WORKER:
      default:
        return "TRABAJADOR";
    }
  }

  String _getSubtitle() {
    if (member.role == null) return 'Invitación recibida';
    if (member.invitationStatus == InvitationStatus.SENDED)
      return 'Invitación recibida';

    String memberAt =
        DateFormatterService.parseToStandardDate(member.createdAt);

    return 'Desde el $memberAt';
  }
}

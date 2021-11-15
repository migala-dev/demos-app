import 'package:flutter/material.dart';

import 'package:demos_app/core/enums/invitation-status.enum.dart';
import 'package:demos_app/modules/spaces/pages/new_space/screens/members/enums/member_type.dart';
import 'package:demos_app/modules/spaces/pages/new_space/screens/members/models/member.view.dart';
import 'package:demos_app/shared/services/date_formatter.service.dart';
import 'package:demos_app/widgets/profile/profile_picture.widget.dart';

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
          Text(member.displayName),
          SizedBox(width: 10),
          _getRoleTile(),
        ],
      ),
      subtitle: Text(_getSubtitleText()),
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

  String _getRoleName() {
    switch (member.memberType) {
      case MemberType.ADMINISTRATOR:
        return "ADMIN";
      case MemberType.INVITED:
        return "INVITADO";
      default:
        return "TRABAJADOR";
    }
  }

  String _getSubtitleText() {
    if (member.memberType == MemberType.INVITED) {
      if (member.invitationStatus == InvitationStatus.RECEIVED)
        return 'Invitación recibida';

      return 'Invitación enviada';
    }

    String memberAt =
        DateFormatterService.parseToStandardDate(member.createdAt);

    return 'Desde el $memberAt';
  }
}

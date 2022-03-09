import 'package:flutter/material.dart';

import 'package:demos_app/core/enums/invitation-status.enum.dart';
import 'package:demos_app/modules/spaces/pages/new_space/screens/members/enums/member_type.dart';
import 'package:demos_app/modules/spaces/models/member_view.model.dart';
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
          const SizedBox(width: 10),
          _getRoleTile(),
        ],
      ),
      subtitle: Text(_getSubtitleText()),
    );
  }

  Widget _getRoleTile() {
    return Container(
      alignment: Alignment.center,
      padding: const EdgeInsets.symmetric(horizontal: 5),
      height: 20,
      decoration: BoxDecoration(
        border: Border.all(color: Colors.grey),
        borderRadius: const BorderRadius.all(Radius.circular(100)),
      ),
      child: Text(
        getMemberTypeName(member.memberType),
        style: const TextStyle(fontSize: 12, color: Colors.grey),
      ),
    );
  }

  String _getSubtitleText() {
    if (member.memberType == MemberType.invited) {
      if (member.invitationStatus == InvitationStatus.received) {
        return 'Invitación recibida';
      }

      return 'Invitación enviada';
    }

    String memberAt = member.memberCreatedAtFormatted;

    return 'Desde el $memberAt';
  }
}

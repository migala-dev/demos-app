import 'package:flutter/material.dart';
import 'package:demos_app/widgets/profile/profile_field.widget.dart';
import 'package:demos_app/modules/spaces/pages/new_space/screens/member_profile/widgets/areas_list.widget.dart';
import 'package:demos_app/modules/spaces/pages/new_space/screens/member_profile/widgets/member_profile_field.dart';
import 'package:demos_app/modules/spaces/pages/new_space/screens/member_profile/widgets/votes_text.widget.dart';
import 'package:demos_app/modules/spaces/pages/new_space/screens/members/models/member.view.dart';

class AdditionalMemberInfo extends StatelessWidget {
  const AdditionalMemberInfo({Key? key, required this.member})
      : super(key: key);

  final MemberView member;

  @override
  Widget build(BuildContext context) {
    return member.isInvited
        ? Container()
        : Column(
            children: [
              MemberProfileField(
                  title: 'Áreas', icon: Icons.grid_view, child: AreasList()),
              MemberProfileField(
                  title: 'Propuestas',
                  icon: Icons.info_outline,
                  child: VotesText()),
              MemberProfileField(
                  title: 'Sugerencias',
                  icon: Icons.info_outline,
                  child: VotesText()),
              ProfileField(
                title: 'Miembro desde',
                icon: Icons.calendar_today,
                value: member.memberCreatedAtFormatted,
              )
            ],
          );
  }
}

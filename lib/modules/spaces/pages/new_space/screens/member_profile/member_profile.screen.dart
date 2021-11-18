import 'package:flutter/material.dart';
import 'package:demos_app/core/enums/space-role.enum.dart';
import 'package:demos_app/modules/spaces/pages/new_space/screens/members/models/member.view.dart';
import 'package:demos_app/modules/spaces/pages/new_space/screens/member_profile/widgets/member_profile_popup_menu_button.widget.dart';
import 'package:demos_app/modules/spaces/pages/new_space/screens/member_profile/widgets/areas_list.widget.dart';
import 'package:demos_app/modules/spaces/pages/new_space/screens/member_profile/widgets/member_profile_field.dart';
import 'package:demos_app/modules/spaces/pages/new_space/screens/member_profile/widgets/votes_text.widget.dart';
import 'package:demos_app/widgets/profile/profile_field.widget.dart';
import 'package:demos_app/widgets/profile/profile_picture.widget.dart';

class MemberProfileScreen extends StatelessWidget {
  const MemberProfileScreen(this.member, {Key? key}) : super(key: key);

  final MemberView member;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Perfil'),
        actions: [
          MemberProfilePopupMenuButton(memberIsInvited: member.isInvited)
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 15),
        child: Column(
          children: [
            ProfilePicture(imageKey: member.profilePictureKey),
            Expanded(
              child: ListView(physics: BouncingScrollPhysics(), children: [
                ProfileField(
                    placeholderPrefix: 'Sin ',
                    title: 'Nombre en el espacio',
                    icon: Icons.person,
                    value: member.displayName),
                ProfileField(
                  placeholderPrefix: 'Sin ',
                  title: 'Telefono',
                  icon: Icons.phone,
                  value: member.phoneNumberFormatted,
                ),
                ProfileField(
                    placeholderPrefix: 'Sin ',
                    title: 'Rol',
                    icon: Icons.manage_accounts,
                    value: getSpaceRoleName(member.role)),
                _getAdditionalMemberInfo()
              ]),
            ),
          ],
        ),
      ),
    );
  }

  Widget _getAdditionalMemberInfo() => member.isInvited
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

import 'package:demos_app/modules/spaces/validators/is_current_user_admin.widget_validator.dart';
import 'package:flutter/material.dart';
import 'package:demos_app/modules/spaces/pages/new_space/screens/member_profile/widgets/additional_member_info.widget.dart';
import 'package:demos_app/modules/spaces/pages/new_space/screens/member_profile/modals/select_role_modal.dart';
import 'package:demos_app/core/enums/space-role.enum.dart';
import 'package:demos_app/utils/ui/modals/open_update_string_field_modal.dart';
import 'package:demos_app/modules/spaces/services/member.service.dart';
import 'package:demos_app/modules/spaces/pages/new_space/screens/members/models/member.view.dart';
import 'package:demos_app/modules/spaces/pages/new_space/screens/member_profile/widgets/member_profile_popup_menu_button.widget.dart';
import 'package:demos_app/widgets/profile/profile_field.widget.dart';
import 'package:demos_app/widgets/profile/profile_picture.widget.dart';

class MemberProfileScreen extends StatefulWidget {
  const MemberProfileScreen(this.member, {Key? key}) : super(key: key);

  final MemberView member;

  @override
  State<MemberProfileScreen> createState() => _MemberProfileScreenState();
}

class _MemberProfileScreenState extends State<MemberProfileScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Perfil'),
        actions: [
          MemberProfilePopupMenuButton(memberIsInvited: widget.member.isInvited)
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 15),
        child: Column(
          children: [
            ProfilePicture(imageKey: widget.member.profilePictureKey),
            Expanded(
              child: ListView(physics: BouncingScrollPhysics(), children: [
                ProfileField(
                  placeholderPrefix: 'Sin ',
                  title: 'Nombre en el espacio',
                  icon: Icons.person,
                  value: widget.member.displayName,
                  editable: !widget.member.isInvited,
                  onEdit: openUpdateNameModal,
                  editableButtonValidators: [
                    IsCurrentUserAdminWidgetValidator()
                  ],
                ),
                ProfileField(
                  placeholderPrefix: 'Sin ',
                  title: 'Telefono',
                  icon: Icons.phone,
                  value: widget.member.phoneNumberFormatted,
                ),
                ProfileField(
                  placeholderPrefix: 'Sin ',
                  title: 'Rol',
                  icon: Icons.manage_accounts,
                  value: getSpaceRoleName(widget.member.role),
                  editable: !widget.member.isInvited,
                  onEdit: openUpdateRoleModel,
                  editableButtonValidators: [
                    IsCurrentUserAdminWidgetValidator()
                  ],
                ),
                AdditionalMemberInfo(member: widget.member)
              ]),
            ),
          ],
        ),
      ),
    );
  }

  void openUpdateNameModal() async {
    String? newName = await openUpdateStringFieldModal(context,
        title: 'Nombre en el espacio',
        hintText: 'Introduce el nuevo nombre',
        initialValue: widget.member.memberName);
    bool newNameIsValid =
        widget.member.memberName != newName && newName != null;

    if (newNameIsValid) {
      await updateMemberName(newName);
    }
  }

  Future<void> updateMemberName(String newName) async {
    await MemberService().updateMember(widget.member.spaceId!,
        widget.member.memberId!, newName, widget.member.role!);
    setState(() {
      widget.member.memberName = newName;
    });
  }

  void openUpdateRoleModel() async {
    await showModalBottomSheet(
      context: context,
      builder: (context) {
        return SelectRoleModal(updateRol: updateRol);
      },
    );
  }

  Future<void> updateRol(SpaceRole newRole) async {
    if (newRole != widget.member.role) {
      await MemberService().updateMember(widget.member.spaceId!,
          widget.member.memberId!, widget.member.memberName, newRole);
      setState(() {
        widget.member.role = newRole;
      });
    }
  }
}

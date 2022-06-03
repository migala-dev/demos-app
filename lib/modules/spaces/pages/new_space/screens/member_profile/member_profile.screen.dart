/*
  DEMOS
  Copyright (C) 2022 Julian Alejandro Ortega Zepeda, Erik Ivanov Domínguez Rivera, Luis Ángel Meza Acosta
  This file is part of DEMOS.

  DEMOS is free software: you can redistribute it and/or modify
  it under the terms of the GNU General Public License as published by
  the Free Software Foundation, either version 3 of the License, or
  (at your option) any later version.

  DEMOS is distributed in the hope that it will be useful,
  but WITHOUT ANY WARRANTY; without even the implied warranty of
  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
  GNU General Public License for more details.

  You should have received a copy of the GNU General Public License
  along with this program.  If not, see <https://www.gnu.org/licenses/>.
*/

import 'package:demos_app/modules/spaces/pages/new_space/screens/member_profile/widgets/participation_counts.widget.dart';
import 'package:demos_app/modules/spaces/pages/new_space/screens/members/bloc/space_members_bloc.dart';
import 'package:flutter/material.dart';
import 'package:demos_app/modules/spaces/validators/is_current_user_admin.widget_validator.dart';
import 'package:demos_app/modules/spaces/pages/new_space/screens/member_profile/modals/select_role_modal.dart';
import 'package:demos_app/modules/spaces/services/member.service.dart';
import 'package:demos_app/modules/spaces/models/member_view.model.dart';
import 'package:demos_app/modules/spaces/pages/new_space/screens/member_profile/widgets/member_profile_popup_menu_button.widget.dart';
import 'package:demos_app/widgets/profile/profile_field.widget.dart';
import 'package:demos_app/widgets/profile/profile_picture.widget.dart';
import 'package:demos_app/core/enums/space_role.enum.dart';
import 'package:demos_app/core/bloc/current_user_bloc/current_user_bloc.dart';
import 'package:demos_app/utils/ui/modals/open_update_string_field_modal.dart';
import 'package:demos_app/utils/ui/modals/open_alert_dialog.dart';
import 'package:demos_app/utils/mixins/loading_state_handler.mixin.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class MemberProfileScreen extends StatefulWidget {
  final String memberId;

  const MemberProfileScreen(this.memberId, {Key? key}) : super(key: key);

  @override
  State<MemberProfileScreen> createState() => _MemberProfileScreenState();
}

class _MemberProfileScreenState extends State<MemberProfileScreen>
    with LoadingStateHandler {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SpaceMembersBloc, SpaceMembersState>(
        bloc: SpaceMembersBloc(),
        builder: (context, state) {
          if (state is SpaceMembersWithData) {
            final MemberView member = state.memberViews
                .firstWhere((m) => m.memberId == widget.memberId);

            return Scaffold(
              appBar: AppBar(
                title: const Text('Perfil'),
                actions: [
                  FutureBuilder(
                    future: isCurrentUser(member),
                    builder:
                        (BuildContext context, AsyncSnapshot<bool> snapshot) {
                      if (snapshot.hasData) {
                        final isCurrentUser = snapshot.data!;
                        if (isCurrentUser) {
                          return Container();
                        }

                        return MemberProfilePopupMenuOptions(
                            memberIsInvited: member.isInvited,
                            memberId: member.memberId!,
                            spaceId: member.spaceId!);
                      }

                      return const CircularProgressIndicator();
                    },
                  ),
                ],
              ),
              body: Padding(
                padding:
                    const EdgeInsets.symmetric(vertical: 10, horizontal: 15),
                child: Column(
                  children: [
                    ProfilePicture(imageKey: member.profilePictureKey),
                    Expanded(
                      child: ListView(
                          physics: const BouncingScrollPhysics(),
                          children: [
                            ProfileField(
                              placeholderPrefix: 'Sin ',
                              title: 'Nombre en el espacio',
                              icon: Icons.person,
                              value: member.currentMemberName,
                              editable: !member.isInvited,
                              onEdit: isLoading ? null : () => openUpdateNameModal(member),
                              editableButtonValidators: [
                                IsCurrentUserAdminWidgetValidator()
                              ],
                            ),
                            member.phoneNumber != null
                                ? ProfileField(
                                    title: 'Teléfono',
                                    icon: Icons.phone,
                                    value: member.phoneNumberFormatted,
                                  )
                                : Container(),
                            ProfileField(
                              title: 'Rol',
                              icon: Icons.manage_accounts,
                              value: getSpaceRoleName(member.role),
                              editable: !member.isInvited,
                              onEdit: isLoading ? null : () => openUpdateRoleModel(member),
                              editableButtonValidators: [
                                IsCurrentUserAdminWidgetValidator()
                              ],
                            ),
                            ProfileField(
                              title: 'Propuestas',
                              icon: Icons.how_to_vote,
                              child: ParticipationCounts(
                                  created: member.proposalCreatedCount,
                                  votes: member.proposalVotedCount),
                              onEdit: isLoading ? null : () => openUpdateRoleModel(member),
                            ),
                            member.isInvited
                                ? ProfileField(
                                    placeholderPrefix: '',
                                    title: 'La invitacion expira el',
                                    icon: Icons.calendar_today,
                                    value: member.invitationExpiredAtFormatted,
                                  )
                                : ProfileField(
                                    title: 'Miembro desde',
                                    icon: Icons.calendar_today,
                                    value: member.memberCreatedAtFormatted,
                                  )
                          ]),
                    ),
                  ],
                ),
              ),
            );
          }
          return Container();
        });
  }

  Future<bool> isCurrentUser(MemberView member) async {
    final currentUser = CurrentUserBloc().state;
    if (currentUser == null) return false;

    return member.userId == currentUser.userId;
  }

  void openUpdateNameModal(MemberView member) async {
    final String? newName = await openUpdateStringFieldModal(context,
        title: 'Nombre en el espacio',
        hintText: 'Introduce el nuevo nombre',
        initialValue: member.memberName);
    final bool isNewNameValid = member.memberName != newName && newName != null;

    if (isNewNameValid) {
      updateMemberName(newName, member);
    }
  }

  void updateMemberName(String newName, MemberView member) {
    wrapLoadingTransaction(() async {
      await MemberService().updateMember(
          member.spaceId!, member.memberId!, newName, member.role!);
      member.memberName = newName;
    });
  }

  void openUpdateRoleModel(MemberView member) async {
    if (member.role == SpaceRole.admin) {
      final admins =
          await MemberService().getAdministrators(member.spaceId!);

      final existsAnotherAdministrator = admins.length > 1;
      if (!existsAnotherAdministrator) {
        await openAlertDialog(context,
            title: 'No es posible actualizar él rol',
            content:
                'Es requerido tener al menos un administrador dentro del espacio.');
        return;
      }
    }

    await showModalBottomSheet(
      context: context,
      builder: (context) {
        return SelectRoleModal(
            updateRole: (role) => updateRole(role, member), currentRole: member.role!);
      },
    );
  }

  void updateRole(SpaceRole newRole, MemberView member) {
    wrapLoadingTransaction(() async {
      if (newRole != member.role) {
        await MemberService().updateMember(member.spaceId!,
            member.memberId!, member.memberName, newRole);
          member.role = newRole;
      }
    });
  }
}

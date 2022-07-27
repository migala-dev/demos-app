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

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:demos_app/config/routes/routes.dart';
import 'package:demos_app/modules/spaces/validators/is_current_user_admin.widget_validator.dart';
import 'package:demos_app/widgets/wrappers/safe_widget/safe_widget_validator.dart';
import 'package:demos_app/modules/spaces/pages/new_space/screens/members/search/members_search.delegate.dart';
import 'package:demos_app/modules/spaces/pages/new_space/screens/members/bloc/space_members_bloc.dart';
import 'package:demos_app/modules/spaces/pages/new_space/screens/members/widgets/members_list_view.widget.dart';
import 'package:demos_app/modules/spaces/pages/new_space/screens/members/widgets/member_type_filter.widget.dart';
import 'package:demos_app/modules/spaces/pages/new_space/screens/members/enums/member_type.dart';
import 'package:demos_app/modules/spaces/models/member_view.model.dart';
import 'package:demos_app/core/enums/invitation-status.enum.dart';

class SpaceMembersScreen extends StatefulWidget {
  const SpaceMembersScreen({Key? key}) : super(key: key);

  @override
  State<SpaceMembersScreen> createState() => _SpaceMembersScreenState();
}

class _SpaceMembersScreenState extends State<SpaceMembersScreen> {
  MemberType filter = MemberType.all;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SpaceMembersBloc, SpaceMembersState>(
      bloc: SpaceMembersBloc(),
      builder: (context, state) {
        return Scaffold(
          appBar: AppBar(
            title: const Text('Miembros'),
            actions: [
              IconButton(
                  onPressed: () async {
                    await showSearch(
                        context: context, delegate: MembersSearchDelegate());
                  },
                  icon: const Icon(Icons.search))
            ],
          ),
          body: getBody(state),
          floatingActionButton: SafeWidgetValidator(
            validators: [IsCurrentUserAdminWidgetValidator()],
            child: FloatingActionButton(
                child: const Icon(Icons.person_add),
                onPressed: () =>
                    Navigator.pushNamed(context, Routes.invitations)),
          ),
        );
      },
    );
  }

  Widget getBody(SpaceMembersState state) {
    if (state is SpaceMembersWithData) {
      final members = state.memberViews;
      final filteredMembers = _getMembersFiltered(filter, members);

      return Column(
        children: [
          SizedBox(
            height: 70,
            child: MemberTypeFilter(
              selected: filter,
              onFilteredMembersChange: _onFilteredMembersChange,
            ),
          ),
          Expanded(child: MembersListView(memberViews: filteredMembers))
        ],
      );
    }

    return const Center(
      child: CircularProgressIndicator(),
    );
  }

  void _onFilteredMembersChange(MemberType newFilter) => setState(
        () {
          if (filter == newFilter) {
            filter = MemberType.all;
          } else {
            filter = newFilter;
          }
        },
      );

  List<MemberView> _getMembersFiltered(
      MemberType filter, List<MemberView> members) {
    if (filter == MemberType.all) return members;

    return members
        .where((member) =>
            filter == member.memberType &&
            member.invitationStatus != InvitationStatus.canceled &&
            member.invitationStatus != InvitationStatus.rejected)
        .toList();
  }
}

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
import 'package:demos_app/modules/spaces/models/member.view.dart';
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
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 15),
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

  void _onFilteredMembersChange(MemberType newFilter) => setState(() {
        if (filter == newFilter) {
          filter = MemberType.all;
        } else {
          filter = newFilter;
        }
      });

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

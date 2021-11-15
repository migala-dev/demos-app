import 'package:flutter/material.dart';

import 'package:demos_app/modules/spaces/pages/new_space/screens/members/models/member_type.dart';
import 'package:demos_app/modules/spaces/pages/new_space/screens/members/utils/labels.dart';
import 'package:demos_app/modules/spaces/pages/new_space/screens/members/models/member.view.dart';
import 'package:demos_app/modules/spaces/pages/new_space/screens/members/services/members_screen.service.dart';
import 'package:demos_app/modules/spaces/pages/new_space/screens/members/widgets/member_tile.widget.dart';
import 'package:demos_app/modules/spaces/pages/new_space/screens/members/widgets/member_type_filter.widget.dart';
import 'package:demos_app/core/enums/space-role.enum.dart';
import 'package:demos_app/core/enums/invitation-status.enum.dart';

class SpaceMembersScreen extends StatefulWidget {
  const SpaceMembersScreen({Key? key}) : super(key: key);

  @override
  State<SpaceMembersScreen> createState() => _SpaceMembersScreenState();
}

class _SpaceMembersScreenState extends State<SpaceMembersScreen> {
  bool isLoading = true;
  MemberType selected = MemberType(all);

  List<MemberView> members = [];

  @override
  void initState() {
    super.initState();
    _getMembers();
  }

  @override
  Widget build(BuildContext context) {
    final filteredMembers = _getMembersSelected(selected.label);

    return Scaffold(
      appBar: AppBar(
        title: Text('Miembros'),
        actions: [IconButton(onPressed: () {}, icon: Icon(Icons.search))],
      ),
      body: isLoading
          ? Center(
              child: CircularProgressIndicator(),
            )
          : Column(
              children: [
                MemberTypeFilter(
                  selected: selected,
                  onFilteredMembersChange: _onFilteredMembersChange,
                ),
                Expanded(
                  child: ListView.builder(
                    itemCount: filteredMembers.length,
                    physics: BouncingScrollPhysics(),
                    itemBuilder: (context, index) {
                      return MemberTile(member: filteredMembers[index]);
                    },
                  ),
                )
              ],
            ),
    );
  }

  Future<void> _getMembers() async {
    setState(() {
      isLoading = true;
    });

    final spacesMembersService = MembersScreenService();
    final membersResult = await spacesMembersService.getMemberViews();
    members = membersResult;

    setState(() {
      isLoading = false;
    });
  }

  void _onFilteredMembersChange(String newSelect) => setState(() {
        selected = MemberType(newSelect);
      });

  List<MemberView> _getMembersSelected(String newSelect) {
    if (newSelect == invitations) {
      return members
          .where((member) => member.invitationStatus == InvitationStatus.SENDED)
          .toList();
    }

    if (newSelect == administrator) {
      return members.where((member) => member.role == SpaceRole.ADMIN).toList();
    }

    if (newSelect == leader) {
      return [];
    }

    return members;
  }
}

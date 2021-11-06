import 'package:demos_app/core/enums/space-role.enum.dart';
import 'package:demos_app/modules/spaces/pages/spaces/screens/members/models/member_view.model.dart';
import 'package:demos_app/modules/spaces/pages/spaces/screens/members/services/spaces_members.service.dart';
import 'package:demos_app/modules/spaces/pages/spaces/screens/members/widgets/member_tile.widget.dart';
import 'package:demos_app/modules/spaces/pages/spaces/screens/members/widgets/select_members_type_bar.widgets.dart';
import 'package:flutter/material.dart';

class SpaceMembersScreen extends StatefulWidget {
  const SpaceMembersScreen({Key? key}) : super(key: key);

  @override
  State<SpaceMembersScreen> createState() => _SpaceMembersScreenState();
}

class _SpaceMembersScreenState extends State<SpaceMembersScreen> {
  bool isLoading = true;
  String selected = 'Todos';

  List<MemberView> members = [];
  List<MemberView> membersSelected = [];

  @override
  void initState() {
    SpacesMembersService().getSpaceMembers().then((membersResult) => {
          setState(() {
            members = membersResult;
            membersSelected = membersResult;
            isLoading = false;
          })
        });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
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
                SelectMembersTypeBar(
                  selected: selected,
                  onSelectedMembersChange: _onSelectedMembersChange,
                ),
                Expanded(
                  child: ListView.builder(
                    itemCount: membersSelected.length,
                    physics: BouncingScrollPhysics(),
                    itemBuilder: (context, index) {
                      return MemberTile(member: membersSelected[index]);
                    },
                  ),
                )
              ],
            ),
    );
  }

  void _onSelectedMembersChange(String newSelect) => setState(() {
        selected = newSelect;

        membersSelected = _getMembersSelected(newSelect);
      });

  List<MemberView> _getMembersSelected(String newSelect) {
    if (newSelect == 'Invitaciones') {
      return members
          .where((member) => member.role == SpaceRole.INVITED)
          .toList();
    }

    if (newSelect == 'Administrador') {
      return members.where((member) => member.role == SpaceRole.ADMIN).toList();
    }

    if (newSelect == 'Jefe') {
      return [];
    }

    return members;
  }
}

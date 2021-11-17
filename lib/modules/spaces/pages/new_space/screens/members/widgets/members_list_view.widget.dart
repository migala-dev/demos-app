import 'package:demos_app/config/routes/routes.dart';
import 'package:flutter/material.dart';
import 'package:demos_app/modules/spaces/pages/new_space/screens/members/models/member.view.dart';
import 'package:demos_app/modules/spaces/pages/new_space/screens/members/widgets/member_tile.widget.dart';

class MembersListView extends StatelessWidget {
  const MembersListView({
    Key? key,
    required this.memberViews,
  }) : super(key: key);

  final List<MemberView> memberViews;

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: memberViews.length,
      physics: BouncingScrollPhysics(),
      itemBuilder: (context, index) {
        return GestureDetector(
            child: MemberTile(member: memberViews[index]),
            onTap: () => Navigator.pushNamed(context, Routes.memberProfile));
      },
    );
  }
}

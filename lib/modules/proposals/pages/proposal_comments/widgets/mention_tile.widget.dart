import 'package:demos_app/config/themes/main_theme.dart';
import 'package:demos_app/modules/spaces/models/member_view.model.dart';
import 'package:demos_app/widgets/profile/profile_picture.widget.dart';
import 'package:flutter/material.dart';

class MentionTile extends StatelessWidget {
  final MemberView member;
  final double pictureProfileWidth = 20.0;

  const MentionTile({Key? key, required this.member}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final width = pictureProfileWidth + (member.displayName.length * 10);
    return Container(
      height: 25,
      width: width,
      padding: const EdgeInsets.symmetric(horizontal: 5),
      margin: const EdgeInsets.only(left: 5),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: secondaryColor,
      ),
      child: Row(
        children: [
          ProfilePicture(
            width: pictureProfileWidth,
            percentage: 1,
            imageKey: member.profilePictureKey,
          ),
          const SizedBox(width: 5),
          Text(member.displayName),
        ],
      ),
    );
  }
}

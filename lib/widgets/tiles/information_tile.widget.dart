import 'package:flutter/material.dart';
import 'package:demos_app/core/models/space.model.dart';
import 'package:demos_app/core/models/user.model.dart';
import 'package:demos_app/widgets/profile/profile_picture.widget.dart';
import 'package:demos_app/widgets/space/space_picture.widget.dart';

class InformationTile extends StatelessWidget {
  InformationTile({Key? key, this.space, this.user, required this.onTap})
      : super(key: key) {
    assert(space == null || user == null,
        'You cannot provide a user and a space at the same time');
  }

  final Space? space;
  final User? user;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final Widget picture = getPicture();
    final String? name = getName();
    final String? createdAt = getCreatedAt();

    return Container(
      margin: EdgeInsets.only(top: 16),
      child: ListTile(
        leading: picture,
        title: Text(
          name ?? '',
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
        ),
        subtitle: Text("Creado el $createdAt"),
        visualDensity: VisualDensity(vertical: VisualDensity.maximumDensity),
        minVerticalPadding: 16,
        onTap: onTap,
        contentPadding: EdgeInsets.symmetric(horizontal: 28),
        horizontalTitleGap: 16,
      ),
    );
  }

  Widget getPicture() {
    return this.space != null
        ? SpacePicture(width: 64, pictureKey: space?.pictureKey)
        : ProfilePicture(width: 164, imageKey: user?.profilePictureKey);
  }

  String? getName() {
    return this.space != null ? this.space?.name : this.user?.name;
  }

  String? getCreatedAt() {
    return this.space != null
        ? space?.createdAtFormatted
        : user?.createdAtFormatted;
  }
}

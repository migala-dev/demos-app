import 'package:demos_app/core/models/member.model.dart';
import 'package:demos_app/core/repositories/members.repository.dart';
import 'package:demos_app/modules/spaces/pages/spaces/services/space.bloc.dart';
import 'package:demos_app/widgets/profile/profile_picture.widget.dart';
import 'package:flutter/material.dart';
import 'package:demos_app/core/models/user.model.dart';
import 'package:demos_app/core/repositories/users.repository.dart';

class CreatedByChip extends StatelessWidget {
  final String userId;
  const CreatedByChip({Key? key, required this.userId}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: Future.wait([getUser(), getMemberDisplayName()]),
      builder: (BuildContext context, AsyncSnapshot<List> snapshot) {
        if (!snapshot.hasData) {
          return const SizedBox(
              height: 15, width: 15, child: CircularProgressIndicator());
        }

        final User? user = snapshot.data![0];
        final String displayName = snapshot.data![1];

        if (user != null) {
          return Row(
            children: [
              SizedBox(
                height: 15,
                width: 15,
                child: ProfilePicture(imageKey: user.profilePictureKey),
              ),
              const SizedBox(width: 10),
              Text(displayName, style: const TextStyle(color: Colors.grey))
            ],
          );
        }
        return Row(
          children: [
            Container(
              height: 15,
              width: 15,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  color: Colors.grey[400]),
            ),
            const SizedBox(width: 10),
            const Text('Usuario', style: TextStyle(color: Colors.grey))
          ],
        );
      },
    );
  }

  Future<User?> getUser() async {
    final User? user = await UsersRepository().findById(userId);

    return user;
  }

  Future<String> getMemberDisplayName() async {
    final String spaceId = SpaceBloc().state!.spaceId!;
    final Member? member = await MembersRepository()
        .findByUserIdAndSpaceIdAndInvitationStatusAccepted(userId, spaceId);

    if (member != null) {
      if (member.name != null && member.name!.isNotEmpty) {
        return member.name!;
      }

      final User? user = await UsersRepository().findById(userId);
      if (user != null && user.name.isNotEmpty) {
        return user.name;
      }
    }

    return 'Sin nombre';
  }
}

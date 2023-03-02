import 'package:demos_app/config/routes/routes.dart';
import 'package:demos_app/core/bloc/current_user_bloc/current_user_bloc.dart';
import 'package:demos_app/widgets/profile/profile_picture.widget.dart';
import 'package:flutter/material.dart';

class GoToProfile extends StatelessWidget {
  const GoToProfile({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final currentUser = CurrentUserBloc().state;
    return Container(
      margin: const EdgeInsets.only(right: 14, top: 8),
      child: GestureDetector(
        child: ProfilePicture(
          width: 100,
          imageKey: currentUser!.profilePictureKey,
        ),
        onTap: () => Navigator.of(context).pushNamed(Routes.profileSettings),
      ),
    );
  }
}

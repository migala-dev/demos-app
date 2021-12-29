import 'package:demos_app/core/services/current_user/current_user.service.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:demos_app/core/bloc/current_user_bloc/current_user_bloc.dart';
import 'package:demos_app/core/models/user.model.dart';
import 'package:demos_app/widgets/pages/image_editor.page.dart';
import 'package:demos_app/widgets/profile/profile_form.widget.dart';
import 'package:demos_app/widgets/profile/profile_picture.widget.dart';

class Profile extends StatelessWidget {
  final List<Widget>? children;
  const Profile({Key? key, this.children}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          BlocBuilder<CurrentUserBloc, User?>(
            bloc: CurrentUserBloc(),
            builder: (context, state) {
              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Center(
                      child: ProfilePicture(
                    imageKey: state?.profilePictureKey,
                    onPictureEditPress: () => onPictureEditPress(context),
                  )),
                  Container(
                    margin: const EdgeInsets.only(top: 20.0),
                    child: ProfileForm(
                      onEditNamePress: (String? name) {
                        updateName(name);
                      },
                      user: state,
                    ),
                  ),
                ],
              );
            },
          ),
          Column(
            children: children ?? [],
          ),
        ],
      ),
    );
  }

  void updateName(String? name) async {
    if (name == null && name == '') return;

    final user = await CurrentUserService().updateUserName(name);
    CurrentUserBloc().add(CurrentUserUpdated(user));
  }

  void onPictureEditPress(BuildContext context) async {
    final image = await Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => const ImageEditorPage(),
        ));

    if (image != null) {
      final user = await CurrentUserService().uploadProfileImage(image);
      CurrentUserBloc().add(CurrentUserUpdated(user));
    }
  }
}

import 'package:demos_app/core/models/user.model.dart';
import 'package:demos_app/core/services/current_user.service.dart';
import 'package:demos_app/utils/mixins/loading_state_handler.mixin.dart';
import 'package:demos_app/widgets/pages/image_editor.page.dart';
import 'package:demos_app/widgets/profile/profile_form.widget.dart';
import 'package:demos_app/widgets/profile/profile_picture.widget.dart';
import 'package:flutter/material.dart';

class Profile extends StatefulWidget {
  final List<Widget>? children;
  const Profile({Key? key, this.children}) : super(key: key);

  @override
  _ProfileState createState() => _ProfileState();
}

class _ProfileState extends State<Profile> with LoadingStateHandler {
  User? _currentUser;

  _ProfileState() {
    initCurrentUser();
  }

  void initCurrentUser() async {
    User? currentUser = await CurrentUserService().getCurrentUser();
    if (currentUser != null) {
      setUser(currentUser);
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Center(
                  child: ProfilePicture(
                imageKey: _currentUser?.profilePictureKey,
                onPictureEditPress: onPictureEditPress,
              )),
              Container(
                margin: const EdgeInsets.only(top: 20.0),
                child: ProfileForm(
                  onEditNamePress: (String? name) {
                    updateName(name);
                  },
                  user: _currentUser,
                ),
              ),
            ],
          ),
          Column(
            children: widget.children ?? [],
          ),
        ],
      ),
    );
  }

  void updateName(String? name) async {
    if (name == null) return;
    if (name == '') return;

    wrapLoadingTransaction(() async {
      User? user = await CurrentUserService().updateUserName(name);
      if (user != null) {
        setState(() {
          _currentUser = user;
        });
      }
    });
  }

  void onPictureEditPress() async {
    final image = await Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => const ImageEditorPage(),
        ));

    wrapLoadingTransaction(() async {
      if (image != null) {
        User? user = await CurrentUserService().uploadProfileImage(image);
        if (user != null) {
          setUser(user);
        }
      }
    });
  }

  void setUser(User user) async {
    setState(() {
      _currentUser = user;
    });
  }
}

import 'package:demos_app/core/models/user.model.dart';
import 'package:demos_app/core/services/bucket.service.dart';
import 'package:demos_app/core/services/user.service.dart';
import 'package:demos_app/utils/mixins/loading_state_handler.mixin.dart';
import 'package:demos_app/widgets/pages/image_editor.page.dart';
import 'package:demos_app/widgets/profile/profile_form.widget.dart';
import 'package:demos_app/widgets/profile/profile_picture.widget.dart';
import 'package:flutter/material.dart';

class Profile extends StatefulWidget {
  final List<Widget>? children;
  Profile({Key? key, this.children}) : super(key: key);

  @override
  _ProfileState createState() => _ProfileState(children);
}

class _ProfileState extends State<Profile> with LoadingStateHandler {
  User? _currentUser;
  String? _imageUrl;
  final List<Widget>? children;

  _ProfileState(this.children) {
    initCurrentUser();
  }

  void initCurrentUser() async {
    User? currentUser = await UserService().getCurrentUser();
    if (currentUser != null) {
      setUserAndImageUrl(currentUser);
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
                editable: true,
                imageUrl: _imageUrl,
                onPictureEditPress: onPictureEditPress,
              )),
              Container(
                margin: EdgeInsets.only(top: 20.0),
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
            children: children ?? [],
          ),
        ],
      ),
    );
  }

  void updateName(String? name) async {
    wrapLoadingTransaction(() async {
      User? user = await UserService().updateUserName(name);
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
          builder: (context) => ImageEditorPage(),
        ));

    wrapLoadingTransaction(() async {
      if (image != null) {
        User? user = await UserService().uploadProfileImage(image);
        if (user != null) {
          setUserAndImageUrl(user);
        }
      }
    });
  }

  void setUserAndImageUrl(User user) async {
    String imageUrl =
        await BucketService().getUrlFromKey(user.profilePictureKey);
    setState(() {
      _currentUser = user;
      _imageUrl = imageUrl;
    });
  }
}

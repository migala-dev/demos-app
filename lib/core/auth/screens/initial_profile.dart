import 'package:demos_app/config/routes/routes.dart';
import 'package:demos_app/core/models/user.model.dart';
import 'package:demos_app/utils/mixins/loading_state_handler.mixin.dart';
import 'package:demos_app/utils/services/bucket.service.dart';
import 'package:demos_app/utils/services/user.service.dart';
import 'package:demos_app/widgets/pages/image_editor.page.dart';
import 'package:flutter/material.dart';

import 'package:demos_app/widgets/buttons/big_button_widget.dart';
import 'package:demos_app/widgets/profile/profile_info_widget.dart';
import 'package:demos_app/widgets/profile/profile_picture_widget.dart';

class InitialProfile extends StatefulWidget {
  const InitialProfile({Key? key}) : super(key: key);

  @override
  _InitialProfileState createState() => _InitialProfileState();
}

class _InitialProfileState extends State<InitialProfile>
    with LoadingStateHandler {
  User? _currentUser;
  String? _imageUrl;

  _InitialProfileState() {
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
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 15),
        child: SafeArea(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Perfil',
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 35,
                    ),
                    textAlign: TextAlign.start,
                  ),
                  Center(
                      child: ProfilePicture(
                    editable: true,
                    imageUrl: _imageUrl,
                    onPictureEditPress: onPictureEditPress,
                  )),
                  Container(
                    margin: EdgeInsets.only(top: 20.0),
                    child: ProfileInfo(
                      onEditNamePress: (String? name) {
                        updateName(name);
                      },
                      user: _currentUser,
                    ),
                  )
                ],
              ),
              BigButton(
                text: 'CONTINUAR',
                onPressed: goToSpaces,
                isLoading: isLoading,
              )
            ],
          ),
        ),
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

  void goToSpaces() {
    Navigator.pushNamedAndRemoveUntil(context, Routes.spaces, (r) => false);
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

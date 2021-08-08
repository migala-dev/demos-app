import 'package:demos_app/config/routes/routes.dart';
import 'package:demos_app/core/models/user.model.dart';
import 'package:demos_app/utils/services/user.service.dart';
import 'package:flutter/material.dart';

import 'package:demos_app/widgets/buttons/big_button_widget.dart';
import 'package:demos_app/widgets/profile/profile_info_widget.dart';
import 'package:demos_app/widgets/profile/profile_picture_widget.dart';

class Profile extends StatefulWidget {
  const Profile({Key? key}) : super(key: key);

  @override
  _ProfileState createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  User? _currentUser;

  _ProfileState() {
    initCurrentUser();
  }

  void initCurrentUser() async {
    User? currentUser = await UserService().getCurrentUser();
    setState(() {
      _currentUser = currentUser;
    });
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
                    onPictureEditPress: () {},
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
              BigButton(text: 'CONTINUAR', onPressed: goToSpaces)
            ],
          ),
        ),
      ),
    );
  }

  void updateName(String? name) async {
    User? user = await UserService().updateUserName(name);
    if (user != null) {
      setState(() {
        _currentUser = user;
      });
    }
  }

  void goToSpaces() {
    Navigator.pushNamedAndRemoveUntil(context, Routes.spaces, (r) => false);
  }
}

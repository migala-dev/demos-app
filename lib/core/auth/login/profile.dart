import 'package:flutter/material.dart';

import 'package:demos_app/widgets/buttons/bigbutton_widget.dart';
import 'package:demos_app/widgets/profile/profile_info_editname_widget.dart';
import 'package:demos_app/widgets/profile/edit_profile_picture_widget.dart';

class Profile extends StatelessWidget {
  const Profile({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 15),
        child: SafeArea(
          child: Column(
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
              SizedBox(
                height: 25,
              ),
              Center(
                  child: EditProfilePicture(
                onPictureEditPress: () {},
              )),
              SizedBox(
                height: 25,
              ),
              ProfileInfoAndEditName(
                onEditNamePress: () {},
              ),
              Spacer(),
              BigButton(text: 'CONTINUAR', onPressed: () {})
            ],
          ),
        ),
      ),
    );
  }
}

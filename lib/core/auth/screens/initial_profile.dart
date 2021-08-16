import 'package:demos_app/config/routes/routes.dart';
import 'package:demos_app/widgets/profile/profile.widget.dart';
import 'package:flutter/material.dart';

import 'package:demos_app/widgets/buttons/big_button_widget.dart';

class InitialProfile extends StatefulWidget {
  const InitialProfile({Key? key}) : super(key: key);

  @override
  _InitialProfileState createState() => _InitialProfileState();
}

class _InitialProfileState extends State<InitialProfile> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
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
              Expanded(
                  child: Profile(
                children: [
                  BigButton(
                    text: 'CONTINUAR',
                    onPressed: goToSpaces,
                  )
                ],
              ))
            ],
          ))),
    );
  }

  void goToSpaces() {
    Navigator.pushNamedAndRemoveUntil(context, Routes.spaces, (r) => false);
  }
}

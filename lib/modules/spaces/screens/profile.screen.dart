import 'package:demos_app/widgets/profile/profile.widget.dart';
import 'package:flutter/material.dart';

class ProfileSettingScreen extends StatefulWidget {
  const ProfileSettingScreen({Key? key}) : super(key: key);

  @override
  _ProfileState createState() => _ProfileState();
}

class _ProfileState extends State<ProfileSettingScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        resizeToAvoidBottomInset: false,
        appBar: AppBar(
          title: const Text('Perfil'),
        ),
        body: Container(
          margin: const EdgeInsets.symmetric(vertical: 28, horizontal: 28),
          child: const Profile(),
        ));
  }
}

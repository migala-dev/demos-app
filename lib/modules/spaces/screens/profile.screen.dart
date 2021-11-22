import 'package:demos_app/widgets/profile/profile.widget.dart';
import 'package:demos_app/widgets/scaffolds/demos_scaffold.widget.dart';
import 'package:flutter/material.dart';

class ProfileSettingScreen extends StatefulWidget {
  ProfileSettingScreen({Key? key}) : super(key: key);

  @override
  _ProfileState createState() => _ProfileState();
}

class _ProfileState extends State<ProfileSettingScreen> {
  @override
  Widget build(BuildContext context) {
    return DemosScaffold(
        resizeToAvoidBottomInset: false,
        appBar: AppBar(
          title: Text('Perfil'),
        ),
        body: Container(
          margin: EdgeInsets.symmetric(vertical: 28, horizontal: 28),
          child: Profile(),
        ));
  }
}

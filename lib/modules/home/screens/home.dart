import 'package:demos_app/config/routes/application.dart';
import 'package:fluro/fluro.dart';
import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {
  //final String username;

  HomePage();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Home'),
      ),
      body: Center(
        child: Text('Welcome home!'),
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.settings_backup_restore),
        onPressed: () {
          Application.router
              .navigateTo(context, "/login", transition: TransitionType.fadeIn);
        },
      ),
    );
  }
}

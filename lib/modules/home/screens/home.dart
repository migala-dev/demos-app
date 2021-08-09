import 'package:demos_app/config/themes/cubit/theme_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomePage extends StatelessWidget {
  HomePage();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Espacios'),
        actions: [
          IconButton(
              onPressed: () => context.read<ThemeCubit>().changeTheme(),
              icon: Icon(Icons.brightness_1))
        ],
      ),
      body: Center(
        child: Text('Bienvenido a DEMOS app!!!'),
      ),
    );
  }
}

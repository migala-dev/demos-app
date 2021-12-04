import 'package:demos_app/config/themes/cubit/theme_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class GeneralConfigurationScreen extends StatelessWidget {
  const GeneralConfigurationScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final themeCubit = context.read<ThemeCubit>();

    return Scaffold(
      appBar: AppBar(
        title: const Text('Configuración'),
      ),
      body: BlocBuilder<ThemeCubit, ThemeData>(
        builder: (context, state) {
          return Column(children: [
            SwitchListTile(
                secondary: const Icon(Icons.dark_mode_sharp),
                title: const Text('Modo oscuro'),
                value: themeCubit.isDark,
                onChanged: (v) => themeCubit.toggleTheme())
          ]);
        },
      ),
    );
  }
}

import 'package:demos_app/utils/ui/modals/open_confirmation_dialog.dart';
import 'package:flutter/material.dart';
import 'package:demos_app/config/routes/routes.dart';
import 'package:demos_app/core/models/space.model.dart';
import 'package:demos_app/modules/spaces/pages/space_details/screens/space_settings/widgets/setting_items.widget.dart';
import 'package:demos_app/modules/spaces/pages/spaces/services/space.bloc.dart';
import 'package:demos_app/widgets/simbols/powered_by_migala.dart';
import 'package:demos_app/widgets/tiles/information_tile.widget.dart';
import 'package:demos_app/widgets/space/space_picture.widget.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SpaceSettingsScreen extends StatelessWidget {
  const SpaceSettingsScreen({Key? key}) : super(key: key);

  void goToSpacePercentageSettings(BuildContext context) =>
      Navigator.pushNamed(context, Routes.spacePercentage);

  void goToSpaceMembers(BuildContext context) =>
      Navigator.pushNamed(context, Routes.spaceMembers);

  void goToEditSpace(BuildContext context) =>
      Navigator.pushNamed(context, Routes.editSpace);

  void goToSpaces(BuildContext context) => Navigator.pushNamedAndRemoveUntil(
      context, Routes.spaces, (route) => false);

  void exitSpace(BuildContext context) {
    openConfirmationDialog(context,
        content: '¿Deseas salir de este espacio?',
        accept: () => goToSpaces(context));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Ajustes'),
      ),
      body: Column(
        children: [
          BlocBuilder<SpaceBloc, Space?>(
              bloc: SpaceBloc(),
              builder: (context, space) {
                if (space == null) {
                  return Container();
                }
                return InformationTile(
                  picture:
                      SpacePicture(width: 64, pictureKey: space.pictureKey),
                  name: space.name ?? '',
                  subtitle: 'Creado el ${space.createdAtFormatted}',
                  onTap: () => goToEditSpace(context),
                );
              }),
          const SizedBox(height: 8),
          const Divider(thickness: 1),
          SettingItem(
              title: 'Votos',
              subtitle:
                  'Porcentaje de participación y aprovación de las propuestas',
              icon: Icons.how_to_vote,
              onTap: () => goToSpacePercentageSettings(context)),
          const SizedBox(height: 12),
          SettingItem(
              title: 'Miembros',
              subtitle: 'Usuarios, invitaciones y roles',
              icon: Icons.people,
              onTap: () => goToSpaceMembers(context)),
          SettingItem(
              title: 'Salir del Espacio',
              subtitle: 'Esta opción te removera del espacio',
              icon: Icons.logout,
              color: Colors.red,
              onTap: () => exitSpace(context)),
          Expanded(flex: 4, child: Container()),
          const Expanded(
            flex: 1,
            child: PoweredByMigala(),
          )
        ],
      ),
    );
  }
}

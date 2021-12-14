import 'package:demos_app/widgets/simbols/version_and_build_number.widget.dart';
import 'package:flutter/material.dart';
import 'package:demos_app/config/routes/routes.dart';
import 'package:demos_app/core/models/user.model.dart';
import 'package:demos_app/core/services/current_user.service.dart';
import 'package:demos_app/widgets/profile/profile_picture.widget.dart';
import 'package:demos_app/widgets/simbols/powered_by_migala.dart';
import 'package:demos_app/widgets/tiles/information_tile.widget.dart';
import 'package:demos_app/modules/spaces/pages/space_details/screens/space_settings/widgets/setting_items.widget.dart';

class GeneralSettingsScreen extends StatelessWidget {
  const GeneralSettingsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Ajustes')),
      body: FutureBuilder(
        future: CurrentUserService().getCurrentUser(),
        builder: (BuildContext context, AsyncSnapshot<User?> snapshot) {
          if (snapshot.hasData) {
            final User currentUser = snapshot.data!;

            return Column(
              children: [
                InformationTile(
                  picture: ProfilePicture(
                      width: 164, imageKey: currentUser.profilePictureKey),
                  name: currentUser.name,
                  subtitle: 'Creado el ${currentUser.createdAtFormatted}',
                  onTap: () => goToProfileSettings(context),
                ),
                const SizedBox(height: 8),
                const Divider(thickness: 1),
                SettingItem(
                    title: 'Configuración',
                    subtitle: 'Configura los colores de la aplicación',
                    icon: Icons.settings,
                    onTap: () => goToConfiguration(context)),
                const Spacer(),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: const [VersionAndBuildNumber(), PoweredByMigala()],
                ),
                const SizedBox(
                  height: 10,
                )
              ],
            );
          }
          return Container();
        },
      ),
    );
  }

  void goToConfiguration(BuildContext context) =>
      Navigator.pushNamed(context, Routes.configuration);

  void goToProfileSettings(BuildContext context) =>
      Navigator.pushNamed(context, Routes.profileSettings);
}

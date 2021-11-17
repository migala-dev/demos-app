import 'package:demos_app/config/routes/routes.dart';
import 'package:demos_app/core/models/space.model.dart';
import 'package:demos_app/modules/spaces/pages/space_details/widgets/setting_items.widget.dart';
import 'package:demos_app/modules/spaces/pages/spaces/services/current_space.service.dart';
import 'package:demos_app/widgets/simbols/powered_by_migala.dart';
import 'package:demos_app/widgets/tiles/information_tile.widget.dart';
import 'package:flutter/material.dart';

class SpaceSettingsScreen extends StatelessWidget {
  const SpaceSettingsScreen({Key? key}) : super(key: key);

  void goToSpacePercentageSettings(BuildContext context) {
    Navigator.pushNamed(context, Routes.spacePercentage);
  }

  void goToSpaceMembers(BuildContext context) {
    Navigator.pushNamed(context, Routes.spaceMembers);
  }

  @override
  Widget build(BuildContext context) {
    Space currentSpace = CurrentSpaceService().getCurrentSpace()!;

    return Scaffold(
      appBar: AppBar(
        title: Text("Ajustes"),
      ),
      body: Column(
        children: [
          InformationTile(space: currentSpace, onTap: () {}),
          SizedBox(height: 8),
          Divider(thickness: 1),
          SettingItem(
              title: "Votos",
              subtitle:
                  "Porcentaje de participación y aprovación de las propuestas",
              icon: Icons.how_to_vote,
              onTap: () => goToSpacePercentageSettings(context)),
          SettingItem(
              title: "Miembros",
              subtitle: "Usuarios, invitaciones y roles",
              icon: Icons.people,
              onTap: () => goToSpaceMembers(context)),
          Expanded(flex: 5, child: Container()),
          Expanded(
            flex: 1,
            child: PoweredByMigala(),
          )
        ],
      ),
    );
  }
}

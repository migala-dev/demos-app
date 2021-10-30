import 'package:demos_app/config/routes/routes.dart';
import 'package:demos_app/core/models/space.model.dart';
import 'package:demos_app/modules/spaces/pages/spaces/services/current_space.service.dart';
import 'package:demos_app/shared/services/date.service.dart';
import 'package:demos_app/widgets/space/space_picture.widget.dart';
import 'package:flutter/material.dart';

class SpaceSettings extends StatelessWidget {
  const SpaceSettings({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Space? currentSpace = CurrentSpaceService().getCurrentSpace();


    MaterialApp(
      routes: {Routes.spacesDetails: (context) => const SpaceSettings()},
    );

    String createdAt =
        DateService.parseToStandardDate(currentSpace?.createdAt ?? '');

    return Scaffold(
      appBar: AppBar(
        title: Text("Ajustes"),
      ),
      body: Column(
        children: [
          SizedBox(height: 16),
          ListTile(
            leading: SpacePicture(width: 64, pictureKey: currentSpace?.pictureKey),
            title: Text(
              currentSpace?.name ?? '',
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
            ),
            subtitle: Text("Creado el $createdAt"),
            visualDensity:
                VisualDensity(vertical: VisualDensity.maximumDensity),
            minVerticalPadding: 16,
            onTap: () {},
            contentPadding: EdgeInsets.symmetric(horizontal: 28),
            horizontalTitleGap: 16,
          ),
          SizedBox(height: 8),
          Divider(thickness: 1),
          SizedBox(height: 8),
          optionsTile(
              "Votos",
              "Porcentaje de participación y aprovación de las propuestas",
              Icons.how_to_vote,
              ""),
          SizedBox(height: 8),
          optionsTile(
              "Miembros", "Usuarios, invitaciones y roles", Icons.people, ""),
          Expanded(flex: 5, child: Container()),
          Expanded(
            flex: 1,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Container(
                  margin: EdgeInsets.only(right: 16),
                  child: Column(
                    children: [
                      Text(
                        "powered by",
                        style: TextStyle(fontWeight: FontWeight.w300),
                      ),
                      Text("Migala",
                          style: TextStyle(
                              fontSize: 24, fontWeight: FontWeight.bold))
                    ],
                  ),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}

ListTile optionsTile(String text, String subText, IconData icon, var action) {
  return ListTile(
    leading: Icon(icon, size: 32),
    title: Text(
      text,
      style: TextStyle(fontSize: 18),
    ),
    subtitle: Text(
      subText,
      style: TextStyle(fontSize: 12),
    ),
    onTap: () {
      action;
    },
    contentPadding: EdgeInsets.symmetric(horizontal: 28),
    horizontalTitleGap: 8,
  );
}

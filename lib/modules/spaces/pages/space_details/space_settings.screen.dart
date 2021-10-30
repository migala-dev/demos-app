import 'package:demos_app/modules/spaces/models/space_view.model.dart';
import 'package:demos_app/modules/spaces/pages/space_details/widgets/setting_items.widget.dart';
import 'package:demos_app/shared/services/date.service.dart';
import 'package:demos_app/widgets/space/space_picture.widget.dart';
import 'package:flutter/material.dart';

class SpaceSettingsScreen extends StatelessWidget {
  const SpaceSettingsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final SpaceView spaceView =
        ModalRoute.of(context)?.settings.arguments as SpaceView;

    String createdAt =
        DateService.parseToStandardDate(spaceView.createdAt ?? '');

    return Scaffold(
      appBar: AppBar(
        title: Text("Ajustes"),
      ),
      body: Column(
        children: [
          Container(
            margin: EdgeInsets.only(top: 16),
            child: ListTile(
              leading:
                  SpacePicture(width: 64, pictureKey: spaceView.pictureKey),
              title: Text(
                spaceView.name,
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
          ),
          SizedBox(height: 8),
          Divider(thickness: 1),
          SettingItem(
              title: "Votos",
              subtitle:
                  "Porcentaje de participación y aprovación de las propuestas",
              icon: Icons.how_to_vote,
              onTap: () {}),
          SettingItem(
              title: "Miembros",
              subtitle: "Usuarios, invitaciones y roles",
              icon: Icons.people,
              onTap: () {}),
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

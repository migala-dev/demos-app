import 'package:flutter/material.dart';
import 'package:demos_app/modules/spaces/pages/new_space/screens/member_profile/widgets/areas_list.widget.dart';
import 'package:demos_app/modules/spaces/pages/new_space/screens/member_profile/widgets/member_profile_field.dart';
import 'package:demos_app/modules/spaces/pages/new_space/screens/member_profile/widgets/votes_text.widget.dart';
import 'package:demos_app/widgets/profile/profile_field.widget.dart';
import 'package:demos_app/widgets/profile/profile_picture.widget.dart';

class MemberProfileScreen extends StatelessWidget {
  const MemberProfileScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Perfil'),
        actions: [
          PopupMenuButton(
            itemBuilder: (context) => [
              PopupMenuItem(
                child: Text("Cancelar Invitación"),
                value: 0,
              ),
              PopupMenuItem(
                child: Text("Eliminar Miembro"),
                value: 1,
              ),
            ],
          )
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 15),
        child: Column(
          children: [
            ProfilePicture(),
            Expanded(
              child: ListView(physics: BouncingScrollPhysics(), children: [
                ProfileField(title: 'Nombre', icon: Icons.person),
                ProfileField(title: 'Telefono', icon: Icons.phone),
                ProfileField(title: 'Rol', icon: Icons.manage_accounts),
                MemberProfileField(
                    title: 'Áreas', icon: Icons.grid_view, child: AreasList()),
                MemberProfileField(
                    title: 'Propuestas',
                    icon: Icons.info_outline,
                    child: VotesText()),
                MemberProfileField(
                    title: 'Sugerencias',
                    icon: Icons.info_outline,
                    child: VotesText()),
                ProfileField(
                    title: 'Miembro desde', icon: Icons.calendar_today),
              ]),
            ),
          ],
        ),
      ),
    );
  }
}

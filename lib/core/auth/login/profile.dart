import 'package:flutter/material.dart';

import 'package:demos_app/widgets/buttons/bigbutton_widget.dart';

class Profile extends StatelessWidget {
  const Profile({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 15),
        child: SafeArea(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Perfil',
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 35,
                ),
                textAlign: TextAlign.start,
              ),
              SizedBox(
                height: 25,
              ),
              Center(child: EditProfilePicture()),
              SizedBox(
                height: 25,
              ),
              ProfileInfoAndEditName(),
              Spacer(),
              BigButton(text: 'CONTINUAR', onPressed: () {})
            ],
          ),
        ),
      ),
    );
  }
}

class EditProfilePicture extends StatelessWidget {
  const EditProfilePicture({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          height: 170,
          width: 170,
          decoration:
              BoxDecoration(color: Colors.grey[350], shape: BoxShape.circle),
        ),
        Positioned(
            bottom: 0,
            right: 0,
            child: FloatingActionButton(
              elevation: 0,
              mini: true,
              child: Icon(Icons.photo_camera),
              onPressed: () {},
            ))
      ],
    );
  }
}

class ProfileInfoAndEditName extends StatelessWidget {
  const ProfileInfoAndEditName({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final accentColor = Theme.of(context).accentColor;

    return Column(
      children: [
        ListTile(
          leading: Icon(Icons.person),
          trailing: IconButton(
            icon: Icon(
              Icons.edit,
              color: accentColor,
            ),
            onPressed: () {},
          ),
          title: Text(
            'Nombre',
            style: TextStyle(color: Colors.grey, fontSize: 14),
          ),
          subtitle:
              Text('Kyle', style: TextStyle(color: Colors.black, fontSize: 18)),
        ),
        ListTile(
          leading: Icon(Icons.phone),
          title: Text(
            'Teléfono',
            style: TextStyle(color: Colors.grey, fontSize: 14),
          ),
          subtitle: Text('+52 666 6666 666',
              style: TextStyle(color: Colors.black, fontSize: 18)),
        )
      ],
    );
  }
}

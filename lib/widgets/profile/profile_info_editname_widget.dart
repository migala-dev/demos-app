import 'package:flutter/material.dart';

class ProfileInfoAndEditName extends StatelessWidget {
  final VoidCallback onEditNamePress;

  const ProfileInfoAndEditName({Key? key, required this.onEditNamePress})
      : super(key: key);

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
            onPressed: onEditNamePress,
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

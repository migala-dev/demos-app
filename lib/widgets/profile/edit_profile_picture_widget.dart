import 'package:flutter/material.dart';

class EditProfilePicture extends StatelessWidget {
  final VoidCallback onPictureEditPress;

  const EditProfilePicture({Key? key, required this.onPictureEditPress})
      : super(key: key);

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
              onPressed: onPictureEditPress,
            ))
      ],
    );
  }
}

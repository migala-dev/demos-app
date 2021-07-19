import 'package:flutter/material.dart';

class ProfilePicture extends StatelessWidget {
  final VoidCallback? onPictureEditPress;
  final bool editable;

  const ProfilePicture({
    Key? key,
    this.editable = false,
    this.onPictureEditPress,
  }) : super(key: key);

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
            child: this.editable
                ? FloatingActionButton(
                    elevation: 0,
                    mini: true,
                    child: Icon(Icons.photo_camera),
                    onPressed: onPictureEditPress,
                  )
                : Container())
      ],
    );
  }
}

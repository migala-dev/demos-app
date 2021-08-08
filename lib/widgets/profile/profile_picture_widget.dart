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
    Size size = MediaQuery.of(context).size;
    return Stack(
      children: [
        getDefaultImage(size),
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

  Widget getDefaultImage(Size size) {
    double width = size.width * 0.4;
    return Image(
        image: AssetImage('assets/images/default-profile.png'),
        width: width,
        height: width,
        fit: BoxFit.cover);
  }
}

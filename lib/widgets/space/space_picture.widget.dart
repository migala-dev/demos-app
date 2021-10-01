import 'dart:io';

import 'package:demos_app/widgets/general/bucket_image.image.dart';
import 'package:flutter/material.dart';

class SpacePicture extends StatelessWidget {
  final VoidCallback? onPictureEditPress;
  final String? pictureKey;
  final File? imageFile;
  final double? width;

  const SpacePicture(
      {Key? key,
      this.onPictureEditPress,
      this.pictureKey,
      this.imageFile,
      this.width})
      : super(key: key);

  bool get editable => onPictureEditPress != null;

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Stack(
      children: [
        getImage(size),
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

  Widget getImage(size) {
    double imageWidth = width ?? size.width * 0.4;
    if (imageFile != null) {
      return getFileImage(imageWidth);
    }
    if (pictureKey != null) {
      return getSpaceImage(imageWidth);
    }
    return getDefaultImage(imageWidth);
  }

  Widget getFileImage(double width) {
    return Container(
      width: width,
      height: width,
      child: ClipRRect(
          borderRadius: BorderRadius.circular(10.0),
          child: FittedBox(
            child: Image.file(
              imageFile!,
            ),
            fit: BoxFit.fill,
          )),
    );
  }

  Widget getDefaultImage(double width) {
    return Image(
        image: AssetImage('assets/images/default-profile.png'),
        width: width,
        height: width,
        fit: BoxFit.cover);
  }

  Widget getSpaceImage(double width) {
    return BucketImage(imageKey: pictureKey, width: width, boderRadius: 10.0);
  }
}
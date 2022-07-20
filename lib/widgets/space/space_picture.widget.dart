/*
  DEMOS
  Copyright (C) 2022 Julian Alejandro Ortega Zepeda, Erik Ivanov Domínguez Rivera, Luis Ángel Meza Acosta
  This file is part of DEMOS.

  DEMOS is free software: you can redistribute it and/or modify
  it under the terms of the GNU General Public License as published by
  the Free Software Foundation, either version 3 of the License, or
  (at your option) any later version.

  DEMOS is distributed in the hope that it will be useful,
  but WITHOUT ANY WARRANTY; without even the implied warranty of
  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
  GNU General Public License for more details.

  You should have received a copy of the GNU General Public License
  along with this program.  If not, see <https://www.gnu.org/licenses/>.
*/

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
            child: editable
                ? FloatingActionButton(
                    elevation: 0,
                    mini: true,
                    child: const Icon(Icons.photo_camera),
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
    return SizedBox(
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
        image: const AssetImage('assets/images/default-space.png'),
        width: width,
        height: width,
        fit: BoxFit.cover);
  }

  Widget getSpaceImage(double width) {
    return BucketImage(imageKey: pictureKey, width: width, boderRadius: 10.0);
  }
}

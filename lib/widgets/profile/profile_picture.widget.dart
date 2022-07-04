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

import 'package:demos_app/config/themes/main_theme.dart';
import 'package:demos_app/widgets/general/bucket_image.image.dart';
import 'package:demos_app/widgets/wrappers/safe_widget/safe_widget_validator.dart';
import 'package:flutter/material.dart';

class ProfilePicture extends StatelessWidget {
  final VoidCallback? onPictureEditPress;
  final String? imageKey;
  final double? width;
  final double? percentage;

  const ProfilePicture(
      {Key? key,
      this.onPictureEditPress,
      this.imageKey,
      this.width,
      this.percentage = 0.4})
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
                ? SafeWidgetValidator(
                    child: FloatingActionButton(
                    elevation: 0,
                    mini: true,
                    child: const Icon(Icons.photo_camera, color: Colors.black,),
                    onPressed: onPictureEditPress,
                    backgroundColor: secondaryColor,
                  ))
                : Container())
      ],
    );
  }

  Widget getImage(size) {
    double imageWidth = (width ?? size.width) * percentage;
    return imageKey == null || imageKey == ''
        ? getDefaultImage(imageWidth)
        : getProfileImage(imageWidth);
  }

  Widget getDefaultImage(double width) {
    return Image(
        image: const AssetImage('assets/images/default-profile.png'),
        width: width,
        height: width,
        fit: BoxFit.cover);
  }

  Widget getProfileImage(double width) {
    return BucketImage(
        imageKey: imageKey, width: width, boderRadius: width / 2);
  }
}

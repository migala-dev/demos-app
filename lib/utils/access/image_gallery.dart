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

import 'dart:async';
import 'package:image_picker/image_picker.dart';
import 'package:permission_handler/permission_handler.dart';

Future<bool> checkGalleryPermission() async {
  PermissionStatus status = await Permission.photos.status;
  if(status.isPermanentlyDenied) {
    openAppSettings();
  }
  return false;
}

Future<bool> askGalleryPermission() async {
  PermissionStatus status = await Permission.photos.request();
  return isPermissionAllowed(status);
}

bool isPermissionAllowed(PermissionStatus status) {
  return status.isGranted || status.isLimited || status.isRestricted;
}

Future<XFile?> pickImage() async {
  XFile? file = await ImagePicker().pickImage(
    source: ImageSource.gallery,
  );
  return file;
}
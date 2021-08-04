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
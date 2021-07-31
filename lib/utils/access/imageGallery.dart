import 'package:dio/dio.dart';
import 'package:image_picker/image_picker.dart';
import 'package:permission_handler/permission_handler.dart';

Future<bool> profilePictureUploader() async {
  if(!await galleryPermissions()) return false;
  XFile? file = await imagePicker();
  return file != null ? await postImage(file) : false;
}

Future<bool> galleryPermissions() async {
  var status = await Permission.photos.status;
  if(status.isGranted || status.isLimited || status.isRestricted) return true;
  if(status.isDenied) {
    var request = await Permission.photos.request();
    if (request.isGranted || request.isLimited || request.isRestricted) {
      return true;
    }
  }
  if(status.isPermanentlyDenied) {
    openAppSettings();
    return false;
  }
  return false;
}

Future<XFile?> imagePicker() async {
  XFile? file = await ImagePicker().pickImage(
    source: ImageSource.gallery,
  );
  return file;
}

Future<bool> postImage(XFile image) async {
  String fileName = image.path.split('/').last;
  FormData formData = FormData.fromMap({
    "file":
    await MultipartFile.fromFile(image.path, filename:fileName),
  });
  var response = await Dio().post("http://localhost:5000/images", data: formData);
  // Todo: Add endpoint and file manipulation to AWS
  return response.statusCode == 200 ? true : false;

}
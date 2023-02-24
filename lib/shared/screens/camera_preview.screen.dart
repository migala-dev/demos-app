import 'dart:io';

import 'package:camera/camera.dart';
import 'package:demos_app/widgets/pages/image_editor.page.dart';
import 'package:flutter/material.dart';

class CameraPreviewScreen extends StatefulWidget {
  final List<CameraDescription> cameras;
  const CameraPreviewScreen({Key? key, required this.cameras})
      : super(key: key);

  @override
  _CameraPreviewScreenState createState() => _CameraPreviewScreenState();
}

class _CameraPreviewScreenState extends State<CameraPreviewScreen> {
  late CameraController cameraController;

  @override
  void initState() {
    initCamera(widget.cameras[1]);
    super.initState();
  }

  @override
  void dispose() {
    cameraController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: takePicture,
        child: const Icon(Icons.camera),
      ),
      body: SafeArea(
        child: cameraController.value.isInitialized
            ? CameraPreview(cameraController)
            : const CircularProgressIndicator(),
      ),
    );
  }

  Future initCamera(CameraDescription cameraDescription) async {
    cameraController =
        CameraController(cameraDescription, ResolutionPreset.high);

    try {
      await cameraController.initialize().then((_) {
        if (!mounted) return;
        setState(() {});
      });
    } on CameraException catch (e) {
      debugPrint('Camera error: $e');
    }
  }

  Future takePicture() async {
    if (!cameraController.value.isInitialized) return null;
    if (cameraController.value.isTakingPicture) return null;

    try {
      await cameraController.setFlashMode(FlashMode.off);
      XFile picture = await cameraController.takePicture();
      File image = File(picture.path);

      final photo = await Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => ImageEditorPage(
            photo: image,
          ),
        ),
      );

      Navigator.pop(context, photo);
    } on CameraException catch (e) {
      debugPrint('$e');
      return null;
    }
  }
}

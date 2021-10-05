import 'dart:io';
import 'dart:async';

import 'package:demos_app/utils/access/image_gallery.dart';
import 'package:flutter/material.dart';
import 'package:image_crop/image_crop.dart';

class ImageEditorPage extends StatefulWidget {
  @override
  _ImageEditorPageState createState() => _ImageEditorPageState();
}

class _ImageEditorPageState extends State<ImageEditorPage> {
  final cropKey = GlobalKey<CropState>();
  File? _file;
  File? _sample;

  @override
  void dispose() {
    super.dispose();
    _file?.delete();
    _sample?.delete();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: SafeArea(
        child: Container(
          color: Colors.black,
          padding: const EdgeInsets.symmetric(vertical: 40.0, horizontal: 20.0),
          child: _sample == null ? _buildOpeningImage() : _buildCroppingImage(),
        ),
      ),
    );
  }

  Widget _buildOpeningImage() {
    _openImage();
    return Center();
  }

  Widget _buildCroppingImage() {
    return Column(
      children: <Widget>[
        Expanded(
          child: Crop.file(
            _sample!,
            key: cropKey,
            alwaysShowGrid: true,
          ),
        ),
        Container(
          padding: const EdgeInsets.only(top: 20.0),
          alignment: AlignmentDirectional.center,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: <Widget>[
              _buildSaveOption(),
              _buildCancelOption(),
            ],
          ),
        )
      ],
    );
  }

  Widget _buildCancelOption() {
    return GestureDetector(
      child: Icon(
        Icons.close,
        color: Colors.white,
      ),
      onTap: () => _goBack(),
    );
  }

  Widget _buildSaveOption() {
    return GestureDetector(
      child: Icon(
        Icons.done,
        color: Colors.white,
      ),
      onTap: () => _cropImage(),
    );
  }

  void _goBack() {
    Navigator.pop(context);
  }

  Future<void> _openImage() async {
    final pickedFile = await pickImage();
    if (pickedFile != null) {
      final file = File(pickedFile.path);
      final sample = await ImageCrop.sampleImage(
        file: file,
        preferredSize: context.size!.longestSide.ceil(),
      );

      _sample?.delete();
      _file?.delete();

      setState(() {
        _sample = sample;
        _file = file;
      });
    } else if (_sample == null) {
      Navigator.pop(context);
    }
  }

  Future<void> _cropImage() async {
    final scale = cropKey.currentState!.scale;
    final area = cropKey.currentState!.area;
    if (area == null) {
      // cannot crop, widget is not setup
      return;
    }

    // scale up to use maximum possible number of pixels
    // this will sample image in higher resolution to make cropped image larger
    final sample = await ImageCrop.sampleImage(
      file: _file!,
      preferredSize: (2000 / scale).round(),
    );

    final file = await ImageCrop.cropImage(
      file: sample,
      area: area,
    );

    sample.delete();

    Navigator.pop(context, file);
  }
}

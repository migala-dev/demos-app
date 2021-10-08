import 'dart:io';
import 'package:demos_app/widgets/buttons/big_button_widget.dart';
import 'package:demos_app/widgets/pages/image_editor.page.dart';
import 'package:demos_app/widgets/space/space_picture.widget.dart';
import 'package:flutter/material.dart';

class SpaceFormScreen extends StatefulWidget {
  final void Function(String, String, File?) goToNextStep;

  const SpaceFormScreen({Key? key, required this.goToNextStep})
      : super(key: key);

  @override
  _SpaceFormScreenState createState() => _SpaceFormScreenState();
}

class _SpaceFormScreenState extends State<SpaceFormScreen> {
  final int maxLines = 4;
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _nameController = new TextEditingController();
  final TextEditingController _descriptionController =
      new TextEditingController();
  File? spacePictureFile;
  int _descriptionLength = 0;

  @override
  Widget build(BuildContext context) {
    return Column(children: [
      SpacePicture(
        onPictureEditPress: onPictureEditPress,
        imageFile: spacePictureFile,
      ),
      SizedBox(
        height: 25,
      ),
      Expanded(child: getForm(context))
    ]);
  }

  void onPictureEditPress() async {
    File? imageFile = await Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => ImageEditorPage(),
        ));
    if (imageFile != null) {
      setState(() {
        spacePictureFile = imageFile;
      });
    }
  }

  Widget getForm(BuildContext context) {
    return Form(
        key: _formKey,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            TextFormField(
              decoration: InputDecoration(labelText: 'Nombre del espacio'),
              controller: _nameController,
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'El Nombre del espacio es requerido';
                }
                return null;
              },
            ),
            SizedBox(
              height: 15,
            ),
            TextFormField(
              maxLines: maxLines,
              controller: _descriptionController,
              decoration: InputDecoration(
                  counterStyle: _descriptionLength > 120
                      ? TextStyle(color: Colors.red[600])
                      : null,
                  labelText: 'Descripción',
                  counterText: '$_descriptionLength/120'),
              onChanged: (desciptionValue) {
                setState(() {
                  _descriptionLength = desciptionValue.length;
                });
              },
              validator: isDescriptionValid,
            ),
            Spacer(),
            BigButton(text: 'CONTINUAR', onPressed: continueToNextStep)
          ],
        ));
  }

  String? isDescriptionValid(String? description) {
    if (description == null || _descriptionLength > 120) {
      return '';
    }
    return null;
  }

  void continueToNextStep() {
    if (_formKey.currentState!.validate()) {
      String name = _nameController.text;
      String description = _descriptionController.text;

      widget.goToNextStep(name, description, spacePictureFile);
    }
  }
}

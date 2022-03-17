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
import 'package:demos_app/widgets/buttons/big_button_widget.dart';
import 'package:demos_app/widgets/pages/image_editor.page.dart';
import 'package:demos_app/widgets/space/space_picture.widget.dart';
import 'package:demos_app/widgets/wrappers/safe_widget/safe_widget_validator.dart';
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
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();
  File? spacePictureFile;
  int _descriptionLength = 0;

  @override
  Widget build(BuildContext context) {
    return Column(children: [
      SpacePicture(
        onPictureEditPress: onPictureEditPress,
        imageFile: spacePictureFile,
      ),
      const SizedBox(
        height: 25,
      ),
      Expanded(child: getForm(context))
    ]);
  }

  void onPictureEditPress() async {
    File? imageFile = await Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => const ImageEditorPage(),
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
              decoration:
                  const InputDecoration(labelText: 'Nombre del espacio'),
              controller: _nameController,
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'El Nombre del espacio es requerido';
                }
                return null;
              },
            ),
            const SizedBox(
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
            const Spacer(),
            SafeWidgetValidator(
                child:
                    BigButton(text: 'CONTINUAR', onPressed: continueToNextStep))
          ],
        ));
  }

  String? isDescriptionValid(String? description) {
    if (_descriptionLength > 120) {
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

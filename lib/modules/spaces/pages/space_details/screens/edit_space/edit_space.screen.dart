import 'dart:io';

import 'package:demos_app/core/models/space.model.dart';
import 'package:demos_app/modules/spaces/pages/new_space/services/new_space.service.dart';
import 'package:demos_app/modules/spaces/pages/space_details/screens/edit_space/widgets/edit_items.dart';
import 'package:demos_app/modules/spaces/pages/space_details/services/space_details.service.dart';
import 'package:demos_app/modules/spaces/pages/spaces/services/current_space.service.dart';
import 'package:demos_app/modules/spaces/validators/is_current_user_admin.widget_validator.dart';
import 'package:demos_app/widgets/pages/image_editor.page.dart';
import 'package:demos_app/widgets/space/space_picture.widget.dart';
import 'package:demos_app/widgets/wrappers/safe_widget/safe_widget_validator.dart';
import 'package:flutter/material.dart';
import 'package:prompt_dialog/prompt_dialog.dart';

class EditSpaceScreen extends StatefulWidget {
  EditSpaceScreen({Key? key}) : super(key: key);

  @override
  _EditSpaceScreenState createState() => _EditSpaceScreenState();
}

class _EditSpaceScreenState extends State<EditSpaceScreen> {
  Space? space = CurrentSpaceService().getCurrentSpace();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        title: Text("Espacio"),
      ),
      body: Column(
        children: [
          Container(
            margin: EdgeInsets.symmetric(vertical: 24),
            child: Stack(
              children: [
                SpacePicture(
                  width: 164,
                  pictureKey: space!.pictureKey,
                ),
                SafeWidgetValidator(
                  validators: [IsCurrentUserAdminWidgetValidator()],
                  child: Positioned(
                      right: 0,
                      bottom: 0,
                      child: FloatingActionButton(
                        onPressed: () {
                          onPictureEditPress();
                        },
                        mini: true,
                        child: Icon(Icons.photo_camera),
                      )),
                )
              ],
            ),
          ),
          EditItems(
            title: "Nombre",
            subtitle: space!.name ?? '',
            icon: Icons.business,
            trailing: updateSpaceName,
          ),
          EditItems(
            title: "Descripción",
            subtitle: space!.description ?? '',
            icon: Icons.info_outline,
            trailing: updateSpaceDescription,
          )
        ],
      ),
    );
  }

  void onPictureEditPress() async {
    File? imageFile = await Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => ImageEditorPage(),
        ));
    if (imageFile != null) {
      Space? spaceUpdated =
          await NewSpaceService().uploadPicture(space!.spaceId!, imageFile);
      setState(
        () {
          space = spaceUpdated;
        },
      );
    }
  }

  void updateSpaceName() async {
    String? newSpaceName = await updateSpaceNamePrompt(context);
    if (newSpaceName != null &&
        newSpaceName.isNotEmpty &&
        newSpaceName != space!.name) {
      setState(() {
        space!.name = newSpaceName;
        SpaceDetailsService().updateSpace(space!);
      });
    }
  }

  void updateSpaceDescription() async {
    String? newSpaceDescription = await updateSpaceDescriptionPrompt(context);
    if (newSpaceDescription != null &&
        newSpaceDescription.isNotEmpty &&
        newSpaceDescription != space!.description) {
      setState(() {
        space!.description = newSpaceDescription;
        SpaceDetailsService().updateSpace(space!);
      });
    }
  }

  Future<String?> updateSpaceNamePrompt(
    BuildContext context,
  ) async {
    return await prompt(
      context,
      title: Text('Nombre del espacio'),
      initialValue: space!.name,
      textOK: Text('Guardar'),
      textCancel: Text(
        'Cancelar',
        style: TextStyle(color: Colors.grey),
      ),
      hintText: 'Introduce un nuevo nombre',
      maxLines: 1,
      autoFocus: true,
      barrierDismissible: true,
    );
  }

  Future<String?> updateSpaceDescriptionPrompt(BuildContext context) async {
    return await prompt(
      context,
      title: Text('Descripción del espacio'),
      initialValue: space!.description,
      textOK: Text('Guardar'),
      textCancel: Text(
        'Cancelar',
        style: TextStyle(color: Colors.grey),
      ),
      hintText: 'Introduce una nueva descripción',
      validator: (String? value) {
        if (value != null && value.length > 120) {
          return "La descripción no puede tener más de 120 caracteres";
        }
      },
      maxLines: 4,
      autoFocus: true,
      barrierDismissible: true,
    );
  }
}

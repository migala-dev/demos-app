import 'dart:io';

import 'package:demos_app/core/models/space.model.dart';
import 'package:demos_app/modules/spaces/pages/new_space/services/new_space.service.dart';
import 'package:demos_app/modules/spaces/pages/space_details/screens/edit_space/widgets/space_field.widget.dart';
import 'package:demos_app/modules/spaces/pages/space_details/services/space_details.service.dart';
import 'package:demos_app/modules/spaces/pages/space_details/bloc/space.bloc.dart';
import 'package:demos_app/modules/spaces/validators/is_current_user_admin.widget_validator.dart';
import 'package:demos_app/utils/ui/modals/open_update_string_field_modal.dart';
import 'package:demos_app/widgets/pages/image_editor.page.dart';
import 'package:demos_app/widgets/space/space_picture.widget.dart';
import 'package:demos_app/widgets/wrappers/safe_widget/safe_widget_validator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class EditSpaceScreen extends StatefulWidget {
  const EditSpaceScreen({Key? key}) : super(key: key);

  @override
  _EditSpaceScreenState createState() => _EditSpaceScreenState();
}

class _EditSpaceScreenState extends State<EditSpaceScreen> {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SpaceBloc, Space?>(
      bloc: SpaceBloc(),
      builder: (context, space) {
        return Scaffold(
          resizeToAvoidBottomInset: false,
          appBar: AppBar(
            title: const Text('Espacio'),
          ),
          body: Column(
            children: [
              Container(
                margin: const EdgeInsets.symmetric(vertical: 24),
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
                            onPictureEditPress(space);
                          },
                          mini: true,
                          child: const Icon(Icons.photo_camera),
                        ),
                      ),
                    )
                  ],
                ),
              ),
              SpaceField(
                title: 'Nombre',
                subtitle: space.name ?? '',
                icon: Icons.business,
                onEdit: () => updateSpaceName(space),
              ),
              SpaceField(
                title: 'Descripción',
                subtitle: space.description ?? '',
                icon: Icons.info_outline,
                onEdit: () => updateSpaceDescription(space),
              )
            ],
          ),
        );
      },
    );
  }

  void onPictureEditPress(Space? space) async {
    File? imageFile = await Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => const ImageEditorPage(),
        ));
    if (imageFile != null) {
      NewSpaceService().uploadPicture(space!.spaceId!, imageFile);
    }
  }

  void updateSpaceName(Space? space) async {
    String? newSpaceName = await openUpdateStringFieldModal(
      context,
      title: 'Nombre del espacio',
      hintText: 'Introduce un nuevo nombre',
      initialValue: space!.name,
    );
    if (newSpaceName != null &&
        newSpaceName.isNotEmpty &&
        newSpaceName != space.name) {
      setState(() {
        space.name = newSpaceName;
        SpaceDetailsService().updateSpace(space);
      });
    }
  }

  void updateSpaceDescription(Space? space) async {
    String? newSpaceDescription = await openUpdateStringFieldModal(
      context,
      title: 'Descripción del espacio',
      hintText: 'Introduce una nueva descripción',
      initialValue: space!.description,
      validator: (String? value) {
        if (value != null && value.length > 120) {
          return 'La descripción no puede tener más de 120 caracteres';
        }
      },
    );
    if (newSpaceDescription != null &&
        newSpaceDescription.isNotEmpty &&
        newSpaceDescription != space.description) {
      setState(() {
        space.description = newSpaceDescription;
        SpaceDetailsService().updateSpace(space);
      });
    }
  }
}

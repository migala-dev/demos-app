import 'dart:io';
import 'package:demos_app/config/routes/routes.dart';
import 'package:demos_app/core/models/space.model.dart';
import 'package:demos_app/modules/spaces/pages/new_space/screens/space_form.screen.dart';
import 'package:demos_app/modules/spaces/pages/new_space/screens/space_percentages_form/space_percentages_form.screen.dart';
import 'package:demos_app/modules/spaces/pages/new_space/services/new_space.service.dart';
import 'package:demos_app/utils/mixins/loading_state_handler.mixin.dart';
import 'package:demos_app/utils/ui/reload_spaces.util.dart';
import 'package:flutter/material.dart';

enum NewSpaceScreenEnum { SpaceInfo, Percentages }

class NewSpaceScreen extends StatefulWidget {
  const NewSpaceScreen({Key? key}) : super(key: key);

  @override
  _NewSpaceScreenState createState() => _NewSpaceScreenState();
}

class _NewSpaceScreenState extends State<NewSpaceScreen>
    with LoadingStateHandler {
  Space newSpace = new Space();
  File? spacePictureFile;
  NewSpaceScreenEnum currentStep = NewSpaceScreenEnum.SpaceInfo;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: _appBarTitle(),
        ),
        body: LayoutBuilder(
            builder: (context, constraints) => SingleChildScrollView(
                  child: ConstrainedBox(
                    constraints:
                        BoxConstraints(minHeight: constraints.maxHeight),
                    child: IntrinsicHeight(
                      child: Container(
                        margin: EdgeInsets.symmetric(
                            horizontal: 20.0, vertical: 12.0),
                        child: getCurrentScreen(),
                      ),
                    ),
                  ),
                )));
  }

  Widget getCurrentScreen() {
    return currentStep == NewSpaceScreenEnum.SpaceInfo
        ? SpaceFormScreen(
            goToNextStep: goToNextStep,
          )
        : SpacePercentagesFormScreen(
            createNewSpace: createNewSpace, isLoading: isLoading);
  }

  void goToNextStep(String name, String description, File? image) {
    setState(() {
      newSpace.name = name;
      newSpace.description = description;
      spacePictureFile = image;
      currentStep = NewSpaceScreenEnum.Percentages;
    });
  }

  void createNewSpace(
      int approvalPercentage, int participationPercentage) async {
    wrapLoadingTransaction(() async {
      newSpace.approvalPercentage = approvalPercentage;
      newSpace.participationPercentage = participationPercentage;
      Space? space = await NewSpaceService().createSpace(newSpace);
      if (spacePictureFile != null && space != null) {
        await NewSpaceService()
            .uploadPicture(space.spaceId!, spacePictureFile!);
      }
      reloadSpaceList();
      Navigator.pushNamedAndRemoveUntil(context, Routes.root, (r) => false);
      Navigator.pushNamed(context, Routes.spacesDetails, arguments: space?.toSpapceView());
      Navigator.pushNamed(context, Routes.invitations);
    });
  }

  Column _appBarTitle() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('Nuevo Espacio'),
        Text(
          'Paso ${currentStep.index + 1} de 2',
          style: TextStyle(color: Colors.grey, fontSize: 14),
        )
      ],
    );
  }
}

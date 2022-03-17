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
import 'package:flutter/material.dart';
import 'package:demos_app/modules/spaces/pages/new_space/screens/space_form.screen.dart';
import 'package:demos_app/modules/spaces/pages/new_space/screens/space_percentages_form/space_percentages_form.screen.dart';
import 'package:demos_app/modules/spaces/pages/new_space/services/new_space.service.dart';
import 'package:demos_app/core/models/space.model.dart';
import 'package:demos_app/config/routes/routes.dart';
import 'package:demos_app/utils/navigation/go_to_space_details.dart';
import 'package:demos_app/utils/mixins/loading_state_handler.mixin.dart';
import 'package:demos_app/utils/ui/reload_spaces.util.dart';

enum NewSpaceScreenEnum { spaceInfo, percentages }

class NewSpaceScreen extends StatefulWidget {
  const NewSpaceScreen({Key? key}) : super(key: key);

  @override
  _NewSpaceScreenState createState() => _NewSpaceScreenState();
}

class _NewSpaceScreenState extends State<NewSpaceScreen>
    with LoadingStateHandler {
  Space newSpace = Space();
  File? spacePictureFile;
  NewSpaceScreenEnum currentStep = NewSpaceScreenEnum.spaceInfo;

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
                        margin: const EdgeInsets.symmetric(
                            horizontal: 20.0, vertical: 12.0),
                        child: getCurrentScreen(),
                      ),
                    ),
                  ),
                )));
  }

  Widget getCurrentScreen() {
    return currentStep == NewSpaceScreenEnum.spaceInfo
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
      currentStep = NewSpaceScreenEnum.percentages;
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
      Navigator.pushNamedAndRemoveUntil(context, Routes.spaces, (r) => false);
      await goToSpaceDetailsBySpaceId(context, space!.spaceId!);
      Navigator.pushNamed(context, Routes.invitations);
    });
  }

  Column _appBarTitle() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text('Nuevo Espacio'),
        Text(
          'Paso ${currentStep.index + 1} de 2',
          style: const TextStyle(color: Colors.grey, fontSize: 14),
        )
      ],
    );
  }
}

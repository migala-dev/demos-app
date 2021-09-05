import 'package:demos_app/modules/spaces/screens/space_form.screen.dart';
import 'package:demos_app/modules/spaces/screens/space_percentages_form.screen.dart';
import 'package:flutter/material.dart';

enum NewSpaceScreenEnum { SpaceInfo, Percentages }

class NewSpaceScreen extends StatefulWidget {
  const NewSpaceScreen({Key? key}) : super(key: key);

  @override
  _NewSpaceScreenState createState() => _NewSpaceScreenState();
}

class _NewSpaceScreenState extends State<NewSpaceScreen> {
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
        ? SpaceFormScreen()
        : SpacePercentagesFormScreen();
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

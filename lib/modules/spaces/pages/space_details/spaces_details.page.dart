import 'package:demos_app/config/routes/routes.dart';
import 'package:demos_app/modules/spaces/models/space_view.model.dart';
import 'package:flutter/material.dart';

class SpaceDetails extends StatelessWidget {
  const SpaceDetails({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final SpaceView spaceDetails =
        ModalRoute.of(context)?.settings.arguments as SpaceView;

    MaterialApp(
      routes: {Routes.spacesDetails: (context) => const SpaceDetails()},
    );

    return Container(
      child: Scaffold(
        appBar: AppBar(
          title: Text(spaceDetails.name.toString()),
        ),
      ),
    );
  }
}

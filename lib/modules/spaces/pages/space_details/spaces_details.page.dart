import 'package:demos_app/modules/proposals/pages/proposals/proposals.page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:demos_app/core/models/space.model.dart';
import 'package:demos_app/modules/spaces/pages/space_details/widgets/space_picture_header.widget.dart';
import 'package:demos_app/modules/spaces/pages/space_details/bloc/space.bloc.dart';
import 'package:demos_app/config/routes/routes.dart';

class SpaceDetailsScreen extends StatelessWidget {
  const SpaceDetailsScreen({Key? key}) : super(key: key);

  void goToSpaceSettings(BuildContext context) =>
      Navigator.pushNamed(context, Routes.spaceSettings);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SpaceBloc, Space?>(
        bloc: SpaceBloc(),
        builder: (context, space) {
          if (space == null) {
            return const Center(child: CircularProgressIndicator());
          }
          return Scaffold(
              appBar: AppBar(
                  titleSpacing: 0,
                  title: GestureDetector(
                    child: Row(
                      children: [
                        SpacePictureHeader(pictureKey: space.pictureKey),
                        Text(space.name ?? '')
                      ],
                    ),
                    onTap: () => goToSpaceSettings(context),
                  )),
              body: const ProposalsPage(),
          );
        });
  }
}

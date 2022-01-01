import 'package:demos_app/core/models/space.model.dart';
import 'package:demos_app/modules/spaces/pages/space_details/widgets/space_picture_header.widget.dart';
import 'package:demos_app/modules/spaces/pages/spaces/services/space.bloc.dart';
import 'package:demos_app/modules/spaces/validators/is_current_user_representative.widget.dart';
import 'package:flutter/material.dart';
import 'package:demos_app/modules/spaces/pages/space_details/widgets/no_proposals.widget.dart';
import 'package:demos_app/modules/spaces/validators/is_current_user_admin.widget_validator.dart';
import 'package:demos_app/modules/spaces/pages/space_details/widgets/no_representant_alert.widget.dart';
import 'package:demos_app/widgets/wrappers/safe_widget/safe_widget_validator.dart';
import 'package:demos_app/config/routes/routes.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SpaceDetailsScreen extends StatelessWidget {
  const SpaceDetailsScreen({Key? key}) : super(key: key);

  void goToSpaceSettings(BuildContext context) =>
      Navigator.pushNamed(context, Routes.spaceSettings);

  void goToNewProposal(BuildContext context) =>
      Navigator.pushNamed(context, Routes.newProposal);

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
              floatingActionButton: SafeWidgetValidator(
                  validators: [IsCurrentUserRepresentativeValidator()],
                  child: FloatingActionButton(
                    child: const Icon(Icons.how_to_vote),
                    onPressed: () => goToNewProposal(context),
                  )),
              body: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 15.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Center(child: NoProposals()),
                    const SizedBox(height: 55),
                    SafeWidgetValidator(
                        validators: [IsCurrentUserAdminWidgetValidator()],
                        child: NoRepresentantAlert(space: space))
                  ],
                ),
              ));
        });
  }
}

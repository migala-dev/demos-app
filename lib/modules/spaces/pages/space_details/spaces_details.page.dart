import 'package:flutter/material.dart';
import 'package:demos_app/core/models/member.model.dart';
import 'package:demos_app/modules/spaces/pages/space_details/widgets/no_proposals.widget.dart';
import 'package:demos_app/modules/spaces/validators/is_current_user_admin.widget_validator.dart';
import 'package:demos_app/modules/spaces/pages/space_details/widgets/no_representant_alert.widget.dart';
import 'package:demos_app/modules/spaces/services/member.service.dart';
import 'package:demos_app/modules/spaces/models/space_view.model.dart';
import 'package:demos_app/widgets/wrappers/safe_widget/safe_widget_validator.dart';
import 'package:demos_app/widgets/space/space_picture.widget.dart';
import 'package:demos_app/config/routes/routes.dart';

class SpaceDetailsScreen extends StatelessWidget {
  const SpaceDetailsScreen({Key? key, required this.spaceView})
      : super(key: key);

  final SpaceView spaceView;

  void goToSpaceSettings(BuildContext context) {
    Navigator.pushNamed(context, Routes.spaceSettings);
  }

  Future<bool> areAnyRepresentativesOnCurrentSpace() async {
    final List<Member> representatives =
        await MemberService().getRepresentatives(spaceView.spaceId);

    return representatives.isNotEmpty;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          titleSpacing: 0,
          title: GestureDetector(
            child: Row(
              children: [
                Container(
                  child: SpacePicture(
                    width: 32,
                    pictureKey: spaceView.pictureKey,
                  ),
                  margin: const EdgeInsets.only(right: 12.0),
                ),
                Text(spaceView.name)
              ],
            ),
            onTap: () => goToSpaceSettings(context),
          )),
      body: FutureBuilder(
        future: areAnyRepresentativesOnCurrentSpace(),
        initialData: false,
        builder: (BuildContext context, AsyncSnapshot<bool> snapshot) {
          if (!snapshot.hasData) {
            return const Center(child: CircularProgressIndicator());
          }

          final bool hasNotRepresentative = !snapshot.data!;

          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Center(child: NoProposals()),
                const SizedBox(height: 55),
                if (hasNotRepresentative)
                  SafeWidgetValidator(
                      validators: [IsCurrentUserAdminWidgetValidator()],
                      child: NoRepresentantAlert())
              ],
            ),
          );
        },
      ),
    );
  }
}

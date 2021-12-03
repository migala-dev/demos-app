import 'package:demos_app/modules/spaces/pages/new_space/screens/space_percentages_form/widgets/percentage_sliders.widget.dart';
import 'package:flutter/material.dart';
import 'package:demos_app/core/models/space.model.dart';
import 'package:demos_app/modules/spaces/pages/space_details/services/space_details.service.dart';
import 'package:demos_app/modules/spaces/pages/spaces/services/current_space.service.dart';
import 'package:demos_app/modules/spaces/validators/is_current_user_admin.widget_validator.dart';
import 'package:demos_app/utils/mixins/loading_state_handler.mixin.dart';
import 'package:demos_app/utils/ui/global_colors.util.dart';
import 'package:demos_app/widgets/buttons/big_button_widget.dart';
import 'package:demos_app/widgets/wrappers/safe_widget/safe_widget_validator.dart';

class SpacePercentageSettingsScreen extends StatefulWidget {
  SpacePercentageSettingsScreen({Key? key}) : super(key: key);

  @override
  _SpacePercentageSettingsScreenState createState() =>
      _SpacePercentageSettingsScreenState();
}

class _SpacePercentageSettingsScreenState
    extends State<SpacePercentageSettingsScreen> with LoadingStateHandler {
  int approvalPercentage = 70;
  int participationPercentage = 70;

  @override
  void initState() {
    super.initState();
    Space? space = CurrentSpaceService().getCurrentSpace();
    approvalPercentage = space!.approvalPercentage;
    participationPercentage = space.participationPercentage;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Scaffold(
        appBar: AppBar(
          title: Text("Votos"),
        ),
        body: Container(
          margin: EdgeInsets.symmetric(horizontal: 16.0, vertical: 12.0),
          child: Column(
            children: [
              PercentageSliders(
                initialValue: approvalPercentage,
                onChange: (approvalPercentage) {
                  setState(() {
                    this.approvalPercentage = approvalPercentage;
                  });
                },
                sliderTitle: 'Porcentaje de aprovación',
                sliderSubtitle: 'En votaciones A favor/En contra',
              ),
              Container(
                height: 30.0,
                margin: EdgeInsets.only(bottom: 12.0),
                decoration: BoxDecoration(
                    border: Border(bottom: BorderSide(color: greyColor))),
              ),
              PercentageSliders(
                initialValue: participationPercentage,
                onChange: (participationPercentage) {
                  setState(() {
                    this.participationPercentage = participationPercentage;
                  });
                },
                sliderTitle: "Porcentaje de participación",
                sliderSubtitle: 'En votaciones con opción multiple',
              ),
              Spacer(),
              SafeWidgetValidator(
                validators: [IsCurrentUserAdminWidgetValidator()],
                child: BigButton(
                  text: 'Guardar',
                  onPressed: save,
                  isLoading: isLoading,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void save() {
    wrapLoadingTransaction(() async {
      Space? space = CurrentSpaceService().getCurrentSpace();
      space!.approvalPercentage = approvalPercentage;
      space.participationPercentage = participationPercentage;

      await SpaceDetailsService().updateSpace(space);
      Navigator.pop(context);
    });
  }
}

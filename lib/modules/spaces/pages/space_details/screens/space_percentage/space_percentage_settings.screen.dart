import 'package:demos_app/modules/spaces/pages/new_space/screens/space_percentages_form/widgets/space_percentage.widget.dart';
import 'package:demos_app/utils/ui/modals/open_confirmation_dialog.dart';
import 'package:demos_app/widgets/wrappers/safe_widget/widget_validator.interface.dart';
import 'package:flutter/material.dart';
import 'package:demos_app/core/models/space.model.dart';
import 'package:demos_app/modules/spaces/pages/space_details/services/space_details.service.dart';
import 'package:demos_app/modules/spaces/pages/space_details/bloc/space.bloc.dart';
import 'package:demos_app/modules/spaces/validators/is_current_user_admin.widget_validator.dart';
import 'package:demos_app/utils/mixins/loading_state_handler.mixin.dart';
import 'package:demos_app/utils/ui/global_colors.util.dart';
import 'package:demos_app/widgets/buttons/big_button_widget.dart';
import 'package:demos_app/widgets/wrappers/safe_widget/safe_widget_validator.dart';

class SpacePercentageSettingsScreen extends StatefulWidget {
  const SpacePercentageSettingsScreen({Key? key}) : super(key: key);

  @override
  _SpacePercentageSettingsScreenState createState() =>
      _SpacePercentageSettingsScreenState();
}

class _SpacePercentageSettingsScreenState
    extends State<SpacePercentageSettingsScreen> with LoadingStateHandler {
  int approvalPercentage = 70;
  int participationPercentage = 70;
  List<WidgetValidator>? validators = [IsCurrentUserAdminWidgetValidator()];

  @override
  void initState() {
    super.initState();
    Space? space = SpaceBloc().state;
    approvalPercentage = space!.approvalPercentage;
    participationPercentage = space.participationPercentage;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Votos'),
      ),
      body: Container(
        margin: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 12.0),
        child: Column(
          children: [
            SpacePercentage(
                initialValue: approvalPercentage,
                onChange: (approvalPercentage) {
                  setState(() {
                    this.approvalPercentage = approvalPercentage;
                  });
                },
                title: 'Porcentaje de aprovación',
                subtitle: 'En votaciones A favor/En contra',
                toBeApprovedLabel: ' para aprobar la propuesta.',
                validators: validators),
            Container(
              height: 30.0,
              margin: const EdgeInsets.only(bottom: 12.0),
              decoration: BoxDecoration(
                  border: Border(bottom: BorderSide(color: greyColor))),
            ),
            SpacePercentage(
                initialValue: participationPercentage,
                onChange: (participationPercentage) {
                  setState(() {
                    this.participationPercentage = participationPercentage;
                  });
                },
                title: 'Porcentaje de participación',
                subtitle: 'En votaciones con opción multiple',
                toBeApprovedLabel:
                    ' para aprobar una de las opciones de una propuesta.',
                validators: validators),
            const Spacer(),
            SafeWidgetValidator(
              validators: [IsCurrentUserAdminWidgetValidator()],
              child: BigButton(
                text: 'Guardar',
                onPressed: () => openConfirmationDialog(context,
                    content: '¿Deseas guardar los cambios?', accept: save),
                isLoading: isLoading,
              ),
            ),
          ],
        ),
      ),
    );
  }

  void save() {
    wrapLoadingTransaction(() async {
      Space? space = SpaceBloc().state;
      space!.approvalPercentage = approvalPercentage;
      space.participationPercentage = participationPercentage;

      await SpaceDetailsService().updateSpace(space);
      Navigator.pop(context);
    });
  }
}

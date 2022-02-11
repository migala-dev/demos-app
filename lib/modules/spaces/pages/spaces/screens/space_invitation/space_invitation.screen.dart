import 'package:demos_app/config/routes/routes.dart';
import 'package:demos_app/core/models/errors/invalid_invitation_status.error.dart';
import 'package:demos_app/core/models/errors/invitation_expired.error.dart';
import 'package:demos_app/modules/spaces/models/invitation_view.model.dart';
import 'package:demos_app/modules/spaces/services/member.service.dart';
import 'package:demos_app/shared/models/option.model.dart';
import 'package:demos_app/shared/services/phone_formatter.service.dart';
import 'package:demos_app/utils/mixins/loading_state_handler.mixin.dart';
import 'package:demos_app/utils/navigation/go_to_space_details.dart';
import 'package:demos_app/utils/ui/reload_spaces.util.dart';
import 'package:demos_app/widgets/buttons/big_button_widget.dart';
import 'package:demos_app/widgets/general/select_options.widget.dart';
import 'package:demos_app/widgets/profile/profile_picture.widget.dart';
import 'package:demos_app/widgets/space/space_picture.widget.dart';
import 'package:demos_app/widgets/wrappers/safe_widget/safe_widget_validator.dart';
import 'package:flutter/material.dart';

class SpaceInvitationScreen extends StatefulWidget {
  final InvitationView invitationView;

  const SpaceInvitationScreen({Key? key, required this.invitationView}) : super(key: key);

  @override
  State<SpaceInvitationScreen> createState() => _SpaceInvitationScreenState();
}

class _SpaceInvitationScreenState extends State<SpaceInvitationScreen>
    with LoadingStateHandler {
  Option? optionSelected;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Container(
      padding: const EdgeInsets.only(
          top: 32.0, bottom: 20.0, left: 24.0, right: 24.0),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              IconButton(
                  onPressed: () {
                    goBack(context);
                  },
                  icon: const Icon(Icons.close))
            ],
          ),
          Expanded(
              child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Expanded(
                  flex: 3,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      widget.invitationView.pictureKey != null
                          ? SpacePicture(
                              width: 150,
                              pictureKey: widget.invitationView.pictureKey,
                            )
                          : Container(),
                      SizedBox(
                        width: double.infinity,
                        child: getSpaceNameWidget(),
                      ),
                    ],
                  )),
              Expanded(
                flex: 1,
                child: SizedBox(
                  width: double.infinity,
                  child: Container(
                    padding: const EdgeInsets.only(top: 8),
                    child: getInvitedByWidget(),
                  ),
                ),
              ),
              Expanded(
                flex: 3,
                child: SafeWidgetValidator(
                    child: SelectOptionListWidget(
                  options: getOptions(),
                  onChange: (option) {
                    setState(() {
                      optionSelected = option;
                    });
                  },
                )),
              ),
            ],
          )),
          SafeWidgetValidator(
            child: BigButton(
                text: 'Continuar',
                isLoading: isLoading,
                disabled: optionSelected == null,
                onPressed: () {
                  if (optionSelected != null) {
                    optionSelected!.accept();
                  }
                }),
          )
        ],
      ),
    ));
  }

  Widget getSpaceNameWidget() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text('Espacio'),
        Text(
          widget.invitationView.name,
          style: const TextStyle(fontSize: 40),
        )
      ],
    );
  }

  Widget getInvitedByWidget() {
    String userName = widget.invitationView.invitedBy.name.isEmpty
        ? PhoneFormatterService.format(widget.invitationView.invitedBy.phoneNumber)
        : widget.invitationView.invitedBy.name;
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          padding: const EdgeInsets.only(right: 8),
          child: ProfilePicture(
            width: 84,
            imageKey: widget.invitationView.invitedBy.profilePictureKey,
          ),
        ),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'INVITADO POR',
              style: TextStyle(color: Colors.grey),
            ),
            Text(
              userName,
              style: const TextStyle(fontSize: 16),
            )
          ],
        )
      ],
    );
  }

  void goBack(BuildContext context) {
    Navigator.pop(context);
  }

  List<Option> getOptions() {
    return [Option('Aceptar', accept), Option('Rechazar', reject)];
  }

  void accept() {
    wrapLoadingTransaction(() async {
      try {
        await MemberService().acceptInvitation(widget.invitationView.spaceId);

        reloadSpaceList();
        Navigator.pop(context);
        Navigator.pushNamedAndRemoveUntil(context, Routes.spaces, (r) => false,
            arguments: widget.invitationView);
        await goToSpaceDetails(context, widget.invitationView);
      } catch (err) {
        if (err == InvitationExpiredError() || err == InvalidInvitationStatusError()) {
          reloadSpaceList();
          goBack(context);
        } else {
          rethrow;
        }
      }
    });
  }

  void reject() async {
    wrapLoadingTransaction(() async {
      await MemberService().rejectInvitation(widget.invitationView.spaceId);

      reloadSpaceList();

      goBack(context);
    });
  }
}

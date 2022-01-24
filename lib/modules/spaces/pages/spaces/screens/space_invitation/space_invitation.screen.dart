import 'package:demos_app/config/routes/routes.dart';
import 'package:demos_app/core/models/errors/invalid_invitation_status.error.dart';
import 'package:demos_app/core/models/errors/invitation_expired.error.dart';
import 'package:demos_app/core/models/space.model.dart';
import 'package:demos_app/core/models/user.model.dart';
import 'package:demos_app/core/repositories/spaces.repository.dart';
import 'package:demos_app/core/repositories/users.repository.dart';
import 'package:demos_app/modules/spaces/models/space_view.model.dart';
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
  const SpaceInvitationScreen({Key? key}) : super(key: key);

  @override
  State<SpaceInvitationScreen> createState() => _SpaceInvitationScreenState();
}

class _SpaceInvitationScreenState extends State<SpaceInvitationScreen>
    with LoadingStateHandler {
  Option? optionSelected;
  Space? space;
  User? invitedBy;
  SpaceView? spaceView;

  @override
  Widget build(BuildContext context) {
    final SpaceView spaceView =
        ModalRoute.of(context)?.settings.arguments as SpaceView;

    setStateView(spaceView);
    getSpace();
    getInvitedBy();

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
                      space?.pictureKey != null
                          ? SpacePicture(
                              width: 150,
                              pictureKey: space?.pictureKey,
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

  Future<void> getSpace() async {
    if (space == null) {
      Space? space = await SpacesRepository().findById(spaceView!.spaceId);
      setState(() {
        this.space = space;
      });
    }
  }

  Future<void> getInvitedBy() async {
    if (invitedBy == null) {
      User? invitedBy = await UsersRepository().findById(spaceView!.invitedBy!);
      setState(() {
        this.invitedBy = invitedBy;
      });
    }
  }

  void setStateView(SpaceView spaceView) {
    if (this.spaceView == null) {
      setState(() {
        this.spaceView = spaceView;
      });
    }
  }

  Widget getSpaceNameWidget() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text('Espacio'),
        Text(
          space?.name ?? '',
          style: const TextStyle(fontSize: 40),
        )
      ],
    );
  }

  Widget getInvitedByWidget() {
    if (invitedBy == null) {
      return Container();
    }
    String userName = invitedBy!.name.isEmpty
        ? PhoneFormatterService.format(invitedBy!.phoneNumber)
        : invitedBy!.name;
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          padding: const EdgeInsets.only(right: 8),
          child: ProfilePicture(
            width: 84,
            imageKey: invitedBy!.profilePictureKey,
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
        await MemberService().acceptInvitation(spaceView!.spaceId);

        reloadSpaceList();
        Navigator.pop(context);
        Navigator.pushNamedAndRemoveUntil(context, Routes.spaces, (r) => false,
            arguments: spaceView);
        await goToSpaceDetails(context, spaceView!);
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
      await MemberService().rejectInvitation(spaceView!.spaceId);

      reloadSpaceList();

      goBack(context);
    });
  }
}

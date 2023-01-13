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

import 'package:demos_app/config/routes/routes.dart';
import 'package:demos_app/core/models/errors/invalid_invitation_status.error.dart';
import 'package:demos_app/core/models/errors/invitation_expired.error.dart';
import 'package:demos_app/modules/spaces/models/invitation_view.model.dart';
import 'package:demos_app/modules/spaces/services/member.service.dart';
import 'package:demos_app/shared/models/option.model.dart';
import 'package:demos_app/utils/mixins/loading_state_handler.mixin.dart';
import 'package:demos_app/utils/navigation/go_to_space_details.dart';
import 'package:demos_app/utils/ui/reload_spaces.util.dart';
import 'package:demos_app/widgets/buttons/big_button_widget.dart';
import 'package:demos_app/widgets/buttons/right_close_button.widget.dart';
import 'package:demos_app/widgets/general/select_options.widget.dart';
import 'package:demos_app/widgets/profile/profile_picture.widget.dart';
import 'package:demos_app/widgets/space/space_picture.widget.dart';
import 'package:demos_app/widgets/titles/entity_title.widget.dart';
import 'package:demos_app/widgets/wrappers/safe_widget/safe_widget_validator.dart';
import 'package:flutter/material.dart';

class AcceptInvitationScreen extends StatefulWidget {
  final InvitationView invitationView;

  const AcceptInvitationScreen({Key? key, required this.invitationView})
      : super(key: key);

  @override
  State<AcceptInvitationScreen> createState() => _AcceptInvitationScreenState();
}

class _AcceptInvitationScreenState extends State<AcceptInvitationScreen>
    with LoadingStateHandler {
  Option? optionSelected;

  @override
  Widget build(BuildContext context) {
    final Color primaryColor = Theme.of(context).primaryColor;
    return Scaffold(
        backgroundColor: primaryColor,
        body: Container(
          padding: const EdgeInsets.only(top: 32.0, left: 32.0, right: 32.0, bottom: 20.0),
          child: Column(
            children: [
              RightCloseButton(onPressed: () => goBack(context)),
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
    return EntityTitle(
      name: widget.invitationView.name,
      label: 'ESPACIO',
    );
  }

  Widget getInvitedByWidget() {
    String userName = widget.invitationView.invitedBy.name.isEmpty
        ? 'Anónimo'
        : widget.invitationView.invitedBy.name;
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          padding: const EdgeInsets.only(right: 12.0),
          child: ProfilePicture(
            width: 100,
            imageKey: widget.invitationView.invitedBy.profilePictureKey,
          ),
        ),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'INVITADO POR:',
              style: TextStyle(fontSize: 12.0, color: Colors.white),
            ),
            Text(
              userName,
              style: const TextStyle(
                  fontSize: 22,
                  color: Colors.white,
                  fontWeight: FontWeight.w500),
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
        await MemberService().acceptInvitation(widget.invitationView.spaceId!);

        reloadSpaceList();
        Navigator.pop(context);
        Navigator.pushNamedAndRemoveUntil(context, Routes.spaces, (r) => false);
        await Future.delayed(const Duration(milliseconds: 100));
        await goToSpaceDetails(widget.invitationView);
      } catch (err) {
        if (err == InvitationExpiredError() ||
            err == InvalidInvitationStatusError()) {
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
      await MemberService().rejectInvitation(widget.invitationView.spaceId!);

      reloadSpaceList();

      goBack(context);
    });
  }
}

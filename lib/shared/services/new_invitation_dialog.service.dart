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
import 'package:demos_app/core/models/member.model.dart';
import 'package:demos_app/modules/spaces/models/invitation_view.model.dart';
import 'package:demos_app/modules/spaces/models/space_view.model.dart';
import 'package:demos_app/modules/spaces/repositories/invitation_view.repository.dart';
import 'package:demos_app/widgets/space/space_picture.widget.dart';
import 'package:flutter/material.dart';
import '../../navigation.service.dart';

class NewInvitationDialogService {
  static final NewInvitationDialogService _dialogService =
      NewInvitationDialogService._internal();
  NewInvitationDialogService._internal();
  final List<InvitationView> _pendingInvitations = [];
  InvitationView? _currentInvitation;

  factory NewInvitationDialogService() {
    return _dialogService;
  }

  Future<void> open(Member member) async {
    InvitationView? invitation = await InvitationViewsRepository()
        .getInvitationByMemberId(member.memberId!);
    if (invitation != null) {
      _openInvitation(invitation);
    }
  }

  Future<void> _openInvitation(InvitationView invitation) async {
    if (_currentInvitation == null) {
      _currentInvitation = invitation;
      _showDialog(invitation);
    } else {
      _pendingInvitations.add(invitation);
    }
  }

  Future<void> _showDialog(InvitationView invitation) async {
    BuildContext context = NavigationService.navigatorKey.currentContext!;
    Color primaryColor = Theme.of(context).primaryColor;
    Size size = MediaQuery.of(context).size;
    showDialog<void>(
        context: context,
        builder: (BuildContext context) => SimpleDialog(
              title: Row(
                children: [
                  invitation.pictureKey != null
                      ? Container(
                          margin: const EdgeInsets.only(right: 12.0),
                          child: SpacePicture(
                            pictureKey: invitation.pictureKey,
                            width: (size.width * 0.15),
                          ))
                      : Container(),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'Nueva invitacion recibida',
                        style: TextStyle(color: Colors.grey, fontSize: 12.0),
                      ),
                      SizedBox(
                          width: (size.width * 0.45),
                          child: Text(invitation.name))
                    ],
                  )
                ],
              ),
              children: <Widget>[
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 12.0),
                  child: ElevatedButton(
                    onPressed: () => _goToInvitationScreen(context, invitation),
                    child: const Text('Ver invitacion'),
                    style: ButtonStyle(
                        backgroundColor:
                            MaterialStateProperty.all(primaryColor)),
                  ),
                ),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 12.0),
                  child: InkWell(
                    onTap: () {
                      _close(context);
                    },
                    child: Container(
                      padding: const EdgeInsets.all(8.0),
                      child: const Text(
                        'En otro momento',
                        textAlign: TextAlign.center,
                        style: TextStyle(color: Colors.grey),
                      ),
                    ),
                  ),
                )
              ],
            ));
  }

  void _close(BuildContext context) {
    Navigator.pop(context);
    _currentInvitation = null;
    _checkForPendingInvitations();
  }

  Future<void> _goToInvitationScreen(
      BuildContext context, SpaceView invitation) async {
    Navigator.pop(context);

    await Navigator.pushNamed(context, Routes.spaceInvitation,
        arguments: invitation);

    _currentInvitation = null;
    _checkForPendingInvitations();
  }

  Future<void> _checkForPendingInvitations() async {
    if (_pendingInvitations.isNotEmpty) {
      InvitationView invitation = _pendingInvitations[0];
      _openInvitation(invitation);
      _pendingInvitations.removeAt(0);
    }
  }
}

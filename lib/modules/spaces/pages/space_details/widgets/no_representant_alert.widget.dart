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

import 'dart:async';

import 'package:demos_app/config/routes/routes.dart';
import 'package:demos_app/core/models/member.model.dart';
import 'package:demos_app/modules/spaces/models/space_view.model.dart';
import 'package:demos_app/modules/spaces/pages/new_space/screens/members/bloc/space_members_bloc.dart';
import 'package:demos_app/modules/spaces/pages/space_details/bloc/space.bloc.dart';
import 'package:demos_app/modules/spaces/services/member.service.dart';
import 'package:flutter/material.dart';

class NoRepresentantAlert extends StatefulWidget {

  const NoRepresentantAlert({Key? key }) : super(key: key);

  @override
  State<NoRepresentantAlert> createState() => _NoRepresentantAlertState();
}

class _NoRepresentantAlertState extends State<NoRepresentantAlert> {
  bool showAlert = false;
  late final StreamSubscription spaceMembersBlocSubscription;

  final Color fontColor = Colors.grey.shade600;

  final Color backgroundColor = Colors.orange.shade50;

  final String description =
      'Para poder tener propuestas en un espacio es necesario tener un representante, actualiza el rol de un miembro del espacio para que pueda crear una propuesta.';

  @override
  void initState() {
    init();
    spaceMembersBlocSubscription = SpaceMembersBloc().stream.listen((event) {
      if (event is SpaceMembersWithData) {
        setState(() {
          showAlert = !event.hasRepresentative();
        });
      }
    });
    super.initState();
  }

  @override
  void dispose() {
    spaceMembersBlocSubscription.cancel();
    super.dispose();
  }

  Future<void> init() async {
    SpaceView space = SpaceBloc().state; 
    if (space.spaceId != null) {
      final List<Member> representatives =
          await MemberService().getRepresentatives(space.spaceId!);

      if (representatives.isEmpty) {
        setState(() {
          showAlert = true;
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    if (!showAlert) {
      return Container();
    }
    return Container(
      padding: const EdgeInsets.all(15.0),
      decoration: BoxDecoration(
        color: backgroundColor,
        border: Border.all(color: Colors.orange.shade200, width: 1.5),
        borderRadius: const BorderRadius.all(Radius.circular(10.0)),
      ),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Icon(
                Icons.warning,
                size: 55,
                color: fontColor,
              ),
              Column(
                children: [
                  Text('Aun no tienes ningun representante',
                      style: TextStyle(color: fontColor)),
                  ElevatedButton(
                      onPressed: () => goToMembers(context),
                      child: const Text('Agrega el primero'),
                      style: ElevatedButton.styleFrom(
                          primary: Colors.orange.shade300,
                          minimumSize: const Size(245, 25)))
                ],
              )
            ],
          ),
          const SizedBox(height: 10),
          Text(
            description,
            style: TextStyle(color: fontColor),
          )
        ],
      ),
    );
  }

  void goToMembers(BuildContext context) =>
      Navigator.pushNamed(context, Routes.spaceMembers);
}

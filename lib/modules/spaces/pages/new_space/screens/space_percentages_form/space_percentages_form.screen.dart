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

import 'package:demos_app/modules/spaces/pages/new_space/screens/space_percentages_form/widgets/space_percentage.widget.dart';
import 'package:demos_app/utils/ui/global_colors.util.dart';
import 'package:flutter/material.dart';
import 'package:demos_app/widgets/buttons/big_button_widget.dart';

class SpacePercentagesFormScreen extends StatefulWidget {
  final void Function(int, int) createNewSpace;
  final bool isLoading;

  const SpacePercentagesFormScreen(
      {Key? key, required this.createNewSpace, this.isLoading = false})
      : super(key: key);

  @override
  _SpacePercentagesFormScreenState createState() =>
      _SpacePercentagesFormScreenState();
}

class _SpacePercentagesFormScreenState
    extends State<SpacePercentagesFormScreen> {
  int approvalPercentage = 70;
  int participationPercentage = 70;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 12.0),
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
          ),
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
          ),
          const Spacer(),
          Text(
              '* Estos porcentages podrán ser actualizados dentro del espacio.',
              style: TextStyle(color: Colors.grey[600])),
          const SizedBox(height: 16),
          BigButton(
              text: 'Crear',
              isLoading: widget.isLoading,
              onPressed: () {
                widget.createNewSpace(
                    approvalPercentage, participationPercentage);
              })
        ],
      ),
    );
  }
}

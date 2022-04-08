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

import 'package:demos_app/core/enums/manifesto_option_type.enum.dart';
import 'package:demos_app/modules/proposals/pages/proposal_form/bloc/proposal_form.bloc.dart';
import 'package:demos_app/modules/proposals/pages/proposal_form/bloc/proposal_form_bloc.events.dart';
import 'package:demos_app/modules/proposals/pages/proposal_form/models/proposal_form_view.model.dart';
import 'package:demos_app/modules/proposals/pages/proposal_form/forms/option_step/models/dropdown_manifesto_option.model.dart';
import 'package:demos_app/modules/proposals/pages/proposal_form/forms/option_step/widgets/manifesto_option.widget.dart';
import 'package:demos_app/modules/proposals/pages/proposal_form/forms/option_step/widgets/multiple_option.widget.dart';
import 'package:demos_app/modules/proposals/pages/proposal_form/utils/is_valid_number_of_options.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class OptionsForm extends StatefulWidget {
  const OptionsForm({
    Key? key,
  }) : super(key: key);

  @override
  _OptionsFormState createState() => _OptionsFormState();
}

class _OptionsFormState extends State<OptionsForm> {
  List<DropdownManifestoItem> items = [];

  @override
  void initState() {
    super.initState();
    items = [
      DropdownManifestoItem(
        label: 'A favor/En contra',
        optionType: ManifestoOptionType.inFavorOrOpposing,
        getWidget: getInFavorOrOpposingWidget,
      ),
      DropdownManifestoItem(
        label: 'Opción multiple',
        optionType: ManifestoOptionType.multipleOptions,
        getWidget: getMultipleOptionsWidget,
      )
    ];
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ProposalFormBloc, ProposalFormView>(
      bloc: ProposalFormBloc(),
      builder: (context, proposalFormView) {
        DropdownManifestoItem optionTypeSelected = items.firstWhere(
            (element) => element.optionType == proposalFormView.optionType);
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text('Votaciones de: ', style: TextStyle(color: Colors.grey)),
            DropdownButtonHideUnderline(
              child: DropdownButton<DropdownManifestoItem>(
                items: items.map(buildMenuItem).toList(),
                isExpanded: true,
                onChanged: (value) {
                  ProposalFormBloc()
                      .add(ProposalFormOnOptionTypeChange(value!.optionType));
                },
                value: optionTypeSelected,
              ),
            ),
            const SizedBox(height: 24),
            const Text('Opciones', style: TextStyle(color: Colors.grey)),
            optionTypeSelected.getWidget(),
            isValidNumberOfOptions()
                ? Container()
                : Padding(
                    padding: const EdgeInsets.symmetric(vertical: 15),
                    child: Text(
                      '* El número de opciones tiene que estar entre 2 y 20',
                      style: TextStyle(color: Colors.red.shade600),
                    ),
                  ),
          ],
        );
      },
    );
  }

  DropdownMenuItem<DropdownManifestoItem> buildMenuItem(
          DropdownManifestoItem item) =>
      DropdownMenuItem(
        value: item,
        child: Text(item.label),
      );

  Widget getInFavorOrOpposingWidget() {
    return Column(
      children: const [
        ManifestoOptionWidget(title: 'A favor'),
        ManifestoOptionWidget(title: 'En contra'),
      ],
    );
  }

  Widget getMultipleOptionsWidget() {
    return const MultipleOptionWidget();
  }
}

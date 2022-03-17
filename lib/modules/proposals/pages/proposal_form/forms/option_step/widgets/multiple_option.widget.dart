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

import 'package:demos_app/modules/proposals/pages/proposal_form/bloc/proposal_form.bloc.dart';
import 'package:demos_app/modules/proposals/pages/proposal_form/bloc/proposal_form_bloc.events.dart';
import 'package:demos_app/modules/proposals/pages/proposal_form/models/proposal_form_view.model.dart';
import 'package:demos_app/modules/proposals/pages/proposal_form/forms/option_step/models/manifesto_option_view.model.dart';
import 'package:demos_app/modules/proposals/pages/proposal_form/forms/option_step/widgets/add_manifesto_option.widget.dart';
import 'package:demos_app/modules/proposals/pages/proposal_form/forms/option_step/widgets/manifesto_option.widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class MultipleOptionWidget extends StatelessWidget {
  const MultipleOptionWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ProposalFormBloc, ProposalFormView>(
      bloc: ProposalFormBloc(),
      builder: (context, proposalFormView) {
        return Column(
          children: [
            ...proposalFormView.manifestoOptions
                .map(
                  (option) => ManifestoOptionWidget(
                    title: option.title,
                    onEdit: (title) {
                      List<ManifestoOptionView> manifestoOptions =
                          proposalFormView.manifestoOptions.map((o) {
                        if (o == option) {
                          option.title = title;
                          return option;
                        }
                        return o;
                      }).toList();

                      ProposalFormBloc().add(
                          ProposalFormOnManifestoOptionsChange(
                              manifestoOptions));
                    },
                    onRemove: () {
                      List<ManifestoOptionView> manifestoOptions =
                          proposalFormView.manifestoOptions
                              .where((element) => element != option)
                              .toList();

                      ProposalFormBloc().add(
                          ProposalFormOnManifestoOptionsChange(
                              manifestoOptions));
                    },
                  ),
                )
                .toList(),
            AddManifestoOption(
              add: (title) {
                List<ManifestoOptionView> manisfestoOptions = [
                  ...proposalFormView.manifestoOptions,
                  ManifestoOptionView(title: title)
                ];
                ProposalFormBloc().add(
                    ProposalFormOnManifestoOptionsChange(manisfestoOptions));
              },
            ),
          ],
        );
      },
    );
  }
}

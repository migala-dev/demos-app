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
import 'package:demos_app/modules/proposals/pages/proposal_form/bloc/proposal_form.bloc.dart';
import 'package:demos_app/modules/proposals/pages/proposal_form/bloc/proposal_form_bloc.events.dart';
import 'package:demos_app/modules/proposals/pages/proposal_form/enums/proposal_form_type.enum.dart';
import 'package:demos_app/modules/proposals/pages/proposal_form/models/proposal_form_view.model.dart';
import 'package:demos_app/modules/proposals/pages/proposals/models/proposal_view.model.dart';
import 'package:demos_app/modules/proposals/pages/proposals/widgets/proposal_cards/proposal_card.interface.dart';
import 'package:demos_app/modules/proposals/pages/proposals/widgets/proposal_cards/proposal_card_info.widget.dart';
import 'package:flutter/material.dart';

class ProposalDraftCard extends StatelessWidget implements ProposalCard {
  @override
  final ProposalView proposal;

  const ProposalDraftCard({Key? key, required this.proposal}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        ProposalFormView proposalFormView = ProposalFormView(
          type: ProposalFormType.draft,
          proposalId: proposal.proposalId,
          title: proposal.title ?? '',
          content: proposal.content ?? '',
          optionType: proposal.optionType,
          manifestoOptions: proposal.manifestoOptions,
        );
        ProposalFormBloc()
            .add(ProposalFormSetProposalFormView(proposalFormView));
        Navigator.pushNamed(context, Routes.proposalForm);
      },
      child: Material(
        elevation: 2,
        borderRadius: BorderRadius.circular(20),
        child: Container(
          padding: const EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(proposal.title ?? 'Sin titulo',
                  style: const TextStyle(fontSize: 20)),
              const SizedBox(height: 10),
              ProposalCardInfo(
                getIcon: (size, color) => Icon(
                  Icons.calendar_today,
                  size: size,
                  color: color,
                ),
                title: 'CREADO EL:',
                content: proposal.createdAtFormated,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

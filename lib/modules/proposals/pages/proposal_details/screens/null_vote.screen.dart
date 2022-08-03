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

import 'package:demos_app/modules/proposals/pages/proposals/bloc/proposal_view_list_bloc.dart';
import 'package:demos_app/modules/proposals/pages/proposals/bloc/proposal_view_list_event.dart';
import 'package:demos_app/modules/proposals/pages/proposals/models/proposal_view.model.dart';
import 'package:demos_app/modules/proposals/services/proposal_vote.service.dart';
import 'package:demos_app/widgets/buttons/big_button_widget.dart';
import 'package:demos_app/widgets/buttons/left_back_button.widget.dart';
import 'package:demos_app/widgets/general/card.widget.dart';
import 'package:demos_app/widgets/titles/entity_title.widget.dart';
import 'package:demos_app/widgets/wrappers/safe_widget/safe_widget_validator.dart';
import 'package:flutter/material.dart';

class NullVoteScreen extends StatefulWidget {
  final ProposalView proposal;

  const NullVoteScreen({Key? key, required this.proposal}) : super(key: key);

  @override
  State<NullVoteScreen> createState() => _NullVoteScreenState();
}

class _NullVoteScreenState extends State<NullVoteScreen> {
  String reasons = '';

  @override
  Widget build(BuildContext context) {
    final Color primaryColor = Theme.of(context).primaryColor;
    return Scaffold(
      backgroundColor: primaryColor,
      body: Container(
        padding: const EdgeInsets.only(
            top: 32.0, left: 32.0, right: 32.0, bottom: 20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            LeftBackButton(onPressed: () => Navigator.pop(context)),
            const SizedBox(height: 15),
            Expanded(
                child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const EntityTitle(name: 'Nulo', label: 'Voto'),
                const Spacer(flex: 1),
                Expanded(
                    flex: 3,
                    child: CardWidget(
                        child:  Container(
                          padding: const EdgeInsets.symmetric(vertical: 24.0, horizontal: 20.0),
                          child: 
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text('Motivos'),
                        TextField(
                          decoration: const InputDecoration(
                            hintText:
                                'Opcionalmente puedes incluir un motivo de tu voto.',
                            hintMaxLines: 3,
                          ),
                          onChanged: (value) {
                            setState(() {
                              reasons = value;
                            });
                          },
                        ),
                      ],
                    )))),
                const Spacer(flex: 1),
                SafeWidgetValidator(
                    child: BigButton(
                  text: 'Confirmar',
                  onPressed: () => vote(context),
                ))
              ],
            ))
          ],
        ),
      ),
    );
  }

  void vote(BuildContext context) async {
    await ProposalVoteService()
        .voteNull(widget.proposal.spaceId, widget.proposal.proposalId, reasons);
    ProposalViewListBloc()
        .add(ProposalViewListUpdated(widget.proposal.spaceId));
    Navigator.pop(context);
    Navigator.pop(context);
    Navigator.pop(context);
  }
}

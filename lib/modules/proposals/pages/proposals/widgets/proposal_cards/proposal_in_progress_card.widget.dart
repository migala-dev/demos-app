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

import 'package:demos_app/config/routes/application.dart';
import 'package:demos_app/config/routes/routes.dart';
import 'package:demos_app/modules/proposals/pages/proposals/models/proposal_view.model.dart';
import 'package:demos_app/modules/proposals/pages/proposals/widgets/proposal_cards/proposal_card.interface.dart';
import 'package:demos_app/modules/proposals/pages/proposals/widgets/proposal_cards/proposal_cart_info.widget.dart';
import 'package:demos_app/modules/proposals/services/proposal_participation.service.dart';
import 'package:demos_app/modules/spaces/bloc/current_member/current_member.bloc.dart';
import 'package:flutter/material.dart';
import '../../../../../../widgets/general/countdown_timer.widget.dart';

class ProposalInProgressCard extends StatelessWidget implements ProposalCard {
  @override
  final ProposalView proposal;
  const ProposalInProgressCard(
      {Key? key, required this.proposal })
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () =>
          Application.router.navigateTo(context, Routes.proposalDetails,
              routeSettings: RouteSettings(
                arguments: proposal,
              )),
      child: Material(
        elevation: 2,
        borderRadius: BorderRadius.circular(20),
        child: Container(
          padding: const EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                padding: const EdgeInsets.only(bottom: 10.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(proposal.title ?? 'Sin titulo',
                        style: const TextStyle(fontSize: 20),
                        overflow: TextOverflow.ellipsis),
                    Container(
                        padding: const EdgeInsets.only(top: 4.0),
                        child: Text(
                          'Por: ${proposal.createdByName}',
                          style: TextStyle(
                              color: Colors.grey.shade600, fontSize: 12.0),
                        ))
                  ],
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  ProposalCardInfo(
                    getIcon: (size, color) => Icon(
                      Icons.calendar_today,
                      size: size,
                      color: color,
                    ),
                    title: 'TERMINA EN:',
                    child: CountdownTimer(dateTime: proposal.expiredAt),
                  ),
                  ProposalCardInfo(
                      getIcon: (size, color) => Icon(
                            Icons.how_to_vote,
                            size: size,
                            color: color,
                          ),
                      title: 'Votos:',
                      content: '${proposal.votesCount}/${proposal.votesTotal}')
                ],
              ),
              FutureBuilder(
                future: didCurrentUserParticipatedInProposal(),
                builder: (BuildContext context, AsyncSnapshot<bool> snapshot) {
                  if (snapshot.hasData) {
                    final bool didCurrentMemberParticipatedInProposal =
                        snapshot.data!;

                    if (!didCurrentMemberParticipatedInProposal) {
                      return Column(children: const [
                        SizedBox(height: 15),
                        Text('* Aún no has votado en esta propuesta',
                            style: TextStyle(color: Colors.redAccent))
                      ]);
                    }
                  }
                  return Container();
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future<bool> didCurrentUserParticipatedInProposal() async {
    final String currentUserId = CurrentMemberBloc().state!.userId;

    return ProposalParticipationService()
        .didUserParticipatedInProposal(currentUserId, proposal.proposalId);
  }
}

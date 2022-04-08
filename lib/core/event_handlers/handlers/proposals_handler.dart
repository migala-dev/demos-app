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

import 'package:demos_app/core/interfaces/event.handler.interface.dart';
import 'package:demos_app/core/mixins/event_handler_mixin.dart';
import 'package:demos_app/core/models/cache.model.dart';
import 'package:demos_app/modules/proposals/pages/proposals/bloc/proposal_view_list_bloc.dart';
import 'package:demos_app/modules/proposals/pages/proposals/bloc/proposal_view_list_event.dart';
import 'package:demos_app/modules/proposals/services/proposal.service.dart';

class ProposalHandler extends EventHandlerMixin {
  static final _proposalHandler = ProposalHandler._internal();
  ProposalHandler._internal();
  factory ProposalHandler() => _proposalHandler;

  @override
  String get key => 'proposals';
  @override
  final List<EventHandler> eventHandlers = [
    ProposalPublishedEvent(),
    ProposalVoteEvent()
  ];
}

class ProposalPublishedEvent implements EventHandler {
  @override
  String key = 'published';

  @override
  Future<void> handleEvent(Cache dataEvent) async {
    String spaceId = dataEvent.data!['spaceId'];
    String proposalId = dataEvent.data!['proposalId'];

    await ProposalService().getProposal(spaceId, proposalId);

    ProposalViewListBloc().add(ProposalViewListUpdated(spaceId));
  }
}

class ProposalVoteEvent implements EventHandler {
  @override
  String key = 'voted';

  @override
  Future<void> handleEvent(Cache dataEvent) async {
    String spaceId = dataEvent.data!['spaceId'];
    String proposalParticipationId = dataEvent.data!['proposalParticipationId'];

    await ProposalService()
        .getProposalParticipation(spaceId, proposalParticipationId);

    ProposalViewListBloc().add(ProposalViewListUpdated(spaceId));
  }
}

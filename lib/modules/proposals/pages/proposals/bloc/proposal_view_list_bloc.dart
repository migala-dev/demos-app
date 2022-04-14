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

import 'package:bloc/bloc.dart';
import 'package:demos_app/modules/proposals/pages/proposals/bloc/proposal_view_list_state.dart';
import 'package:demos_app/modules/proposals/pages/proposals/bloc/proposal_view_list_event.dart';
import 'package:demos_app/modules/proposals/pages/proposals/widgets/proposal_navigation_menu/constants/get_proposal_view_lists.dart';
import 'package:demos_app/modules/proposals/pages/proposals/widgets/proposal_navigation_menu/models/proposal_list.interface.dart';

class ProposalViewListBloc
    extends Bloc<ProposalViewListEvent, ProposalViewListState> {
  static final ProposalViewListBloc _proposalsBloc =
      ProposalViewListBloc._internal();
  factory ProposalViewListBloc() => _proposalsBloc;

  ProposalViewListBloc._internal()
      : super(ProposalViewListLoadingInProgress()) {
    on<ProposalViewListLoaded>((event, emit) => _onListLoaded(event, emit));
    on<ProposalViewListNewOptionSelected>(
        (event, emit) => _onListSelectedLoaded(event, emit));
    on<ProposalViewListUpdated>((event, emit) => _onListUpdated(event, emit));
  }

  void _onListLoaded(
      ProposalViewListLoaded event, Emitter<ProposalViewListState> emit) async {
    emit(ProposalViewListLoadingInProgress());

    for (ProposalViewList proposalListView in await getProposalViewLists()) {
      if (await proposalListView.itHasProposals(event.spaceId)) {
        emit(ProposalViewListWithData(proposalListView));
        return;
      }
    }

    emit(ProposalViewListEmpty());
  }

  void _onListSelectedLoaded(ProposalViewListNewOptionSelected event,
      Emitter<ProposalViewListState> emit) {
    emit(ProposalViewListWithData(event.proposalViewList));
  }

  void _onListUpdated(ProposalViewListUpdated event,
      Emitter<ProposalViewListState> emit) async {
    if (state is ProposalViewListWithData) {
      final prevState = state as ProposalViewListWithData;
      emit(ProposalViewListLoadingInProgress());

      final proposalListView = prevState.proposalViewList;
      final itHasProposals =
          await proposalListView.itHasProposals(event.spaceId);
      if (itHasProposals) {
        emit(ProposalViewListWithData(proposalListView));
        return;
      }
    }

    for (ProposalViewList proposalListView in await getProposalViewLists()) {
      if (await proposalListView.itHasProposals(event.spaceId)) {
        emit(ProposalViewListWithData(proposalListView));
        return;
      }
    }

    emit(ProposalViewListEmpty());
  }
}

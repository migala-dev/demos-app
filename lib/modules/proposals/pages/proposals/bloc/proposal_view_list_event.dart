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

import 'package:demos_app/modules/proposals/pages/proposals/widgets/proposal_navigation_menu/models/proposal_list.interface.dart';
import 'package:equatable/equatable.dart';

abstract class ProposalViewListEvent extends Equatable {
  const ProposalViewListEvent();

  @override
  List<Object> get props => [];
}

class ProposalViewListLoaded extends ProposalViewListEvent {
  final String spaceId;

  const ProposalViewListLoaded(this.spaceId);

  @override
  List<Object> get props => [spaceId];
}

class ProposalViewListNewOptionSelected extends ProposalViewListEvent {
  final String spaceId;
  final ProposalViewList proposalViewList;

  const ProposalViewListNewOptionSelected(this.spaceId, this.proposalViewList);

  @override
  List<Object> get props => [spaceId, proposalViewList];
}

class ProposalViewListUpdated extends ProposalViewListEvent {
  final String spaceId;

  const ProposalViewListUpdated(this.spaceId);

  @override
  List<Object> get props => [spaceId];
}

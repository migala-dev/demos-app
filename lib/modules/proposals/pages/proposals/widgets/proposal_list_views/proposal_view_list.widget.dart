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

import 'package:demos_app/modules/proposals/pages/proposals/models/proposal_view.model.dart';
import 'package:demos_app/modules/proposals/pages/proposals/widgets/proposal_cards/proposal_card.interface.dart';
import 'package:demos_app/widgets/general/cache_refresh_indicator.widget.dart';
import 'package:flutter/material.dart';

class ProposalViewListWidget extends StatelessWidget {
  final ProposalCard Function(ProposalView) getProposalCard;
  final List<ProposalView> proposals;

  const ProposalViewListWidget(
      {Key? key, required this.proposals, required this.getProposalCard})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CacheRefreshIndicator(
      list: ListView.builder(
        physics: const AlwaysScrollableScrollPhysics(),
        itemCount: proposals.length,
        itemBuilder: (context, index) => Container(
          margin: const EdgeInsets.only(bottom: 10, right: 15, left: 15),
          child: getProposalCard(proposals[index]),
        ),
      ),
    );
  }
}

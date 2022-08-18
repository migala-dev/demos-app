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
import 'package:demos_app/core/enums/space_role.enum.dart';
import 'package:demos_app/modules/proposals/pages/proposal_form/bloc/proposal_form.bloc.dart';
import 'package:demos_app/modules/proposals/pages/proposal_form/bloc/proposal_form_bloc.events.dart';
import 'package:demos_app/modules/proposals/pages/proposal_form/models/proposal_form_view.model.dart';
import 'package:demos_app/modules/proposals/pages/proposals/widgets/proposal_navigation_menu/models/proposal_list.interface.dart';
import 'package:demos_app/modules/proposals/pages/proposals/widgets/proposals_list.widget.dart';
import 'package:demos_app/modules/spaces/widgets/safe_member_validator.widget.dart';
import 'package:demos_app/widgets/general/cache_refresh_indicator.widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:demos_app/modules/proposals/pages/proposals/bloc/proposal_view_list_bloc.dart';
import 'package:demos_app/modules/proposals/pages/proposals/bloc/proposal_view_list_state.dart';
import 'package:demos_app/modules/proposals/pages/proposals/widgets/no_proposals.widget.dart';
import 'package:demos_app/modules/proposals/pages/proposals/widgets/proposal_navigation_menu/proposals_navigation_menu.widget.dart';

class ProposalsPage extends StatelessWidget {
  const ProposalsPage({Key? key}) : super(key: key);
  void goToNewProposal(BuildContext context) {
    ProposalFormBloc()
        .add(ProposalFormSetProposalFormView(ProposalFormView.empty()));
    Navigator.pushNamed(context, Routes.proposalForm);
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ProposalViewListBloc, ProposalViewListState>(
      bloc: ProposalViewListBloc(),
      builder: (context, state) {
        if (state is ProposalViewListLoadingInProgress) {
          return const Center(child: CircularProgressIndicator());
        }

        ProposalViewList? proposalViewList =
            state is ProposalViewListWithData ? state.proposalViewList : null;

        return Scaffold(
          floatingActionButton: SafeWidgetMemberValidator(
            roles: const [SpaceRole.representative],
            child: FloatingActionButton(
              child: const Icon(Icons.how_to_vote),
              onPressed: () => goToNewProposal(context),
            ),
          ),
          body: state is ProposalViewListEmpty
              ? CacheRefreshIndicator(
                  child: Center(
                    child: NoProposals(),
                  ),
                )
              : Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 15),
                      child: ProposalsNavigationMenu(
                        optionSelected: proposalViewList!,
                      ),
                    ),
                    Expanded(
                      child: ProposalsListWidget(
                        proposalViewList: proposalViewList,
                      ),
                    ),
                  ],
                ),
        );
      },
    );
  }
}

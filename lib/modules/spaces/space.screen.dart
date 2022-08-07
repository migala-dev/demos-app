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

import 'package:demos_app/config/custom-icons/demos_icons_icons.dart';
import 'package:demos_app/config/routes/routes.dart';
import 'package:demos_app/config/themes/main_theme.dart';
import 'package:demos_app/core/enums/space_role.enum.dart';
import 'package:demos_app/modules/proposals/pages/proposal_form/bloc/proposal_form.bloc.dart';
import 'package:demos_app/modules/proposals/pages/proposal_form/bloc/proposal_form_bloc.events.dart';
import 'package:demos_app/modules/proposals/pages/proposal_form/models/proposal_form_view.model.dart';
import 'package:demos_app/modules/proposals/pages/proposals/proposals.page.dart';
import 'package:demos_app/modules/proposals/pages/proposals/widgets/proposal_navigation_menu/models/proposal_list.interface.dart';
import 'package:demos_app/modules/spaces/widgets/safe_member_validator.widget.dart';
import 'package:demos_app/modules/suggestions/suggestions.page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:demos_app/modules/proposals/pages/proposals/bloc/proposal_view_list_bloc.dart';
import 'package:demos_app/modules/proposals/pages/proposals/bloc/proposal_view_list_state.dart';

class SpaceScreen extends StatefulWidget {
  const SpaceScreen({Key? key}) : super(key: key);

  @override
  State<SpaceScreen> createState() => _SpaceScreenState();
}

class _SpaceScreenState extends State<SpaceScreen> {
  int selectedIndex = 0;

  void onItemTapped(int index) => setState(() => selectedIndex = index);

  void goToNewProposal(BuildContext context) {
    ProposalFormBloc()
        .add(ProposalFormSetProposalFormView(ProposalFormView.empty()));
    Navigator.pushNamed(context, Routes.proposalForm);
  }

  void goToNewSuggestion(BuildContext context) {
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

        Widget changeBody() {
          if (selectedIndex == 0) {
            return ProposalsPage(
                proposalViewList: proposalViewList, state: state);
          } else {
            return const SuggestionPage();
          }
        }

        Widget changeFloatingActionButton() {
          if (selectedIndex == 0) {
            return SafeWidgetMemberValidator(
              roles: const [SpaceRole.representative],
              child: FloatingActionButton(
                child: const Icon(DemosIcons.add_proposal, color: primaryColor),
                onPressed: () => goToNewProposal(context),
              ),
            );
          } else {
            return SafeWidgetMemberValidator(
              roles: const [SpaceRole.worker],
              child: FloatingActionButton(
                child: const Icon(DemosIcons.add_proposal, color: primaryColor),
                onPressed: () => goToNewSuggestion(context),
              ),
            );
          }
        }

        return Scaffold(
          floatingActionButton: changeFloatingActionButton(),
          body: changeBody(),
          bottomNavigationBar: ClipRRect(
            borderRadius:
                const BorderRadius.only(topRight: Radius.circular(24)),
            child: BottomNavigationBar(
              backgroundColor: primaryColorLight,
              currentIndex: selectedIndex,
              onTap: onItemTapped,
              items: const [
                BottomNavigationBarItem(
                  label: 'Propuestas',
                  icon: Icon(DemosIcons.home),
                ),
                BottomNavigationBarItem(
                  icon: Icon(DemosIcons.notes_outlined),
                  label: 'Sugerencias',
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}

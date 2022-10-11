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
import 'package:demos_app/modules/spaces/widgets/safe_member_validator.widget.dart';
import 'package:demos_app/modules/suggestions/suggestions.page.dart';
import 'package:flutter/material.dart';

abstract class SpaceTab {
  Widget getBody();
  Widget getFloatingActionButton(BuildContext context);
  BottomNavigationBarItem getBarItem();
}

class ProposalSpaceTab implements SpaceTab {
  void _goToProposal(BuildContext context) {
    ProposalFormBloc()
        .add(ProposalFormSetProposalFormView(ProposalFormView.empty()));
    Navigator.pushNamed(context, Routes.proposalForm);
  }

  @override
  Widget getBody() => const ProposalsPage();

  @override
  Widget getFloatingActionButton(BuildContext context) {
    return SafeWidgetMemberValidator(
      roles: const [SpaceRole.representative],
      child: FloatingActionButton(
        child: const Icon(DemosIcons.add_proposal, color: primaryColor),
        onPressed: () => _goToProposal(context),
      ),
    );
  }

  @override
  BottomNavigationBarItem getBarItem() {
    return const BottomNavigationBarItem(
      label: 'Propuestas',
      icon: Icon(DemosIcons.home),
    );
  }
}

class SuggestionSpaceTab implements SpaceTab {
  void _goToSuggestion(BuildContext context) {
    Navigator.pushNamed(context, Routes.proposalForm);
  }

  @override
  Widget getBody() => const SuggestionPage();

  @override
  Widget getFloatingActionButton(BuildContext context) {
    return SafeWidgetMemberValidator(
      roles: const [SpaceRole.worker, SpaceRole.admin],
      child: FloatingActionButton(
        child: const Icon(DemosIcons.add_proposal, color: primaryColor),
        onPressed: () => _goToSuggestion(context),
      ),
    );
  }

  @override
  BottomNavigationBarItem getBarItem() {
    return const BottomNavigationBarItem(
      icon: Icon(DemosIcons.notes_outlined),
      label: 'Sugerencias',
    );
  }
}

class SpaceNavigationAndPagesScreen extends StatefulWidget {
  const SpaceNavigationAndPagesScreen({Key? key}) : super(key: key);

  @override
  State<SpaceNavigationAndPagesScreen> createState() =>
      _SpaceNavigationAndPagesScreenState();
}

class _SpaceNavigationAndPagesScreenState
    extends State<SpaceNavigationAndPagesScreen> {
  int selectedTab = 0;
  List<SpaceTab> spaceTabs = [ProposalSpaceTab(), SuggestionSpaceTab()];

  SpaceTab get currentTab => spaceTabs[selectedTab];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: currentTab.getFloatingActionButton(context),
      body: currentTab.getBody(),
      bottomNavigationBar: ClipRRect(
        borderRadius: const BorderRadius.only(topRight: Radius.circular(24)),
        child: BottomNavigationBar(
          backgroundColor: primaryColorLight,
          currentIndex: selectedTab,
          onTap: (int index) => setState(() => selectedTab = index),
          items: spaceTabs.map((t) => t.getBarItem()).toList(),
        ),
      ),
    );
  }
}

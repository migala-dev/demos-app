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

import 'package:demos_app/modules/proposals/pages/proposal_form/enums/proposal_form_type.enum.dart';
import 'package:demos_app/modules/proposals/pages/proposal_form/interfaces/proposal_form_config.interface.dart';
import 'package:demos_app/modules/proposals/pages/proposal_form/proposal_form_config/draft.proposal_form_config.dart';
import 'package:demos_app/modules/proposals/pages/proposal_form/proposal_form_config/in_progress.proposal_form_config.dart';
import 'package:demos_app/modules/proposals/pages/proposal_form/proposal_form_config/new.proposal_form_config.dart';

ProposalFormConfig getProposalFormConfigFromType(ProposalFormType type) {
  switch (type) {
    case ProposalFormType.newProposal:
      return NewProposalFormConfig();
    case ProposalFormType.draft:
      return DraftProposalFormConfig();
    case ProposalFormType.proposalInProgress:
      return InProgressProposalFormConfig();
  }
}

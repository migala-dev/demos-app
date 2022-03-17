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

import 'package:demos_app/core/enums/manifesto_option_type.enum.dart';
import 'package:demos_app/modules/proposals/pages/proposal_form/models/proposal_form_view.model.dart';
import 'package:demos_app/modules/proposals/pages/proposal_form/forms/option_step/models/manifesto_option_view.model.dart';
import 'package:equatable/equatable.dart';

abstract class ProposalFormBlocEvent extends Equatable {
  const ProposalFormBlocEvent();

  @override
  List<Object?> get props => [];
}

class ProposalFormSetProposalFormView extends ProposalFormBlocEvent {
  final ProposalFormView proposalFormView;

  const ProposalFormSetProposalFormView(this.proposalFormView);
}

class ProposalFormOnTitleChange extends ProposalFormBlocEvent {
  final String title;

  const ProposalFormOnTitleChange(this.title);
}

class ProposalFormOnContentChange extends ProposalFormBlocEvent {
  final String content;

  const ProposalFormOnContentChange(this.content);
}

class ProposalFormOnOptionTypeChange extends ProposalFormBlocEvent {
  final ManifestoOptionType optionType;

  const ProposalFormOnOptionTypeChange(this.optionType);
}

class ProposalFormOnManifestoOptionsChange extends ProposalFormBlocEvent {
  final List<ManifestoOptionView> manifestoOptions;

  const ProposalFormOnManifestoOptionsChange(this.manifestoOptions);
}

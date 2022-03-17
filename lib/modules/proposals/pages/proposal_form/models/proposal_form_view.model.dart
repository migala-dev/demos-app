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
import 'package:demos_app/modules/proposals/pages/proposal_form/enums/proposal_form_type.enum.dart';
import 'package:demos_app/modules/proposals/pages/proposal_form/forms/option_step/models/manifesto_option_view.model.dart';

class ProposalFormView {
  String? proposalId;
  String title;
  String content;
  ManifestoOptionType optionType;
  bool change = false;
  List<ManifestoOptionView> manifestoOptions;
  final ProposalFormType type;

  ProposalFormView(
      {required this.title,
      required this.content,
      required this.optionType,
      required this.manifestoOptions,
      required this.type,
      this.proposalId,
      this.change = false});

  factory ProposalFormView.createCopy(ProposalFormView p) => ProposalFormView(
      title: p.title,
      content: p.content,
      optionType: p.optionType,
      manifestoOptions: p.manifestoOptions,
      proposalId: p.proposalId,
      type: p.type,
      change: p.change);

  ProposalFormView.empty(
      {this.title = '',
      this.content = '',
      this.optionType = ManifestoOptionType.inFavorOrOpposing,
      this.manifestoOptions = const [],
      this.type = ProposalFormType.newProposal}) {
    manifestoOptions = [];
  }
}

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

import 'package:demos_app/modules/proposals/pages/proposal_form/bloc/proposal_form_bloc.events.dart';
import 'package:demos_app/modules/proposals/pages/proposal_form/models/proposal_form_view.model.dart';
import 'package:demos_app/modules/proposals/pages/proposal_form/forms/option_step/models/manifesto_option_view.model.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ProposalFormBloc extends Bloc<ProposalFormBlocEvent, ProposalFormView> {
  static final ProposalFormBloc _proposalFormBloc =
      ProposalFormBloc._internal();
  factory ProposalFormBloc() => _proposalFormBloc;
  ProposalFormBloc._internal()
      : super(ProposalFormView.empty(manifestoOptions: [])) {
    on<ProposalFormSetProposalFormView>((event, emit) {
      emit(event.proposalFormView);
    });
    on<ProposalFormOnTitleChange>((event, emit) {
      ProposalFormView newState = ProposalFormView.createCopy(state);

      String title = event.title;
      newState.title = title;
      newState.change = true;

      emit(newState);
    });
    on<ProposalFormOnContentChange>((event, emit) {
      ProposalFormView newState = ProposalFormView.createCopy(state);

      String content = event.content;
      newState.content = content;
      newState.change = true;

      emit(newState);
    });
    on<ProposalFormOnOptionTypeChange>((event, emit) {
      ProposalFormView newState = ProposalFormView.createCopy(state);

      newState.optionType = event.optionType;
      newState.change = true;

      emit(newState);
    });
    on<ProposalFormOnManifestoOptionsChange>((event, emit) {
      ProposalFormView newState = ProposalFormView.createCopy(state);

      List<ManifestoOptionView> manifestoOptions = event.manifestoOptions;
      newState.manifestoOptions = manifestoOptions;
      newState.change = true;

      emit(newState);
    });
  }
}

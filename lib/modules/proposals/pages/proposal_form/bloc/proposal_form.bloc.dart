import 'package:demos_app/modules/proposals/pages/proposal_form/bloc/proposal_form_bloc.events.dart';
import 'package:demos_app/modules/proposals/pages/proposal_form/modals/proposal_form_view.model.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ProposalFormBloc extends Bloc<ProposalFormBlocEvent, ProposalFormView> {
  static final ProposalFormBloc _proposalFormBloc =
      ProposalFormBloc._internal();
  factory ProposalFormBloc() => _proposalFormBloc;

  ProposalFormBloc._internal() : super(ProposalFormView.empty()) {
    on<ProposalFormOnTitleChange>((event, emit) {
      String title = event.title;
      state.title = title;
    });
    on<ProposalFormOnContentChange>((event, emit) {
      String content = event.content;
      state.content = content;
    });
    on<ProposalFormOnOptionTypeChange>((event, emit) {
      state.optionType = event.optionType;
    });
  }
}

import 'package:demos_app/modules/proposals/pages/proposal_details/bloc/proposal_details_bloc.events.dart';
import 'package:demos_app/modules/proposals/pages/proposals/models/proposal_view.model.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ProposalDetailsBloc extends Bloc<ProposalDetailsEvent, ProposalView?> {
  static final ProposalDetailsBloc _proposalDetailsBloc = ProposalDetailsBloc._internal();
  factory ProposalDetailsBloc() => _proposalDetailsBloc;

  ProposalDetailsBloc._internal(): super(null) {
    on<SetProposalViewEvent>((event, emit) => emit(event.proposalView));
  }
}
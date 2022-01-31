import 'package:bloc/bloc.dart';
import 'package:demos_app/modules/proposals/pages/proposals/bloc/proposal_view_list_state.dart';
import 'package:demos_app/modules/proposals/pages/proposals/bloc/proposal_view_list_event.dart';
import 'package:demos_app/modules/proposals/pages/proposals/widgets/proposal_navigation_menu/constants/get_proposal_view_lists.dart';
import 'package:demos_app/modules/proposals/pages/proposals/widgets/proposal_navigation_menu/models/proposal_list.interface.dart';

class ProposalViewListBloc
    extends Bloc<ProposalViewListEvent, ProposalViewListState> {
  static final ProposalViewListBloc _proposalsBloc = ProposalViewListBloc._internal();
  factory ProposalViewListBloc() => _proposalsBloc;

  ProposalViewListBloc._internal(): super(ProposalViewListLoadingInProgress()) {
    on<ProposalViewListLoaded>((event, emit) => _onListLoaded(event, emit));
    on<ProposalViewListNewOptionSelected>((event, emit) => _onListSelectedLoaded(event, emit));
  }

  void _onListLoaded(ProposalViewListLoaded event, Emitter<ProposalViewListState> emit) async {
      emit(ProposalViewListLoadingInProgress());

      for (ProposalViewList proposalListView in await getProposalViewLists()) {
        if (await proposalListView.itHasProposals(event.spaceId)) {
          emit(ProposalViewListWithData(proposalListView));
          return;
        }
      }

      emit(ProposalViewListEmpty());
  }

  void _onListSelectedLoaded(ProposalViewListNewOptionSelected event, Emitter<ProposalViewListState> emit) {
      emit(ProposalViewListWithData(event.proposalViewList));
  }
}
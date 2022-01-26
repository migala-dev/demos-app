
import 'package:demos_app/modules/proposals/pages/proposals/services/proposal_views.service.dart';
import 'package:demos_app/shared/constants/proposal_list_type_menu_order.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:demos_app/modules/proposals/pages/proposals/bloc/proposal_view_list_event.dart';
import 'package:demos_app/modules/proposals/pages/proposals/bloc/proposal_view_list_state.dart';

class ProposalViewListBloc
    extends Bloc<ProposalViewListEvent, ProposalViewListState> {
  static final ProposalViewListBloc _proposalsBloc =
      ProposalViewListBloc._internal();
  factory ProposalViewListBloc() => _proposalsBloc;
  ProposalViewListBloc._internal()
      : super(ProposalViewListLoadingInProgress()) {
    on<ProposalViewListLoaded>((event, emit) async {
      emit(ProposalViewListLoadingInProgress());
      for (final type in proposalListTypeMenuOrder) {
        final proposals = await ProposalViewsService()
            .getProposalViewsByProposalListTypeAndSpaceId(type, event.spaceId);
        if (proposals.isNotEmpty) {
          emit(ProposalViewListWithData(proposals, type));
          return;
        }
      }
      emit(ProposalViewListEmpty());
    });

    on<ProposalViewListNewOptionSelected>((event, emit) async {
      emit(ProposalViewListLoadingInProgress());

      final proposals = await ProposalViewsService()
          .getProposalViewsByProposalListTypeAndSpaceId(
              event.type, event.spaceId);

      emit(ProposalViewListWithData(proposals, event.type));
    });
  }
}

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:demos_app/modules/proposals/proposals/enums/proposal_list_type.enum.dart';
import 'package:demos_app/modules/proposals/proposals/models/proposal_view.model.dart';
import 'package:demos_app/modules/proposals/proposals/services/proposal_views.service.dart';
import 'package:demos_app/shared/constants/proposal_list_type_menu_order.dart';

part 'proposal_views_event.dart';
part 'proposal_views_state.dart';

class ProposalViewsBloc extends Bloc<ProposalViewsEvent, ProposalViewsState> {
  static final ProposalViewsBloc _proposalsBloc = ProposalViewsBloc._internal();
  factory ProposalViewsBloc() => _proposalsBloc;
  ProposalViewsBloc._internal() : super(ProposalViewsLoadingInProgress()) {
    on<ProposalViewsInitialized>((event, emit) async {
      emit(ProposalViewsLoadingInProgress());
      for (final type in proposalListTypeMenuOrder) {
        final proposals = await ProposalViewsService()
            .getProposalViewsByProposalListTypeAndSpaceId(type, event.spaceId);
        if (proposals.isNotEmpty) {
          emit(ProposalsStateWithData(proposals, type));
          return;
        }
      }
      emit(ProposalsStateWithData(const [], proposalListTypeMenuOrder.first));
    });

    on<ProposalViewsLoaded>((event, emit) async {
      emit(ProposalViewsLoadingInProgress());

      final proposals = await ProposalViewsService()
          .getProposalViewsByProposalListTypeAndSpaceId(
              event.type, event.spaceId);

      emit(ProposalsStateWithData(proposals, event.type));
    });
  }
}

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:demos_app/modules/proposals/proposals/services/proposals.service.dart';
import 'package:demos_app/shared/constants/proposal_list_type_menu_order.dart';
import 'package:demos_app/core/enums/proposal_list_type.enum.dart';
import 'package:demos_app/core/models/manifesto/manifesto.model.dart';

part 'proposals_event.dart';
part 'proposals_state.dart';

class ProposalsBloc extends Bloc<ProposalsEvent, ProposalsState> {
  static final ProposalsBloc _proposalsBloc = ProposalsBloc._internal();
  factory ProposalsBloc() => _proposalsBloc;
  ProposalsBloc._internal() : super(ProposalsLoadingInProgress()) {
    on<ProposalsInitialized>((event, emit) async {
      emit(ProposalsLoadingInProgress());
      for (final type in proposalListTypeMenuOrder) {
        final proposals = await ProposalsService()
            .getProposalsByProposalListTypeAndSpaceId(type, event.spaceId);
        if (proposals.isNotEmpty) {
          emit(ProposalsStateWithData(proposals, type));
          return;
        }
      }
      emit(ProposalsStateWithData(const [], proposalListTypeMenuOrder.first));
    });

    on<ProposalsLoaded>((event, emit) async {
      emit(ProposalsLoadingInProgress());

      final proposals = await ProposalsService()
          .getProposalsByProposalListTypeAndSpaceId(event.type, event.spaceId);

      emit(ProposalsStateWithData(proposals, event.type));
    });
  }
}

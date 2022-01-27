import 'package:demos_app/core/interfaces/event.handler.interface.dart';
import 'package:demos_app/core/mixins/event_handler_mixin.dart';
import 'package:demos_app/core/models/cache.model.dart';
import 'package:demos_app/modules/proposals/pages/proposals/bloc/proposal_view_list_bloc.dart';
import 'package:demos_app/modules/proposals/pages/proposals/bloc/proposal_view_list_event.dart';
import 'package:demos_app/modules/proposals/services/proposal.service.dart';

class ProposalHandler extends EventHandlerMixin {
  static final _proposalHandler = ProposalHandler._internal();
  ProposalHandler._internal();
  factory ProposalHandler() => _proposalHandler;

  @override
  String get key => 'proposals';
  @override
  final List<EventHandler> eventHandlers = [ProposalPublishedEvent()];
}

class ProposalPublishedEvent implements EventHandler {
  @override
  String key = 'published';

  @override
  Future<void> handleEvent(Cache dataEvent) async {
    String spaceId = dataEvent.data!['spaceId'];
    String proposalId = dataEvent.data!['proposalId'];

    await ProposalService().getProposal(spaceId, proposalId);

    ProposalViewListBloc().add(ProposalViewListLoaded(spaceId));
  }
}

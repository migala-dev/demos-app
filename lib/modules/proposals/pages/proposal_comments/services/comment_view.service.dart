import 'package:demos_app/modules/proposals/pages/proposal_comments/models/comment_view.model.dart';
import 'package:demos_app/modules/proposals/pages/proposal_comments/repositories/comment_view.repository.dart';
import 'package:demos_app/modules/proposals/pages/proposal_details/bloc/proposal_details.bloc.dart';

class CommentViewService {
  Future<List<CommentView>> getComments() async {
    final String proposalId = ProposalDetailsBloc().state!.proposalId;

    final comments = await CommentViewRepository().findByProposalId(proposalId);

    return comments;
  }
}

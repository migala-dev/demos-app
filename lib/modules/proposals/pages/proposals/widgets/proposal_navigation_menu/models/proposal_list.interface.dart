import 'package:demos_app/modules/proposals/pages/proposals/models/proposal_view.model.dart';
import 'package:flutter/material.dart';

abstract class ProposalViewList {
  late String title;
  Widget getWidget(BuildContext context, List<ProposalView> proposals);
  Future<bool> itHasProposals(String spaceId);
  Future<List<ProposalView>> getList(String spaceId);
}

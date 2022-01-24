import 'package:demos_app/modules/proposals/proposals/widgets/proposal_cards/proposal_draft_card.widget.dart';
import 'package:flutter/material.dart';
import 'package:demos_app/modules/proposals/proposals/enums/proposal_list_type.enum.dart';
import 'package:demos_app/modules/proposals/proposals/models/proposal_view.model.dart';

class ProposalsListView extends StatelessWidget {
  final List<ProposalView> proposals;
  final ProposalListType type;

  const ProposalsListView(
      {Key? key, required this.proposals, required this.type})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    if (type == ProposalListType.draft) {
      return getDaftsListView();
    }
    return Container();
  }

  Widget getDaftsListView() {
    return ListView.builder(
      physics: const BouncingScrollPhysics(),
      itemCount: proposals.length,
      itemBuilder: (context, index) => Container(
          margin: const EdgeInsets.only(bottom: 10),
          child: ProposalDraftCard(
            proposal: proposals[index],
            onTap: () {},
          )),
    );
  }
}

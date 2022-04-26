import 'package:demos_app/modules/proposals/pages/proposals/models/proposal_view.model.dart';
import 'package:demos_app/modules/proposals/pages/proposals/widgets/proposal_navigation_menu/models/proposal_list.interface.dart';
import 'package:demos_app/modules/spaces/models/space_view.model.dart';
import 'package:demos_app/modules/spaces/pages/space_details/bloc/space.bloc.dart';
import 'package:flutter/material.dart';

class ProposalsListWidget extends StatelessWidget {
  final ProposalViewList proposalViewList;

  const ProposalsListWidget({Key? key, required this.proposalViewList})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    SpaceView space = SpaceBloc().state;
    Key _key = UniqueKey();
    return Container(
      key: _key,
      child: FutureBuilder(
          future: proposalViewList.getList(space.spaceId!),
          initialData: const <ProposalView>[],
          builder: (BuildContext context,
              AsyncSnapshot<List<ProposalView>> snapshot) {
            List<ProposalView>? proposals = snapshot.data;
            if (proposals != null) {
              return proposalViewList.getWidget(context, proposals);
            }
            return Container();
          }),
    );
  }
}

import 'package:demos_app/modules/proposals/pages/proposals/widgets/proposal_navigation_menu/models/proposal_list.interface.dart';
import 'package:flutter/material.dart';
import 'package:demos_app/modules/proposals/pages/proposals/bloc/proposal_view_list_bloc.dart';
import 'package:demos_app/modules/proposals/pages/proposals/bloc/proposal_view_list_event.dart';
import 'package:demos_app/modules/proposals/pages/proposals/widgets/proposal_navigation_menu/proposals_navigation_option.widget.dart';
import 'package:demos_app/modules/spaces/pages/space_details/bloc/space.bloc.dart';

import 'constants/get_proposal_view_lists.dart';

class ProposalsNavigationMenu extends StatelessWidget {
  final ProposalViewList optionSelected;
  const ProposalsNavigationMenu({Key? key, required this.optionSelected})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: getMenuOptions(),
      initialData: const <ProposalViewList>[],
      builder: (BuildContext context,
          AsyncSnapshot<List<ProposalViewList>> snapshot) {
        if (!snapshot.hasData) {
          return Container();
        }
        final proposalListSections = snapshot.data!;
        if (proposalListSections.isEmpty) {
          return Container();
        }

        return SizedBox(
          height: 25,
          child: ListView(
            scrollDirection: Axis.horizontal,
            physics: const BouncingScrollPhysics(),
            children: [
              const SizedBox(width: 15),
              ...proposalListSections
                  .map((proposalList) => Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 10),
                        child: ProposalsNavigationOption(
                            title: proposalList.title,
                            selected: optionSelected == proposalList,
                            onTap: () => changeCurrentMenuOption(proposalList)),
                      ))
                  .toList()
            ],
          ),
        );
      },
    );
  }

  Future<List<ProposalViewList>> getMenuOptions() async {
    final List<ProposalViewList> menuOptions = [];
    final String spaceId = SpaceBloc().state!.spaceId!;
    for (final proposalList in await getProposalViewLists()) {
      if (await proposalList.itHasProposals(spaceId)) {
        menuOptions.add(proposalList);
      }
    }

    return menuOptions;
  }

  void changeCurrentMenuOption(ProposalViewList proposalViewList) {
    final String spaceId = SpaceBloc().state!.spaceId!;
    ProposalViewListBloc()
        .add(ProposalViewListNewOptionSelected(spaceId, proposalViewList));
  }
}
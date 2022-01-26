import 'package:demos_app/modules/proposals/pages/proposals/bloc/proposal_view_list_bloc.dart';
import 'package:demos_app/modules/proposals/pages/proposals/bloc/proposal_view_list_event.dart';
import 'package:demos_app/modules/proposals/pages/proposals/enums/proposal_list_type.enum.dart';
import 'package:demos_app/modules/proposals/pages/proposals/services/proposal_views.service.dart';
import 'package:demos_app/modules/proposals/pages/proposals/widgets/proposal_navigation_menu/proposals_navigation_option.widget.dart';
import 'package:flutter/material.dart';
import 'package:demos_app/modules/spaces/pages/spaces/services/space.bloc.dart';
import 'package:demos_app/shared/constants/proposal_list_type_menu_order.dart';

class ProposalsNavigationMenu extends StatelessWidget {
  final ProposalListType optionSelected;
  const ProposalsNavigationMenu({Key? key, required this.optionSelected})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: getMenuOptions(),
      initialData: const <ProposalListType>[],
      builder: (BuildContext context,
          AsyncSnapshot<List<ProposalListType>> snapshot) {
        if (!snapshot.hasData) {
          return Container();
        }
        final menuOptions = snapshot.data!;
        if (menuOptions.isEmpty) {
          return Container();
        }

        return SizedBox(
          height: 25,
          child: ListView(
            scrollDirection: Axis.horizontal,
            physics: const BouncingScrollPhysics(),
            children: [
              const SizedBox(width: 15),
              ...menuOptions
                  .map((menuOption) => Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 10),
                        child: ProposalsNavigationOption(
                            title: getOptionText(menuOption),
                            selected: optionSelected == menuOption,
                            onTap: () => changeCurrentMenuOption(menuOption)),
                      ))
                  .toList()
            ],
          ),
        );
      },
    );
  }

  Future<List<ProposalListType>> getMenuOptions() async {
    final List<ProposalListType> menuOptions = [];
    final String spaceId = SpaceBloc().state!.spaceId!;
    for (final type in proposalListTypeMenuOrder) {
      final itHasProposalsOnType =
          await ProposalViewsService().itHasProposalsOnType(type, spaceId);
      if (itHasProposalsOnType) {
        menuOptions.add(type);
      }
    }

    return menuOptions;
  }

  String getOptionText(ProposalListType option) {
    switch (option) {
      case ProposalListType.draft:
        return 'BORRADORES';
      case ProposalListType.inProgress:
        return 'EN PROCESO';
      case ProposalListType.recent:
        return 'RECIENTES';
      case ProposalListType.history:
        return 'HISTORIA';
    }
  }

  void changeCurrentMenuOption(ProposalListType newOption) {
    final String spaceId = SpaceBloc().state!.spaceId!;
    ProposalViewListBloc()
        .add(ProposalViewListNewOptionSelected(spaceId, newOption));
  }
}
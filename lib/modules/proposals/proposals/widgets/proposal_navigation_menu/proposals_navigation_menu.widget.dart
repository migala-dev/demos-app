import 'package:demos_app/modules/proposals/proposals/bloc/proposal_views_bloc.dart';
import 'package:demos_app/modules/proposals/proposals/enums/proposal_list_type.enum.dart';
import 'package:flutter/material.dart';
import 'package:demos_app/core/repositories/manifesto/manifesto.repository.dart';
import 'package:demos_app/modules/proposals/proposals/widgets/proposal_navigation_menu/proposals_navigation_option.widget.dart';
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
                            text: getOptionText(menuOption),
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
      final proposal = await ManifestoRepository().findOneBySpaceId(spaceId);
      if (proposal != null) {
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
    ProposalViewsBloc().add(ProposalViewsLoaded(spaceId, newOption));
  }
}

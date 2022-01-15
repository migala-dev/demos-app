import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:demos_app/core/bloc/proposals_bloc/proposals_bloc.dart';
import 'package:demos_app/core/enums/proposal_list_type.enum.dart';
import 'package:demos_app/core/repositories/manifesto/manifesto.repository.dart';
import 'package:demos_app/modules/proposals/proposals/widgets/proposal_navigation_menu/proposals_navigation_option.widget.dart';
import 'package:demos_app/modules/spaces/pages/spaces/services/space.bloc.dart';
import 'package:demos_app/shared/constants/proposal_list_type_menu_order.dart';
import 'package:demos_app/utils/mixins/loading_state_handler.mixin.dart';

class ProposalsNavigationMenu extends StatefulWidget {
  const ProposalsNavigationMenu({Key? key}) : super(key: key);

  @override
  State<ProposalsNavigationMenu> createState() =>
      _ProposalsNavigationMenuState();
}

class _ProposalsNavigationMenuState extends State<ProposalsNavigationMenu>
    with LoadingStateHandler {
  ProposalListType currentMenuOption = ProposalListType.inProgress;
  List<ProposalListType> menuOptions = [];
  @override
  void initState() {
    isLoading = true;
    getMenuOptions();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    if (menuOptions.isEmpty || isLoading) {
      return Container();
    }

    return BlocListener<ProposalsBloc, ProposalsState>(
      listener: (context, state) {
        if (state is ProposalsStateWithData) {
          getMenuOptions();
        }
      },
      child: SizedBox(
        height: 20,
        child: ListView(
          scrollDirection: Axis.horizontal,
          physics: const BouncingScrollPhysics(),
          children: [
            const SizedBox(width: 15),
            ...menuOptions
                .map((menuOption) => ProposalsNavigationOption(
                    text: getOptionText(menuOption),
                    selected: currentMenuOption == menuOption,
                    onTap: () => changeCurrentMenuOption(menuOption)))
                .toList()
          ],
        ),
      ),
    );
  }

  void getMenuOptions() => wrapLoadingTransaction(() async {
        menuOptions = [];
        final String spaceId = SpaceBloc().state!.spaceId!;
        for (final type in proposalListTypeMenuOrder) {
          final proposal =
              await ManifestoRepository().findOneBySpaceId(spaceId);
          if (proposal != null) {
            menuOptions.add(type);
          }
        }

        if (menuOptions.isNotEmpty &&
            !menuOptions.contains(currentMenuOption)) {
          currentMenuOption = menuOptions.first;
        }
      });

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
    ProposalsBloc().add(ProposalsLoaded(spaceId, newOption));
  }
}

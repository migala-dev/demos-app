import 'package:demos_app/modules/proposals/pages/proposal_details/menu_options/cancel_proposal.menu_option.dart';
import 'package:demos_app/modules/proposals/pages/proposal_details/menu_options/edit_proposal.menu_option.dart';
import 'package:demos_app/shared/interfaces/menu_option.interface.dart';
import 'package:demos_app/widgets/general/popup_menu_options.widget.dart';
import 'package:flutter/material.dart';

class PopupProposalDetailsMenuOptions extends StatelessWidget {
  final List<MenuOption> menuOptions = [
    CancelProposalMenuOption(),
    EditProposalMenuOption()
  ];

  PopupProposalDetailsMenuOptions({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return PopupMenuOptions(menuOptions: menuOptions);
  }
}

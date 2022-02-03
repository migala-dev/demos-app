import 'package:demos_app/modules/proposals/pages/proposal_form/widgets/delete_proposal_draft_menu_option.widget.dart';
import 'package:demos_app/shared/interfaces/menu_option.interface.dart';
import 'package:demos_app/widgets/general/popup_menu_options.widget.dart';
import 'package:flutter/material.dart';

class PopupProposalFormMenuOptions extends StatelessWidget {
  final List<MenuOption> menuOptions = [DeleteProposalDraftMenuOption()];

  PopupProposalFormMenuOptions({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return PopupMenuOptions(menuOptions: menuOptions);
  }
}

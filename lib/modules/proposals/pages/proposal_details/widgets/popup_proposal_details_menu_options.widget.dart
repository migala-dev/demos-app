/*
  DEMOS
  Copyright (C) 2022 Julian Alejandro Ortega Zepeda, Erik Ivanov Domínguez Rivera, Luis Ángel Meza Acosta
  This file is part of DEMOS.

  DEMOS is free software: you can redistribute it and/or modify
  it under the terms of the GNU General Public License as published by
  the Free Software Foundation, either version 3 of the License, or
  (at your option) any later version.

  DEMOS is distributed in the hope that it will be useful,
  but WITHOUT ANY WARRANTY; without even the implied warranty of
  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
  GNU General Public License for more details.

  You should have received a copy of the GNU General Public License
  along with this program.  If not, see <https://www.gnu.org/licenses/>.
*/

import 'package:demos_app/modules/proposals/pages/proposal_details/menu_options/cancel_proposal.menu_option.dart';
import 'package:demos_app/modules/proposals/pages/proposal_details/menu_options/edit_proposal.menu_option.dart';
import 'package:demos_app/shared/interfaces/menu_option.interface.dart';
import 'package:demos_app/widgets/general/popup_menu_options.widget.dart';
import 'package:flutter/material.dart';

class PopupProposalDetailsMenuOptions extends StatelessWidget {
  final List<MenuOption> menuOptions = [
    EditProposalMenuOption(),
    CancelProposalMenuOption(),
  ];

  PopupProposalDetailsMenuOptions({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return PopupMenuOptions(menuOptions: menuOptions);
  }
}

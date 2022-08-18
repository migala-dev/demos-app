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

import 'package:demos_app/modules/spaces/pages/new_space/screens/invitations/models/invitation_contact.model.dart';
import 'package:demos_app/utils/ui/global_colors.util.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'invitation_contact_chip.widget.dart';

class InvitationSearchField extends StatefulWidget {
  final TextEditingController searchTextFieldController;
  final List<InvitationContact> contactsSelected;
  final void Function(InvitationContact) unselectContact;
  final void Function(String) onSearchChange;

  const InvitationSearchField(
      {Key? key,
      required this.contactsSelected,
      required this.unselectContact,
      required this.onSearchChange,
      required this.searchTextFieldController})
      : super(key: key);

  @override
  _InvitationSearchFieldState createState() => _InvitationSearchFieldState();
}

class _InvitationSearchFieldState extends State<InvitationSearchField> {
  FocusNode textNode = FocusNode();

  _InvitationSearchFieldState();

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      child: Container(
        padding: const EdgeInsets.only(left: 10.0, right: 10.0, top: 8.0),
        width: double.infinity,
        decoration: BoxDecoration(
            border: Border(bottom: BorderSide(color: greyColor, width: 1.0))),
        child: Wrap(children: [
          ...widget.contactsSelected
              .map((user) => getContactChip(user))
              .toList(),
          Container(
            margin: const EdgeInsets.only(left: 12.0),
            child: ConstrainedBox(
              constraints:
                  const BoxConstraints(minWidth: 60, maxWidth: double.infinity),
              child: IntrinsicWidth(
                  child: RawKeyboardListener(
                focusNode: textNode,
                onKey: (key) {
                  if (key.logicalKey == LogicalKeyboardKey.backspace &&
                      key.runtimeType.toString() == 'RawKeyDownEvent') {
                    if (widget.contactsSelected.isNotEmpty) {
                      InvitationContact lastContactSelected =
                          widget.contactsSelected.last;
                      widget.unselectContact(lastContactSelected);
                    }
                  }
                },
                child: TextField(
                  style: const TextStyle(
                    fontSize: 16.0,
                  ),
                  controller: widget.searchTextFieldController,
                  decoration: InputDecoration(
                    border: InputBorder.none,
                    hintText: widget.contactsSelected.isEmpty
                        ? 'Añadir personas'
                        : '',
                  ),
                  onChanged: (searchFieldValue) {
                    widget.onSearchChange(searchFieldValue);
                  },
                ),
              )),
            ),
          )
        ]),
      ),
      onTap: () {
        textNode.requestFocus();
      },
    );
  }

  Widget getContactChip(InvitationContact contact) {
    return InvitationContactChip(
      contact: contact,
      unselectContact: () {
        widget.unselectContact(contact);
      },
    );
  }
}

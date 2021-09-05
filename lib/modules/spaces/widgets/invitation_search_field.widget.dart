import 'package:demos_app/modules/spaces/models/invitation_contact.model.dart';
import 'package:demos_app/utils/ui/global_colors.util.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'invitation_contact_chip.widget.dart';

class InvitationSearchField extends StatefulWidget {
  final List<InvitationContact> contactsSelected;
  final void Function(InvitationContact) unselectContact;
  final void Function(String) onSearchChange;

  InvitationSearchField(
      {Key? key,
      required this.contactsSelected,
      required this.unselectContact,
      required this.onSearchChange})
      : super(key: key);

  @override
  _InvitationSearchFieldState createState() => _InvitationSearchFieldState(
      contactsSelected, unselectContact, onSearchChange);
}

class _InvitationSearchFieldState extends State<InvitationSearchField> {
  List<InvitationContact> contactsSelected;
  void Function(InvitationContact) unselectContact;
  void Function(String) onSearchChange;
  FocusNode textNode = FocusNode();

  _InvitationSearchFieldState(
      this.contactsSelected, this.unselectContact, this.onSearchChange);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      child: Container(
        padding: EdgeInsets.only(left: 10.0, right: 10.0, top: 8.0),
        width: double.infinity,
        decoration: BoxDecoration(
            color: Colors.white,
            border: Border(bottom: BorderSide(color: greyColor, width: 1.0))),
        child: Wrap(children: [
          ...contactsSelected.map((user) => getContactChip(user)).toList(),
          Container(
            margin: EdgeInsets.only(left: 12.0),
            child: ConstrainedBox(
              constraints:
                  BoxConstraints(minWidth: 60, maxWidth: double.infinity),
              child: IntrinsicWidth(
                  child: RawKeyboardListener(
                focusNode: textNode,
                onKey: (key) {
                  if (key.logicalKey == LogicalKeyboardKey.backspace &&
                      key.runtimeType.toString() == 'RawKeyDownEvent') {
                    if (contactsSelected.length > 0) {
                      InvitationContact lastContactSelected =
                          contactsSelected.last;
                      unselectContact(lastContactSelected);
                    }
                  }
                },
                child: TextField(
                  style: TextStyle(
                    fontSize: 16.0,
                  ),
                  decoration: new InputDecoration(
                    border: InputBorder.none,
                    hintText:
                        contactsSelected.length == 0 ? 'Añadir personas' : '',
                  ),
                  onChanged: (searchFieldValue) {
                    onSearchChange(searchFieldValue);
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
        unselectContact(contact);
      },
    );
  }
}

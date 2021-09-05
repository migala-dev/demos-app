import 'package:demos_app/modules/spaces/models/invitation_contact.model.dart';
import 'package:demos_app/modules/spaces/services/contacts.service.dart';
import 'package:demos_app/modules/spaces/widgets/invitation_contact_list.widget.dart';
import 'package:demos_app/modules/spaces/widgets/invitation_search_field.widget.dart';
import 'package:flutter/material.dart';

class InvitationsScreen extends StatefulWidget {
  const InvitationsScreen({Key? key}) : super(key: key);

  @override
  _InvitationsScreenState createState() => _InvitationsScreenState();
}

class _InvitationsScreenState extends State<InvitationsScreen> {
  List<InvitationContact> contactsSelected = [];
  List<InvitationContact> contacts = [];
  bool fetchingContacts = true;
  String searchParam = '';

  @override
  void initState() {
    super.initState();
    _fetchContacts();
  }

  Future _fetchContacts() async {
    final phoneContacts = await ContactService.getInvitationContacts();
    setState(() {
      contacts = phoneContacts;
      fetchingContacts = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: appBarTitle(),
      ),
      body: getBody(),
    );
  }

  Column appBarTitle() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('Invitaciones'),
        Text(
          '${contactsSelected.length} seleccionados',
          style: TextStyle(color: Colors.grey, fontSize: 14),
        )
      ],
    );
  }

  Widget getBody() {
    if (fetchingContacts) return Center(child: CircularProgressIndicator());
    if (contacts.length == 0) return Center(child: Text('Sin contactos'));
    return Column(children: [
      InvitationSearchField(
          contactsSelected: contactsSelected,
          onSearchChange: (searchParamValue) {
            setState(() {
              searchParam = searchParamValue;
            });
          },
          unselectContact: (contact) {
            toggleContact(contact);
          }),
      Expanded(
        child: InvitationContactList(
          contactsSelected: contactsSelected,
          contacts: contacts,
          searchParam: searchParam,
          onContactTap: (contact) {
            toggleContact(contact);
          },
        ),
      )
    ]);
  }

  void toggleContact(InvitationContact contact) {
    setState(() {
      if (contactsSelected.contains(contact)) {
        contactsSelected.removeWhere((c) => c == contact);
      } else {
        contactsSelected.add(contact);
      }
    });
  }
}

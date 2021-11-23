import 'package:demos_app/core/models/space.model.dart';
import 'package:demos_app/modules/spaces/pages/new_space/screens/invitations/models/invitation_contact.model.dart';
import 'package:demos_app/modules/spaces/pages/new_space/screens/invitations/services/contacts.service.dart';
import 'package:demos_app/modules/spaces/pages/new_space/screens/invitations/widgets/invitation_contact_list.widget.dart';
import 'package:demos_app/modules/spaces/pages/new_space/screens/invitations/widgets/invitation_search_field.widget.dart';
import 'package:demos_app/modules/spaces/pages/spaces/services/current_space.service.dart';
import 'package:demos_app/modules/spaces/services/member.service.dart';
import 'package:demos_app/modules/spaces/validators/is_current_user_admin.widget_validator.dart';
import 'package:demos_app/utils/mixins/loading_state_handler.mixin.dart';
import 'package:demos_app/utils/ui/toast.util.dart';
import 'package:demos_app/widgets/buttons/big_button_widget.dart';
import 'package:demos_app/widgets/wrappers/safe_widget/safe_widget_validator.dart';
import 'package:flutter/material.dart';

class InvitationsScreen extends StatefulWidget {
  const InvitationsScreen({Key? key}) : super(key: key);

  @override
  _InvitationsScreenState createState() => _InvitationsScreenState();
}

class _InvitationsScreenState extends State<InvitationsScreen>
    with LoadingStateHandler {
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
            unselectContact(contact);
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
      ),
      Container(
        child: SafeWidgetValidator(
            validators: [IsCurrentUserAdminWidgetValidator()],
            child: BigButton(
              text: 'Invitar',
              onPressed: sendInvitations,
              isLoading: isLoading,
            )),
        padding: EdgeInsets.symmetric(horizontal: 12.0),
        margin: EdgeInsets.only(bottom: 12.0),
      )
    ]);
  }

  void toggleContact(InvitationContact contact) {
    if (contactsSelected.contains(contact)) {
      unselectContact(contact);
    } else {
      selectContact(contact);
    }
  }

  void selectContact(InvitationContact contact) {
    setState(() {
      if (!contactsSelected.contains(contact)) {
        contactsSelected.add(contact);
      }
    });
  }

  void unselectContact(InvitationContact contact) {
    setState(() {
      if (contactsSelected.contains(contact)) {
        contactsSelected.removeWhere((c) => c == contact);
      }
    });
  }

  void sendInvitations() {
    wrapLoadingTransaction(() async {
      Space? currentSpace = CurrentSpaceService().getCurrentSpace();
      await MemberService()
          .sendInvitations(currentSpace!.spaceId!, contactsSelected);
      ToastUtil.showSuccess('Invitaciones enviadas con exito!!!');
      Navigator.pop(context);
    });
  }
}

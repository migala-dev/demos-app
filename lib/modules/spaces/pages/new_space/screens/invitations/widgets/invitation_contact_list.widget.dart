import 'package:demos_app/modules/spaces/pages/new_space/screens/invitations/models/invitation_contact.model.dart';
import 'package:demos_app/utils/ui/global_colors.util.dart';
import 'package:demos_app/widgets/profile/profile_picture.widget.dart';
import 'package:flutter/material.dart';

class InvitationContactList extends StatelessWidget {
  final List<InvitationContact> contacts;
  final List<InvitationContact> contactsSelected;
  final String searchParam;
  final void Function(InvitationContact)? onContactTap;

  InvitationContactList(
      {required this.contactsSelected,
      required this.contacts,
      this.searchParam = '',
      this.onContactTap});

  @override
  Widget build(BuildContext context) {
    final contactsFiltered = getContactsFiltered();
    return ListView.builder(
        itemCount: contactsFiltered.length,
        itemBuilder: (BuildContext context, int position) {
          InvitationContact contact = contactsFiltered[position];
          return InkWell(
              onTap: () {
                if (onContactTap != null) {
                  onContactTap!(contact);
                }
              },
              child: Ink(
                color: Colors.white,
                child: ListTile(
                  leading: Stack(
                    children: <Widget>[
                      getAvatar(contact),
                      getCheckCirculeIfUserIsSelected(contact),
                    ],
                  ),
                  title: Text(contact.name),
                  subtitle: Container(
                    padding: EdgeInsets.only(bottom: 8.0, top: 4.0),
                    child: Text(contact.phoneNumber),
                    decoration: BoxDecoration(
                        border: Border(bottom: BorderSide(color: greyColor))),
                  ),
                ),
              ));
        });
  }

  List<InvitationContact> getContactsFiltered() {
    return contacts
        .where((c) =>
            c.name.toLowerCase().indexOf(searchParam.toLowerCase()) != -1)
        .toList();
  }

  Widget getAvatar(InvitationContact user) {
    if (user.profilePictureKey == null) {
      return CircleAvatar(
        backgroundColor: user.color,
        radius: 24.0,
        child: Text(
          getInitials(user.name),
          style: TextStyle(color: Colors.white, fontSize: 22.0),
        ),
      );
    }
    return ProfilePicture(
      imageKey: user.profilePictureKey,
      percentage: 0.12,
    );
  }

  String getInitials(String name) {
    return name[0];
  }

  Widget getCheckCirculeIfUserIsSelected(InvitationContact contact) {
    bool isContactSelected = contactsSelected.contains(contact);
    return Positioned(
        right: 0.0,
        bottom: 0.0,
        child: Container(
            width: 16.0 * (isContactSelected ? 1 : 0),
            height: 16.0 * (isContactSelected ? 1 : 0),
            decoration: BoxDecoration(
                border: Border.all(color: Colors.white),
                borderRadius: BorderRadius.circular(10),
                color: Colors.green),
            child: Center(
              child: Icon(
                Icons.done,
                color: Colors.white,
                size: 14.0,
              ),
            )));
  }
}

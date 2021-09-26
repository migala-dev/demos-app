import 'package:demos_app/modules/spaces/pages/new_space/screens/invitations/models/invitation_contact.model.dart';
import 'package:demos_app/widgets/profile/profile_picture.widget.dart';
import 'package:flutter/material.dart';

class InvitationContactChip extends StatefulWidget {
  final InvitationContact contact;
  final void Function() unselectContact;

  InvitationContactChip(
      {Key? key, required this.contact, required this.unselectContact})
      : super(key: key);

  @override
  _InvitationContactChipState createState() => _InvitationContactChipState();
}

class _InvitationContactChipState extends State<InvitationContactChip> {
  bool unselectMode = false;

  _InvitationContactChipState();

  @override
  Widget build(BuildContext context) {
    Color color = widget.contact.color;
    return GestureDetector(
      child: FittedBox(
          child: Container(
        height: 32.0,
        margin: EdgeInsets.only(right: 4.0, top: 4.0, bottom: 4.0),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            color: !unselectMode ? Colors.grey[200] : color),
        child: Row(
          children: [
            widget.contact.profilePictureKey == null || unselectMode
                ? GestureDetector(
                    child: Container(
                        width: 32.0,
                        height: 32.0,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(20),
                            color: color),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            !unselectMode
                                ? Text(
                                    widget.contact.name[0].toUpperCase(),
                                    style: TextStyle(
                                        color: Colors.white, fontSize: 16.0),
                                  )
                                : Icon(
                                    Icons.close,
                                    color: Colors.white,
                                    size: 22.0,
                                  ),
                          ],
                        )),
                    onTap: () {
                      setState(() {
                        if (unselectMode) {
                          widget.unselectContact();
                        }
                        unselectMode = !unselectMode;
                      });
                    },
                  )
                : ProfilePicture(
                    imageKey: widget.contact.profilePictureKey,
                    width: 95,
                  ),
            Container(
              margin: EdgeInsets.only(left: 4, right: 16),
              child: Text(
                widget.contact.name.split(' ')[0],
                style: TextStyle(
                    color: unselectMode ? Colors.white : Colors.black),
              ),
            )
          ],
        ),
      )),
      onTap: () {
        setState(() {
          unselectMode = !unselectMode;
        });
      },
    );
  }
}

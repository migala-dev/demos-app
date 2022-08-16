import 'dart:io';

import 'package:demos_app/core/enums/invitation-status.enum.dart';
import 'package:demos_app/modules/spaces/models/member_view.model.dart';
import 'package:demos_app/modules/spaces/pages/new_space/screens/members/bloc/space_members_bloc.dart';
import 'package:demos_app/modules/spaces/pages/new_space/screens/members/widgets/members_list_view.widget.dart';
import 'package:demos_app/widgets/buttons/big_button_widget.dart';
import 'package:demos_app/widgets/general/card.widget.dart';
import 'package:demos_app/widgets/titles/entity_title.widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ConfirmProposalScreen extends StatelessWidget {
  final String title;
  final String primaryActionLabel;
  final String? textActionLabel;

  const ConfirmProposalScreen(
      {Key? key,
      required this.title,
      this.primaryActionLabel = 'Publicar',
      this.textActionLabel})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final Color primaryColor = Theme.of(context).primaryColor;
    return BlocBuilder<SpaceMembersBloc, SpaceMembersState>(
        bloc: SpaceMembersBloc(),
        builder: (context, memberListState) {
          List<MemberView> members = [];
          if (memberListState is SpaceMembersWithData) {
            members = memberListState.memberViews
                .where((m) => m.invitationStatus == InvitationStatus.accepted)
                .toList();
          }
          return Scaffold(
            backgroundColor: primaryColor,
            appBar: AppBar(
              actions: [
                IconButton(
                    onPressed: () => Navigator.pop(context),
                    icon: const Icon(Icons.close))
              ],
              leading: Container(),
              elevation: 0,
            ),
            body: Padding(
              padding: EdgeInsets.symmetric(horizontal: 16, vertical: Platform.isIOS ? 32.0 : 16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  EntityTitle(label: 'Propuesta', name: title),
                  const SizedBox(height: 24),
                  Expanded(
                      child: CardWidget(
                    child: Column(children: [
                      Container(
                          padding: const EdgeInsets.only(
                              top: 16.0, left: 16.0, right: 20.0),
                          child: RichText(
                            text: TextSpan(
                              text: 'Al ',
                              style: const TextStyle(
                                  color: Colors.black, fontSize: 18),
                              children: <TextSpan>[
                                TextSpan(
                                  text: textActionLabel ??
                                      primaryActionLabel.toLowerCase(),
                                  style: const TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 18),
                                ),
                                TextSpan(
                                  text:
                                      ' la propuesta solo podrán votar los miembros actuales del espacio (${members.length}):',
                                  style: const TextStyle(fontSize: 18),
                                )
                              ],
                            ),
                          )),
                      Expanded(child: MembersListView(memberViews: members)),
                    ]),
                  )),
                  const SizedBox(height: 24),
                  BigButton(
                      text: primaryActionLabel,
                      onPressed: () {
                        Navigator.pop(context, true);
                      })
                ],
              ),
            ),
          );
        });
  }
}

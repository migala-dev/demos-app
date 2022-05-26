import 'package:demos_app/modules/spaces/models/space_view.model.dart';
import 'package:demos_app/modules/spaces/pages/space_details/bloc/space.bloc.dart';
import 'package:demos_app/widgets/buttons/big_button_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../spaces/pages/new_space/screens/members/bloc/space_members_bloc.dart';
import '../../../../spaces/pages/new_space/screens/members/widgets/members_list_view.widget.dart';

class ConfirmProposalScreen extends StatelessWidget {
  final String title;
  final String primaryActionLabel;

  const ConfirmProposalScreen(
      {Key? key, required this.title, this.primaryActionLabel = 'Publicar'})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    SpaceView space = SpaceBloc().state;
    return BlocBuilder<SpaceMembersBloc, SpaceMembersState>(
        bloc: SpaceMembersBloc(),
        builder: (context, memberListState) {
          return Scaffold(
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
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Propuesta',
                    style: TextStyle(color: Colors.grey),
                  ),
                  Text(
                    title,
                    style: const TextStyle(fontSize: 48),
                  ),
                  const SizedBox(height: 24),
                  RichText(
                    text: TextSpan(
                      text: 'Al ',
                      style: const TextStyle(color: Colors.black, fontSize: 18),
                      children: <TextSpan>[
                        TextSpan(
                          text: primaryActionLabel.toLowerCase(),
                          style: const TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 18),
                        ),
                        TextSpan(
                          text:
                              ' la propuesta solo podrán votar los miembros actuales del espacio (${space.membersCount}):',
                          style: const TextStyle(fontSize: 18),
                        )
                      ],
                    ),
                  ),
                  Expanded(
                    child: getMemberListWidget(memberListState),
                  ),
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

  Widget getMemberListWidget(SpaceMembersState state) {
    if (state is SpaceMembersWithData) {
      final members = state.memberViews;
      
      return MembersListView(memberViews: members);
    }
    return Container();
  }
}

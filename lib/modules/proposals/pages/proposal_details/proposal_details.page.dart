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

import 'package:demos_app/config/routes/application.dart';
import 'package:demos_app/config/routes/routes.dart';
import 'package:demos_app/core/enums/manifesto_option_type.enum.dart';
import 'package:demos_app/core/enums/proposal/proposal_status.enum.dart';
import 'package:demos_app/core/enums/space_role.enum.dart';
import 'package:demos_app/modules/proposals/pages/proposal_details/bloc/proposal_details.bloc.dart';
import 'package:demos_app/modules/proposals/pages/proposal_details/validators/can_vote.widget_validator.dart';
import 'package:demos_app/modules/proposals/pages/proposal_details/widgets/big_outlined_button.dart';
import 'package:demos_app/modules/proposals/pages/proposal_details/widgets/commets_tile.widget.dart';
import 'package:demos_app/modules/proposals/pages/proposal_details/widgets/popup_proposal_details_menu_options.widget.dart';
import 'package:demos_app/modules/proposals/pages/proposal_details/widgets/proposal_result/proposal_result.widget.dart';
import 'package:demos_app/modules/proposals/pages/proposals/models/proposal_view.model.dart';
import 'package:demos_app/modules/proposals/pages/proposals/widgets/proposal_cards/proposal_card_info.widget.dart';
import 'package:demos_app/modules/proposals/services/proposal_participation.service.dart';
import 'package:demos_app/modules/spaces/bloc/current_member/current_member.bloc.dart';
import 'package:demos_app/modules/spaces/widgets/safe_member_validator.widget.dart';
import 'package:demos_app/shared/services/date_formatter.service.dart';
import 'package:demos_app/widgets/general/countdown_timer.widget.dart';
import 'package:demos_app/widgets/general/quill_content.widget.dart';
import 'package:demos_app/widgets/profile/profile_picture.widget.dart';
import 'package:demos_app/widgets/wrappers/safe_widget/safe_widget_validator.dart';
import 'package:fluro/fluro.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ProposalDetailsPage extends StatefulWidget {
  const ProposalDetailsPage({Key? key}) : super(key: key);

  @override
  State<ProposalDetailsPage> createState() => _ProposalDetailsPageState();
}

class _ProposalDetailsPageState extends State<ProposalDetailsPage> {
  final ScrollController _controller = ScrollController();

  bool silverCollapsed = false;

  Widget Function(String title)? getAppBarWidget;

  @override
  void initState() {
    super.initState();
    _controller.addListener(() {
      if (_controller.offset > 100 && !_controller.position.outOfRange) {
        if (!silverCollapsed) {
          setState(() {
            getAppBarWidget = getCollapsedTextWidget;
            silverCollapsed = true;
          });
        }
      }
      if (_controller.offset < 100 && !_controller.position.outOfRange) {
        if (silverCollapsed) {
          setState(() {
            getAppBarWidget = getExpandedTextWidget;
            silverCollapsed = false;
          });
        }
      }
    });
    getAppBarWidget = getExpandedTextWidget;
  }

  @override
  void dispose() {
    super.dispose();

    _controller.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ProposalDetailsBloc, ProposalView?>(
        bloc: ProposalDetailsBloc(),
        builder: (context, proposalView) {
          final Key _countdownKey = UniqueKey();
          if (proposalView == null) {
            return const Center(child: CircularProgressIndicator());
          }
          return Scaffold(
            body: NestedScrollView(
              controller: _controller,
              headerSliverBuilder: (BuildContext context, bool isScroll) {
                return <Widget>[getSliverAppBar(context, proposalView)];
              },
              body: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 10),
                    child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          proposalView.status == ProposalStatus.open
                              ? ProposalCardInfo(
                                  getIcon: (size, color) => Icon(
                                    Icons.calendar_today,
                                    size: size,
                                    color: color,
                                  ),
                                  title: 'TERMINA EN:',
                                  child: CountdownTimer(
                                      key: _countdownKey,
                                      dateTime: proposalView.expiredAt),
                                )
                              : ProposalCardInfo(
                                  getIcon: (size, color) => Icon(
                                    Icons.calendar_today,
                                    size: size,
                                    color: color,
                                  ),
                                  title: 'CERRADA EL:',
                                  content: DateFormatterService
                                      .parseDateToStandardDateFormatWithHour(
                                          proposalView.expiredAt!),
                                ),
                          proposalView.status == ProposalStatus.open
                              ? ProposalCardInfo(
                                  getIcon: (size, color) => Icon(
                                    Icons.how_to_vote,
                                    size: 32,
                                    color: color,
                                  ),
                                  title: 'Votos:',
                                  content:
                                      '${proposalView.votesCount}/${proposalView.votesTotal}',
                                )
                              : Container()
                        ]),
                  ),
                  const Divider(color: Colors.grey),
                  Expanded(
                    child: SingleChildScrollView(
                      physics: const BouncingScrollPhysics(),
                      padding: const EdgeInsets.symmetric(horizontal: 15),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(vertical: 10),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            proposalView.status == ProposalStatus.closed
                                ? ProposalResult(
                                    proposal: proposalView,
                                  )
                                : Container(),
                            getContent(proposalView.content),
                            ListTile(
                              title: const Text(
                                'Autor',
                                style:
                                    TextStyle(color: Colors.grey, fontSize: 14),
                              ),
                              subtitle: Text(
                                proposalView.createdByName,
                                style: const TextStyle(
                                    color: Colors.black, fontSize: 16),
                              ),
                              leading: ProfilePicture(
                                  imageKey:
                                      proposalView.createdByProfilePictureKey,
                                  width: 100),
                            ),
                            ListTile(
                              title: const Text(
                                'Tipo de votación',
                                style:
                                    TextStyle(color: Colors.grey, fontSize: 14),
                              ),
                              subtitle: Text(
                                proposalView.optionType ==
                                        ManifestoOptionType.inFavorOrOpposing
                                    ? 'A favor/En contra'
                                    : 'Opción multiple',
                                style: const TextStyle(
                                    color: Colors.black, fontSize: 16),
                              ),
                              leading: const Icon(Icons.list, size: 40),
                            ),
                            proposalView.optionType ==
                                    ManifestoOptionType.multipleOptions
                                ? ListTile(
                                    title: const Padding(
                                      padding: EdgeInsets.only(bottom: 8),
                                      child: Text(
                                        'OPCIONES',
                                        style: TextStyle(
                                            color: Colors.grey, fontSize: 14),
                                      ),
                                    ),
                                    subtitle: Padding(
                                      padding: const EdgeInsets.only(left: 8),
                                      child: Text(
                                        proposalView.manifestoOptions
                                            .map((e) => '• ${e.title}\n')
                                            .join('')
                                            .toString(),
                                        style: const TextStyle(
                                          color: Colors.black,
                                          fontSize: 16,
                                        ),
                                      ),
                                    ),
                                  )
                                : Container(),
                            const SizedBox(
                              height: 16,
                            ),
                            proposalView.status == ProposalStatus.open
                                ? SafeWidgetValidator(
                                    validators: [CanVoteWidgetValidator()],
                                    child: FutureBuilder(
                                      future:
                                          didCurrentUserParticipatedInProposal(
                                              proposalView),
                                      builder: (BuildContext context,
                                          AsyncSnapshot<bool> snapshot) {
                                        String voteLabel = 'Votar';
                                        final bool
                                            didCurrentMemberParticipatedInProposal =
                                            snapshot.hasData && snapshot.data!;
                                        if (didCurrentMemberParticipatedInProposal) {
                                          voteLabel = 'Actualizar voto';
                                        }

                                        return BigOutlinedButton(
                                            text: voteLabel,
                                            onPressed: () => goToVoteProposal(
                                                context, proposalView));
                                      },
                                    ))
                                : Container()
                          ],
                        ),
                      ),
                    ),
                  ),
                  CommentsTile(
                    numberOfComments: proposalView.numberOfComments,
                    onTap: () => goToProposalComments(context),
                  )
                ],
              ),
            ),
          );
        });
  }

  SliverAppBar getSliverAppBar(
      BuildContext context, ProposalView proposalView) {
    return SliverAppBar(
      actions: proposalView.status == ProposalStatus.open
          ? [
              SafeWidgetMemberValidator(
                  roles: const [SpaceRole.representative, SpaceRole.admin],
                  child: PopupProposalDetailsMenuOptions())
            ]
          : null,
      backgroundColor: const Color(0xFFEFB355),
      expandedHeight: MediaQuery.of(context).size.height * 0.3,
      pinned: true,
      flexibleSpace: LayoutBuilder(
        builder: (BuildContext cont, BoxConstraints constraints) {
          return FlexibleSpaceBar(
            title: getAppBarWidget != null
                ? getAppBarWidget!(proposalView.title ?? 'Sin titulo')
                : Container(),
          );
        },
      ),
    );
  }

  Widget getCollapsedTextWidget(String title) {
    return Text(
      title,
      overflow: TextOverflow.ellipsis,
    );
  }

  Widget getExpandedTextWidget(String title) {
    return Text(
      title,
      maxLines: 5,
      overflow: TextOverflow.ellipsis,
    );
  }

  Widget getContent(String? content) {
    if (content == null || content.isEmpty || content.length == 17) {
      return Container();
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text('Contenido ', style: TextStyle(color: Colors.grey)),
        QuillContent(content: content),
        const SizedBox(
          height: 16,
        ),
      ],
    );
  }

  void goToVoteProposal(BuildContext context, ProposalView proposalView) {
    Application.router.navigateTo(context, Routes.voteProposal,
        routeSettings: RouteSettings(
          arguments: proposalView,
        ));
  }

  void goToProposalComments(BuildContext context) =>
      Application.router.navigateTo(
        context,
        Routes.proposalComments,
        transition: TransitionType.inFromBottom,
      );

  Future<bool> didCurrentUserParticipatedInProposal(
      ProposalView proposalView) async {
    final String currentUserId = CurrentMemberBloc().state!.userId;

    return ProposalParticipationService()
        .didUserParticipatedInProposal(currentUserId, proposalView.proposalId);
  }
}

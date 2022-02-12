import 'package:demos_app/config/routes/application.dart';
import 'package:demos_app/config/routes/routes.dart';
import 'package:demos_app/core/enums/space_role.enum.dart';
import 'package:demos_app/modules/proposals/pages/proposal_details/bloc/proposal_details.bloc.dart';
import 'package:demos_app/modules/proposals/pages/proposal_details/widgets/commets_tile.widget.dart';
import 'package:demos_app/modules/proposals/pages/proposal_details/widgets/popup_proposal_details_menu_options.widget.dart';
import 'package:demos_app/modules/proposals/pages/proposals/models/proposal_view.model.dart';
import 'package:demos_app/modules/proposals/pages/proposals/widgets/proposal_cards/proposal_cart_info.widget.dart';
import 'package:demos_app/modules/spaces/widgets/safe_member_validator.widget.dart';
import 'package:demos_app/widgets/general/quill_content.widget.dart';
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
  Widget build(BuildContext context) {
    return BlocBuilder<ProposalDetailsBloc, ProposalView?>(
        bloc: ProposalDetailsBloc(),
        builder: (context, proposalView) {
          int totalOfMembers = 0;
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
                          ProposalCardInfo(
                            getIcon: (size, color) => Icon(
                              Icons.calendar_today,
                              size: size,
                              color: color,
                            ),
                            title: 'TERMINA EN:',
                            content: '3 HORAS',
                          ),
                          ProposalCardInfo(
                            getIcon: (size, color) => Icon(
                              Icons.how_to_vote,
                              size: 32,
                              color: color,
                            ),
                            title: 'Votos:',
                            content:
                                '${proposalView.votesCount}/$totalOfMembers',
                          )
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
                            const Text('Contenido ',
                                style: TextStyle(color: Colors.grey)),
                            QuillContent(content: proposalView.content),
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
      actions: [
        SafeWidgetMemberValidator(
            roles: const [SpaceRole.representative, SpaceRole.admin],
            child: PopupProposalDetailsMenuOptions())
      ],
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

  void goToProposalComments(BuildContext context) =>
      Application.router.navigateTo(
        context,
        Routes.proposalComments,
        transition: TransitionType.inFromBottom,
      );
}

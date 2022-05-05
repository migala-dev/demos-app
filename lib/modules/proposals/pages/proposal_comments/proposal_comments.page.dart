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
import 'package:demos_app/modules/proposals/pages/proposal_comments/bloc/comment_view_list_bloc.dart';
import 'package:demos_app/modules/proposals/pages/proposal_comments/cubit/comment_reply_cubit.dart';
import 'package:demos_app/modules/proposals/pages/proposal_comments/models/comment_view.model.dart';
import 'package:demos_app/modules/proposals/pages/proposal_comments/widgets/comments_empy_alert.widget.dart';
import 'package:demos_app/modules/proposals/pages/proposal_comments/widgets/input_comment.widget.dart';
import 'package:demos_app/modules/proposals/pages/proposal_comments/widgets/member_comment.widget.dart';
import 'package:demos_app/widgets/buttons/chip_button.widget.dart';
import 'package:fluro/fluro.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ProposalCommentsPage extends StatefulWidget {
  const ProposalCommentsPage({Key? key}) : super(key: key);

  @override
  State<ProposalCommentsPage> createState() => _ProposalCommentsPageState();
}

class _ProposalCommentsPageState extends State<ProposalCommentsPage> {
  final ScrollController _commentListController = ScrollController();
  final double newCommentScrollOffset = 130;

  bool showNewCommentChip = false;

  @override
  void initState() {
    super.initState();
    _commentListController
        .addListener(_handleCommentListControllerPositionEvent);
  }

  @override
  void dispose() {
    _commentListController.dispose();
    super.dispose();
  }

  void _handleCommentListControllerPositionEvent() {
    final outOfRange = _commentListController.position.outOfRange;
    if (outOfRange) {
      hideNewCommentChip();
    }
  }

  void _handleNewCommentEvent(
      BuildContext context, CommentViewListState state) {
    if (_commentListController.hasClients && state is CommentViewListWithData) {
      final outOfRange = _commentListController.position.outOfRange;
      final controllerHasLength =
          _commentListController.position.maxScrollExtent > 0;
      if (!outOfRange && controllerHasLength && state.lastUpdateIsNewComment) {
        showInScreenNewCommentChip();
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Comentarios'),
        leading: IconButton(
            onPressed: () => Navigator.pop(context),
            icon: const Icon(Icons.arrow_back)),
      ),
      body: BlocConsumer<CommentViewListBloc, CommentViewListState>(
        bloc: CommentViewListBloc(),
        listener: _handleNewCommentEvent,
        builder: (context, state) {
          if (state is CommentViewListLoadingInProgress) {
            return const Center(child: CircularProgressIndicator());
          }

          if (state is CommentViewListWithData) {
            final comments = state.commentViews;

            return Column(
              children: [
                Flexible(
                  child: Stack(
                    alignment: AlignmentDirectional.center,
                    children: [
                      ListView.builder(
                        controller: _commentListController,
                        physics: const BouncingScrollPhysics(),
                        itemCount: comments.length,
                        itemBuilder: (context, index) => Padding(
                          padding: const EdgeInsets.symmetric(vertical: 8),
                          child: MemberComment(
                            comment: comments[index],
                            enableReplies: true,
                            onReplied: () => setReply(comments[index]),
                          ),
                        ),
                      ),
                      showNewCommentChip
                          ? Positioned(
                              bottom: 5,
                              child: ChipButton(
                                text: 'Nuevo Comentario ',
                                onDeleted: hideNewCommentChip,
                                onTap: goToOutOfRangeOfList,
                              ))
                          : Container()
                    ],
                  ),
                ),
                const Divider(),
                const InputComment()
              ],
            );
          }

          return Column(
            children: const [
              Expanded(child: CommentsEmptyAlert()),
              InputComment()
            ],
          );
        },
      ),
    );
  }

  void goBack(BuildContext context) => Application.router.navigateTo(
        context,
        Routes.proposalDetails,
        transition: TransitionType.inFromTop,
      );

  void goToOutOfRangeOfList() {
    hideNewCommentChip();
    final scrollOffset = _commentListController.position.maxScrollExtent +
        newCommentScrollOffset;

    _commentListController.animateTo(scrollOffset,
        curve: Curves.linear, duration: const Duration(milliseconds: 500));
  }

  void hideNewCommentChip() => setState(() {
        showNewCommentChip = false;
      });

  void showInScreenNewCommentChip() => setState(() {
        showNewCommentChip = true;
      });

  void setReply(CommentView commentReplied) {
    CommentReplyCubit().setReply(commentReplied);
  }
}

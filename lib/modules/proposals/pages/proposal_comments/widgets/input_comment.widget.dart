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

import 'package:demos_app/modules/proposals/pages/proposal_comments/bloc/comment_view_list_bloc.dart';
import 'package:demos_app/modules/proposals/pages/proposal_comments/cubit/comment_reply_cubit.dart';
import 'package:demos_app/modules/proposals/pages/proposal_comments/services/comment.service.dart';
import 'package:demos_app/modules/proposals/pages/proposal_comments/services/comment_mention_preprocessor.service.dart';
import 'package:demos_app/modules/proposals/pages/proposal_comments/services/comment_view.service.dart';
import 'package:demos_app/modules/proposals/pages/proposal_details/bloc/proposal_details.bloc.dart';
import 'package:demos_app/modules/proposals/pages/proposal_details/bloc/proposal_details_bloc.events.dart';
import 'package:demos_app/modules/proposals/pages/proposals/services/proposal_view.service.dart';
import 'package:demos_app/modules/spaces/models/member_view.model.dart';
import 'package:demos_app/modules/spaces/pages/space_details/bloc/space.bloc.dart';
import 'package:demos_app/utils/hide_keyboard.util.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class InputComment extends StatefulWidget {
  const InputComment({Key? key}) : super(key: key);

  @override
  State<InputComment> createState() => _InputCommentState();
}

class _InputCommentState extends State<InputComment> {
  final TextEditingController _contentController = TextEditingController();
  bool isSendButtonEnabled = false;

  @override
  void initState() {
    super.initState();
    _contentController.addListener(() => setState(() {
          isSendButtonEnabled =
              _contentController.text.replaceAll(' ', '').isNotEmpty;
        }));
  }

  @override
  void dispose() {
    _contentController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 15),
      child: Column(
        children: [
          BlocBuilder<CommentReplyCubit, CommentReplyState>(
            bloc: CommentReplyCubit(),
            builder: (context, state) {
              if (state.isReplying) {
                final MemberView? member = state.commentReplied!.member;
                final content = state.commentReplied!.content;
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Flexible(
                          child: Padding(
                            padding: const EdgeInsets.only(right: 5),
                            child: Text(
                                'Respondiendo a ${member != null ? member.currentMemberName : '[Miembro Eliminado]'}',
                                overflow: TextOverflow.ellipsis,
                                style: const TextStyle(color: Colors.grey)),
                          ),
                        ),
                        IconButton(
                            onPressed: CommentReplyCubit().cancelReply,
                            icon: const Icon(Icons.close))
                      ],
                    ),
                    const SizedBox(height: 5),
                    Padding(
                      padding: const EdgeInsets.only(right: 20),
                      child: Text(
                        CommentMentionPreprocessorService.deleteMentions(
                            content),
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                    const SizedBox(height: 5)
                  ],
                );
              }

              return Container();
            },
          ),
          Row(
            children: [
              Flexible(
                child: TextField(
                  controller: _contentController,
                  decoration:
                      const InputDecoration.collapsed(hintText: 'MENSAJE'),
                ),
              ),
              IconButton(
                  onPressed: isSendButtonEnabled ? addComment : null,
                  icon: const Icon(Icons.send))
            ],
          ),
        ],
      ),
    );
  }

  void addComment() async {
    final isReplying = CommentReplyCubit().state.isReplying;
    if (isReplying) {
      addNewCommentReply();
    } else {
      addNewComment();
    }
  }

  void addNewComment() async {
    final content = _contentController.text;
    final spaceId = SpaceBloc().state.spaceId!;
    final manifestoId = ProposalDetailsBloc().state!.manifestoId;

    clearKeyboardInput();

    final comment =
        await CommentService().createComment(content, spaceId, manifestoId);

    final commentView =
        await CommentViewService().getCommentById(comment.manifestoCommentId);
    final proposalUpdated = await ProposalViewServie()
        .getProposalViewByManifestoId(comment.manifestoId);

    CommentViewListBloc().add(CommentViewListUserCommented(commentView!));
    ProposalDetailsBloc().add(SetProposalViewEvent(proposalUpdated!));
  }

  void addNewCommentReply() async {
    final content = _contentController.text;
    final spaceId = SpaceBloc().state.spaceId!;
    final manifestoId = ProposalDetailsBloc().state!.manifestoId;

    final commentReplyCubit = CommentReplyCubit();
    final manifestoCommentParentId = commentReplyCubit.state.commentParentId!;
    final memberIdReplied =
        commentReplyCubit.state.commentReplied!.member!.memberId!;
    final isReplyingASubComment = commentReplyCubit.state.isReplyingASubComment;

    clearKeyboardInput();
    commentReplyCubit.cancelReply();

    final processedContent = isReplyingASubComment
        ? CommentMentionPreprocessorService.appendMentionAtBeginigOfTheMessage(
            memberIdReplied, content)
        : content;

    final comment = await CommentService().sendCommentReply(
        processedContent, spaceId, manifestoId, manifestoCommentParentId);

    final commentView =
        await CommentViewService().getCommentById(comment.manifestoCommentId);

    CommentViewListBloc().add(
        CommentViewListUserReplied(commentView!, manifestoCommentParentId));
  }

  void clearKeyboardInput() => setState(() {
        _contentController.clear();
        hideKeyboard();
      });
}

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

import 'package:demos_app/modules/proposals/pages/proposal_comments/enums/current_user_commemt_vote.enum.dart';
import 'package:flutter/material.dart';

class CommentVotesCount extends StatelessWidget {
  final int votesInFavor;
  final int votesInOpposing;
  final CurrentUserCommentVote currentUserCommentVote;

  final void Function()? onUpvote;
  final void Function()? onDownvote;

  Color get upvoteColor =>
      currentUserCommentVote == CurrentUserCommentVote.upvote
          ? Colors.green
          : Colors.grey;
  Color get downvoteColor =>
      currentUserCommentVote == CurrentUserCommentVote.downvote
          ? Colors.red
          : Colors.grey;

  const CommentVotesCount(
      {Key? key,
      required this.votesInFavor,
      required this.votesInOpposing,
      required this.currentUserCommentVote,
      this.onUpvote,
      this.onDownvote})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final int votesCount = votesInFavor - votesInOpposing;

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          GestureDetector(
            onTap: onUpvote,
            child: Row(children: [
              Icon(Icons.arrow_upward, size: 15, color: upvoteColor),
              Text(votesCount > 0 ? '$votesCount' : ''),
            ]),
          ),
          const SizedBox(width: 5),
          GestureDetector(
            onTap: onDownvote,
            child: Row(children: [
              Icon(Icons.arrow_downward, size: 15, color: downvoteColor),
              Text(votesCount < 0 ? '${-votesCount}' : '')
            ]),
          ),
        ],
      ),
    );
  }
}

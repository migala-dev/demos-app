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

part of 'comment_reply_cubit.dart';

class CommentReplyState extends Equatable {
  final String? commentParentId;
  final CommentView? commentReplied;

  final bool isReplying;
  final bool isReplyingASubComment;

  const CommentReplyState(
    this.commentReplied, {
    this.commentParentId,
    this.isReplying = false,
    this.isReplyingASubComment = false,
  });

  factory CommentReplyState.empty() => const CommentReplyState(null);

  @override
  List<Object> get props => [
        isReplying,
        commentReplied != null ? commentReplied!.content : '',
        isReplyingASubComment
      ];
}

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

import 'package:demos_app/modules/spaces/models/member_view.model.dart';
import 'package:demos_app/shared/services/date_formatter.service.dart';

class CommentView {
  final String manifestoCommentId;
  final MemberView member;
  final String createdAt;
  final int upVotesCount;
  final int downVotesCount;
  final String content;

  final List<CommentView>? replies;

  String get createdAtFormatted =>
      DateFormatterService.parseToDayMonthYearHourDate(createdAt);

  int get repliesCount => replies == null ? 0 : replies!.length;

  CommentView(
    this.manifestoCommentId,
    this.member,
    this.createdAt,
    this.upVotesCount,
    this.downVotesCount,
    this.content,
    this.replies,
  );

  factory CommentView.fromObjectAndMemberView(
          dynamic o, List<CommentView>? replies, MemberView member) =>
      CommentView(
        o['manifestoCommentId'],
        member,
        o['createdAt'],
        o['upVotesCount'],
        o['downVotesCount'],
        o['content'],
        replies,
      );
}

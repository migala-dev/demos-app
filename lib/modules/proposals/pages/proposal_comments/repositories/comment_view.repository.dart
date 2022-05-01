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

import 'package:demos_app/core/repositories/app_repository.dart';
import 'package:demos_app/core/repositories/manifesto/comment/manifesto_comment.repository.dart';
import 'package:demos_app/core/repositories/manifesto/comment/manifesto_comment_vote.repository.dart';
import 'package:demos_app/modules/proposals/pages/proposal_comments/models/comment_view.model.dart';
import 'package:demos_app/modules/spaces/pages/new_space/screens/members/services/member_view.service.dart';
import 'package:sqflite/sqflite.dart';

class CommentViewRepository extends AppRepository {
  final tblManifestoComment = ManifestoCommentRepository().tblManifestoComment;
  final colManifestoCommentId = ManifestoCommentRepository().colId;
  final colManifestoId = ManifestoCommentRepository().colManifestoId;
  final colManifestoCommentParentId =
      ManifestoCommentRepository().colManifestoCommentParentId;
  final colContent = ManifestoCommentRepository().colContent;
  final colCreatedAt = ManifestoCommentRepository().colCreatedAt;
  final colCreatedByMember = ManifestoCommentRepository().colCreatedByMember;
  final tblManifestoCommentVote =
      ManifestoCommentVoteRepository().tblManifestoCommentVote;
  final colUpvote = ManifestoCommentVoteRepository().colUpvote;

  String _getSelectWithoutRepliesQuery(String manifestoCommentId) => '''
  SELECT $colManifestoCommentId,
          $colContent,
          $colCreatedAt,
          $colCreatedByMember,
          (select count(*) from $tblManifestoCommentVote
            where $colUpvote = 1 and $colManifestoCommentId = '$manifestoCommentId'
          ) as "upVotesCount",
          (select count(*) from $tblManifestoCommentVote
            where $colUpvote = 0 and $colManifestoCommentId = '$manifestoCommentId'
          ) as "downVotesCount"
  ''';

  String _getFindByManifestoCommentIdQuery(String manifestoCommentId) => '''
    ${_getSelectWithoutRepliesQuery(manifestoCommentId)}
      FROM $tblManifestoComment
      WHERE $colManifestoCommentId = '$manifestoCommentId'
  ''';

  String _getRepliesByManifestoCommentIdQuery(String manifestoCommentId) => '''
    ${_getSelectWithoutRepliesQuery(manifestoCommentId)}
      FROM $tblManifestoComment
      WHERE $colManifestoCommentParentId = '$manifestoCommentId'
  ''';

  String _getRepliesIdsQuery(String manifestoCommentId) => '''
    SELECT $colManifestoCommentId FROM $tblManifestoComment
    WHERE $colManifestoCommentParentId = '$manifestoCommentId'
  ''';

  String _getManifestoCommentsIdsByManifestoId(String manifestoId) => '''
    SELECT $colManifestoCommentId FROM $tblManifestoComment
      WHERE $colManifestoId = '$manifestoId' AND 
        ($colManifestoCommentParentId is null OR $colManifestoCommentParentId = '') 
  ''';

  Future<List<CommentView>> findByManifestoId(String manifestoId) async {
    final Database? db = await this.db;
    final List<CommentView> comments = [];
    final commentIdsQuery = _getManifestoCommentsIdsByManifestoId(manifestoId);
    final commentIdsResult = await db!.rawQuery(commentIdsQuery);
    for (final commentResult in commentIdsResult) {
      final manifestoCommentId = '${commentResult['manifestoCommentId']}';
      final comment = await findByManifestoCommentId(manifestoCommentId);
      comments.add(comment!);
    }

    return comments;
  }

  Future<CommentView?> findByManifestoCommentId(
      String manifestoCommentId) async {
    final Database? db = await this.db;
    final commentquery = _getFindByManifestoCommentIdQuery(manifestoCommentId);

    final commentResult = await db!.rawQuery(commentquery);
    if (commentResult.isEmpty) {
      return null;
    }

    final memberId = '${commentResult[0]['createdByMember']}';
    final member = await MemberViewService().getMemberViewByMemberId(memberId);

    final replies = await findRepliesByManifestoCommentId(manifestoCommentId);

    return CommentView.fromObjectAndMemberView(
        commentResult.first, replies, member!);
  }

  Future<List<CommentView>> findRepliesByManifestoCommentId(
      String manifestoCommentId) async {
    final Database? db = await this.db;
    final List<CommentView> comments = [];

    final repliesIdsQuery = _getRepliesIdsQuery(manifestoCommentId);
    final commentIdsResult = await db!.rawQuery(repliesIdsQuery);

    for (final commentResult in commentIdsResult) {
      final manifestoCommentId = '${commentResult['manifestoCommentId']}';
      final comment = await findByManifestoCommentId(manifestoCommentId);
      comments.add(comment!);
    }

    return comments;
  }
}

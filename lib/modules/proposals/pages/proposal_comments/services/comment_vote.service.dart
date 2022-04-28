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

import 'package:demos_app/core/api/comment_vote.api.dart';
import 'package:demos_app/core/models/manifesto/comment/manifesto_comment_vote.model.dart';
import 'package:demos_app/core/models/responses/comment_vote_deleted_response.model.dart';
import 'package:demos_app/core/models/responses/comment_vote_response.model.dart';
import 'package:demos_app/core/repositories/manifesto/comment/manifesto_comment_vote.repository.dart';

class CommentVoteService {
  Future<ManifestoCommentVote> getCommentVote(
      String spaceId, String manifestoCommentVoteId) async {
    final response =
        await CommentVoteApi().getCommentVote(spaceId, manifestoCommentVoteId);

    await _saveCommentVoteResponseOnRepository(response);

    return response.commentVote;
  }

  Future<ManifestoCommentVote> updateCommentVote(
      String spaceId, String manifestoCommentVoteId, bool upvote) async {
    final response = await CommentVoteApi()
        .updateCommentVote(spaceId, manifestoCommentVoteId, upvote);

    await _saveCommentVoteResponseOnRepository(response);

    return response.commentVote;
  }

  Future<String> deleteCommentVote(
      String spaceId, String manifestoCommentVoteId) async {
    final response = await CommentVoteApi()
        .deleteCommentVote(spaceId, manifestoCommentVoteId);

    await _saveCommentVoteDeletedResponseOnRepository(response);

    return response.manifestoCommentVoteId;
  }

  Future<ManifestoCommentVote> voteComment(
      String spaceId, String manifestoCommentId, bool upvote) async {
    final response =
        await CommentVoteApi().voteComment(spaceId, manifestoCommentId, upvote);

    await _saveCommentVoteResponseOnRepository(response);

    return response.commentVote;
  }

  Future<void> _saveCommentVoteResponseOnRepository(
      CommentVoteResponse commentVoteResponse) async {
    await ManifestoCommentVoteRepository()
        .insertOrUpdate(commentVoteResponse.commentVote);
  }

  Future<void> _saveCommentVoteDeletedResponseOnRepository(
      CommentVoteDeletedResponse commentVoteDeletedResponse) async {
    await ManifestoCommentVoteRepository()
        .delete(commentVoteDeletedResponse.manifestoCommentVoteId);
  }
}

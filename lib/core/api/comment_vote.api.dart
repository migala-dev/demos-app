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

import 'package:demos_app/constans/comment_votes.path.dart';
import 'package:demos_app/core/api/api.dart';
import 'package:demos_app/core/models/responses/comment_vote_deleted_response.model.dart';
import 'package:demos_app/core/models/responses/comment_vote_response.model.dart';

class CommentVoteApi {
  Future<CommentVoteResponse> getCommentVote(
      String spaceId, String manifestoCommentVoteId) async {
    final String endpoint = CommentVotesPath()
        .getSpaceManifestoCommentVotePath(spaceId, manifestoCommentVoteId);

    final httpResponse = await Api.get(endpoint, null);
    final response = CommentVoteResponse.fromObject(httpResponse);

    return response;
  }

  Future<CommentVoteResponse> updateCommentVote(
      String spaceId, String manifestoCommentVoteId, bool upvote) async {
    final String endpoint = CommentVotesPath()
        .getSpaceManifestoCommentVotePath(spaceId, manifestoCommentVoteId);

    final body = _getBodyFromUpvote(upvote);

    final httpResponse = await Api.put(endpoint, body, null);
    final response = CommentVoteResponse.fromObject(httpResponse);

    return response;
  }

  Future<CommentVoteDeletedResponse> deleteCommentVote(
      String spaceId, String manifestoCommentVoteId) async {
    final String endpoint = CommentVotesPath()
        .getSpaceManifestoCommentVotePath(spaceId, manifestoCommentVoteId);

    final httpResponse = await Api.delete(endpoint, null);
    final response = CommentVoteDeletedResponse.fromObject(httpResponse);

    return response;
  }

  Future<CommentVoteResponse> voteComment(
      String spaceId, String manifestoCommentId, bool upvote) async {
    final String endpoint =
        CommentVotesPath().getVotePath(spaceId, manifestoCommentId);

    final body = _getBodyFromUpvote(upvote);

    final httpResponse = await Api.post(endpoint, body, null);
    final response = CommentVoteResponse.fromObject(httpResponse);

    return response;
  }

  Map<String, dynamic> _getBodyFromUpvote(bool upvote) => {'upvote': upvote};
}

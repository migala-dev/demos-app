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

import 'package:demos_app/modules/proposals/pages/proposal_comments/models/comment_view.model.dart';
import 'package:demos_app/modules/proposals/pages/proposal_comments/repositories/comment_view.repository.dart';
import 'package:demos_app/modules/proposals/pages/proposal_details/bloc/proposal_details.bloc.dart';

class CommentViewService {
  Future<List<CommentView>> getComments() async {
    final String manifestoId = ProposalDetailsBloc().state!.manifestoId;

    final comments =
        await CommentViewRepository().findByManifestoId(manifestoId);

    return comments;
  }

  Future<CommentView?> getCommentById(String manifestoCommentId) async {
    final comment = await CommentViewRepository()
        .findByManifestoCommentId(manifestoCommentId);

    return comment;
  }
}

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

import 'package:demos_app/core/interfaces/event.handler.interface.dart';
import 'package:demos_app/core/mixins/event_handler_mixin.dart';
import 'package:demos_app/core/models/cache.model.dart';
import 'package:demos_app/modules/proposals/pages/proposal_comments/bloc/comment_view_list_bloc.dart';
import 'package:demos_app/modules/proposals/pages/proposal_comments/services/comment.service.dart';
import 'package:demos_app/modules/proposals/pages/proposal_comments/services/comment_view.service.dart';
import 'package:demos_app/modules/proposals/pages/proposal_details/bloc/proposal_details.bloc.dart';
import 'package:demos_app/modules/proposals/pages/proposal_details/bloc/proposal_details_bloc.events.dart';
import 'package:demos_app/modules/proposals/pages/proposals/services/proposal_view.service.dart';
import 'package:demos_app/modules/spaces/pages/space_details/bloc/space.bloc.dart';

class CommentHandler extends EventHandlerMixin {
  @override
  String get key => 'comments';

  @override
  final List<EventHandler> eventHandlers = [CommentPublishedHandler()];
}

class CommentPublishedHandler implements EventHandler {
  @override
  String get key => 'published';

  @override
  Future<void> handleEvent(Cache dataEvent) async {
    final String spaceId = dataEvent.data!['spaceId'];
    final String manifestoCommentId = dataEvent.data!['manifestoCommentId'];

    final comment =
        await CommentService().getComment(spaceId, manifestoCommentId);

    final currerntSpaceId = SpaceBloc().state.spaceId;
    if (spaceId == currerntSpaceId) {
      final commentView =
          await CommentViewService().getCommentById(comment.manifestoCommentId);
      CommentViewListBloc().add(CommentViewListUserCommented(commentView!));

      final proposalUpdated = await ProposalViewServie()
          .getProposalViewByManifestoId(comment.manifestoId);

      ProposalDetailsBloc().add(SetProposalViewEvent(proposalUpdated!));
    }
  }
}

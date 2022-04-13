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

import 'package:bloc/bloc.dart';
import 'package:demos_app/modules/proposals/pages/proposal_comments/models/comment_view.model.dart';
import 'package:demos_app/modules/proposals/pages/proposal_comments/services/comment_view.service.dart';
import 'package:equatable/equatable.dart';

part 'comment_view_list_event.dart';
part 'comment_view_list_state.dart';

class CommentViewListBloc
    extends Bloc<CommentViewListEvent, CommentViewListState> {
  static final _commentViewListBloc = CommentViewListBloc._internal();
  factory CommentViewListBloc() => _commentViewListBloc;
  CommentViewListBloc._internal() : super(CommentViewListLoadingInProgress()) {
    on<CommentViewListLoaded>(_onListLoaded);
    on<CommentViewListUserCommented>(_onCurrentUserCommeted);
  }

  void _onListLoaded(
      CommentViewListLoaded event, Emitter<CommentViewListState> emit) async {
    emit(CommentViewListLoadingInProgress());

    final commentViews = await CommentViewService().getComments();

    emit(CommentViewListWithData(commentViews));
  }

  void _onCurrentUserCommeted(CommentViewListUserCommented event,
      Emitter<CommentViewListState> emit) async {
    if (state is CommentViewListWithData) {
      emit(CommentViewListWithData(
          [...(state as CommentViewListWithData).commentViews, event.comment]));
      return;
    }

    emit(CommentViewListWithData([event.comment]));
  }
}

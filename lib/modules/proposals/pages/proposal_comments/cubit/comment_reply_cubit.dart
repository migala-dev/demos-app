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
import 'package:equatable/equatable.dart';

part 'comment_reply_state.dart';

class CommentReplyCubit extends Cubit<CommentReplyState> {
  static final _commentReplyCubit = CommentReplyCubit._internal();
  CommentReplyCubit._internal() : super(CommentReplyState.empy());
  factory CommentReplyCubit() => _commentReplyCubit;

  void cancelReply() {
    emit(CommentReplyState.empy());
  }

  void setReply(CommentView comment) {
    emit(CommentReplyState(true, comment));
  }
}

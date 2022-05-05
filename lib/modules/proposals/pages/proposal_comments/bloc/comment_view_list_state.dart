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

part of 'comment_view_list_bloc.dart';

abstract class CommentViewListState extends Equatable {
  const CommentViewListState();

  @override
  List<Object> get props => [];
}

class CommentViewListLoadingInProgress extends CommentViewListState {}

class CommentViewListEmpty extends CommentViewListState {}

class CommentViewListWithData extends CommentViewListState {
  final List<CommentView> commentViews;
  final bool lastUpdateIsNewComment;

  const CommentViewListWithData(this.commentViews,
      {this.lastUpdateIsNewComment = false});

  @override
  List<Object> get props => [commentViews, lastUpdateIsNewComment];
}

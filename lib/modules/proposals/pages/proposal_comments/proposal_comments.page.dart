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

import 'package:demos_app/config/routes/application.dart';
import 'package:demos_app/config/routes/routes.dart';
import 'package:demos_app/modules/proposals/pages/proposal_comments/bloc/comment_view_list_bloc.dart';
import 'package:demos_app/modules/proposals/pages/proposal_comments/widgets/input_comment.widget.dart';
import 'package:demos_app/modules/proposals/pages/proposal_comments/widgets/member_comment.widget.dart';
import 'package:fluro/fluro.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ProposalCommentsPage extends StatelessWidget {
  const ProposalCommentsPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Comentarios'),
        leading: IconButton(
            onPressed: () => Navigator.pop(context),
            icon: const Icon(Icons.arrow_back)),
      ),
      body: BlocBuilder<CommentViewListBloc, CommentViewListState>(
        bloc: CommentViewListBloc(),
        builder: (context, state) {
          if (state is CommentViewListWithData) {
            final comments = state.commentViews;

            return Column(
              children: [
                Flexible(
                  child: ListView.builder(
                    physics: const BouncingScrollPhysics(),
                    itemCount: comments.length,
                    itemBuilder: (context, index) => Padding(
                      padding: const EdgeInsets.symmetric(vertical: 8),
                      child: MemberComment(
                          comment: comments[index], enableReplies: true),
                    ),
                  ),
                ),
                const Divider(),
                const InputComment()
              ],
            );
          }

          return Container();
        },
      ),
    );
  }

  void goBack(BuildContext context) => Application.router.navigateTo(
        context,
        Routes.proposalDetails,
        transition: TransitionType.inFromTop,
      );
}

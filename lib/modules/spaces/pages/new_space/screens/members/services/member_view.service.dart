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
import 'package:demos_app/modules/spaces/models/space_view.model.dart';
import 'package:demos_app/modules/spaces/pages/space_details/bloc/space.bloc.dart';
import 'package:demos_app/modules/spaces/repositories/member_view.repository.dart';

class MemberViewService {
  Future<List<MemberView>> getMemberViews() async {
    await Future.delayed(const Duration(milliseconds: 100));
    final SpaceView currentSpace = SpaceBloc().state;
    if (currentSpace.spaceId != null) {
      final String spaceId = currentSpace.spaceId!;

      List<MemberView> members =
          await MemberViewsRepository().findMembersBySpaceId(spaceId);

      return members;
    }
    return [];
  }

  Future<MemberView?> getMemberViewByMemberId(String memberId) async {
    final memberView = await MemberViewsRepository().findByMemberId(memberId);

    return memberView;
  }

  Future<List<MemberView>> findMembersByDisplayName(String displayName) async {
    final memberViews = await getMemberViews();

    return memberViews.where((member) {
      final memberDisplayName = member.displayName.toLowerCase();
      final displayNameLowerCase = displayName.toLowerCase();

      return memberDisplayName.contains(displayNameLowerCase);
    }).toList();
  }
}

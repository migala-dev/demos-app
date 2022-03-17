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

import 'package:demos_app/core/enums/space_role.enum.dart';
import 'package:demos_app/modules/spaces/models/member_view.model.dart';
import 'package:demos_app/widgets/wrappers/safe_widget/widget_validator.interface.dart';

class MemberHasTheseRolesValidator extends WidgetValidator {
  final MemberView member;
  final List<SpaceRole> roles;

  MemberHasTheseRolesValidator({ required this.member, required this.roles });

  @override
  Future<bool> canActivate() async {
    return roles.any((role) => member.role == role);
  }
}
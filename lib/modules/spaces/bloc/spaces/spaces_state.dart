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

part of 'spaces_bloc.dart';

class SpacesState extends Equatable {
  final List<SpaceView> spaces;
  final List<InvitationView> invitations;
  const SpacesState({required this.spaces, required this.invitations});

  SpacesState copyWith(
          {List<SpaceView>? spaces, List<InvitationView>? invitations}) =>
      SpacesState(
          spaces: spaces ?? this.spaces,
          invitations: invitations ?? this.invitations);

  @override
  List<Object> get props => [spaces, invitations];
}

class LoadingSpaces extends SpacesState {
  LoadingSpaces() : super(invitations: [], spaces: []);
}

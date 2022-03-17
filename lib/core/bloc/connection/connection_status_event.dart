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

part of 'connection_status_bloc.dart';

abstract class ConnectionStatusEvent extends Equatable {
  const ConnectionStatusEvent();

  @override
  List<Object> get props => [];
}

class ConnectionChangeEvent extends ConnectionStatusEvent {
  final ConnectionStatusState newEvent;

  const ConnectionChangeEvent(this.newEvent);

  @override
  List<Object> get props => [newEvent];
}

class ConnectionStartedEvent extends ConnectionStatusEvent {
  final ConnectivityResult initConnectivityResult;

  const ConnectionStartedEvent(this.initConnectivityResult);

  @override
  List<Object> get props => [initConnectivityResult];
}

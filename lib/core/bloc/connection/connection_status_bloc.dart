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
import 'package:equatable/equatable.dart';
import 'package:connectivity/connectivity.dart';

part 'connection_status_event.dart';
part 'connection_status_state.dart';

class ConnectionStatusBloc
    extends Bloc<ConnectionStatusEvent, ConnectionStatusState> {
  static final _connectionBloc = ConnectionStatusBloc._internal();
  factory ConnectionStatusBloc() => _connectionBloc;

  ConnectionStatusBloc._internal() : super(ConnectionStatusState.connecting) {
    on<ConnectionChangeEvent>((event, emit) {
      emit(event.newEvent);
    });

    on<ConnectionStartedEvent>((event, emit) {
      handleConnectivityResult(event.initConnectivityResult);
    });
  }

  void listenStatusConnection() async {
    final subscription = Connectivity().onConnectivityChanged;
    subscription.listen((ConnectivityResult result) {
      handleConnectivityResult(result);
    });
  }

  void handleConnectivityResult(ConnectivityResult result) {
    if (result == ConnectivityResult.none) {
      add(const ConnectionChangeEvent(ConnectionStatusState.unconnected));
    } else {
      add(const ConnectionChangeEvent(ConnectionStatusState.connected));
    }
  }
}

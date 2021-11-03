import 'package:demos_app/core/bloc/connection/connection_status_bloc.dart';

void handleSocketExceptionError() {
  final connectionStatusBloc = ConnectionStatusBloc();
  connectionStatusBloc
      .add(ConnectionChangeEvent(ConnectionStatusState.Unconnected));
}

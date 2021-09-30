import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'connection_status_event.dart';
part 'connection_status_state.dart';

class ConnectionStatusBloc
    extends Bloc<ConnectionStatusEvent, ConnectionStatusState> {
  static final _connectionBloc = ConnectionStatusBloc._internal();
  factory ConnectionStatusBloc() => _connectionBloc;

  ConnectionStatusBloc._internal() : super(ConnectionStatusState.Connected) {
    on<ConnectionChangeEvent>((event, emit) {
      emit(event.newEvent);
    });
  }
}

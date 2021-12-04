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

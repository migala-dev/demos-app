part of 'connection_status_bloc.dart';

abstract class ConnectionStatusEvent extends Equatable {
  const ConnectionStatusEvent();

  @override
  List<Object> get props => [];
}

class ConnectionChangeEvent extends ConnectionStatusEvent {
  final ConnectionStatusState newEvent;

  ConnectionChangeEvent(this.newEvent);

  @override
  List<Object> get props => [this.newEvent];
}
part of 'auth_cubit.dart';

abstract class AuthState extends Equatable {
  final AuthenticationStatus authenticationStatus;

  const AuthState(this.authenticationStatus);

  @override
  List<Object> get props => [authenticationStatus];
}

class AuthInitial extends AuthState {
  AuthInitial(AuthenticationStatus authenticationStatus)
      : super(authenticationStatus);
}

class AuthStatusChanged extends AuthState {
  AuthStatusChanged(AuthenticationStatus authenticationStatus)
      : super(authenticationStatus);
}

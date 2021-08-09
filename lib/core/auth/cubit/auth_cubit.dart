import 'package:bloc/bloc.dart';
import 'package:demos_app/core/enums/authentication_status.enum.dart';
import 'package:equatable/equatable.dart';

import 'package:demos_app/utils/services/token.service.dart';

part 'auth_state.dart';

class AuthCubit extends Cubit<AuthState> {
  AuthCubit() : super(AuthInitial(AuthenticationStatus.unknown));

  checkUserIsAuthenticated() async {
    final userIsAuthenticated = await TokenService().isAuthenticate();

    emit(AuthStatusChanged(userIsAuthenticated));
  }
}

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluro/fluro.dart';

import 'package:demos_app/config/routes/application.dart';
import 'package:demos_app/config/routes/routes.dart';
import 'package:demos_app/config/themes/cubit/theme_cubit.dart';
import 'package:demos_app/core/auth/cubit/auth_cubit.dart';

import 'core/enums/authentication_status.enum.dart';

void main() {
  runApp(MultiBlocProvider(
    providers: [
      BlocProvider(
        create: (_) => ThemeCubit(),
      ),
      BlocProvider(create: (_) => AuthCubit())
    ],
    child: DemosApp(),
  ));
}

class DemosApp extends StatefulWidget {
  @override
  State createState() => DemosAppState();
}

class DemosAppState extends State<DemosApp> {
  final _navigatorKey = GlobalKey<NavigatorState>();
  NavigatorState? get _navigator => _navigatorKey.currentState;

  DemosAppState() {
    final router = FluroRouter();
    Routes.configureRoutes(router);
    Application.router = router;
  }

  @override
  void initState() {
    final authCubit = context.read<AuthCubit>();
    authCubit.checkUserIsAuthenticated();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(
        SystemUiOverlayStyle.dark.copyWith(statusBarColor: Colors.transparent));

    final app = BlocBuilder<ThemeCubit, ThemeData>(
      builder: (context, theme) {
        return MaterialApp(
          navigatorKey: _navigatorKey,
          theme: theme,
          title: 'DemosApp',
          debugShowCheckedModeBanner: false,
          initialRoute: Routes.authLoading,
          onGenerateRoute: Application.router.generator,
          builder: (context, child) {
            return BlocListener<AuthCubit, AuthState>(
              listener: (context, state) {
                switch (state.authenticationStatus) {
                  case AuthenticationStatus.authenticated:
                    _navigator?.pushNamedAndRemoveUntil(
                        Routes.spaces, (route) => false);
                    break;

                  default:
                    _navigator?.pushNamedAndRemoveUntil(
                        Routes.login, (route) => false);
                    break;
                }
              },
              child: child,
            );
          },
        );
      },
    );
    return app;
  }
}

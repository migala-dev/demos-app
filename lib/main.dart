import 'package:demos_app/core/bloc/spaces/spaces_bloc.dart';
import 'package:demos_app/core/services/websocket.service.dart';
import 'package:demos_app/shared/services/user_preferences_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluro/fluro.dart';

import 'package:demos_app/config/routes/application.dart';
import 'package:demos_app/config/routes/routes.dart';
import 'package:demos_app/config/themes/cubit/theme_cubit.dart';

import 'core/services/token.service.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
    statusBarColor: Colors.transparent,
    statusBarIconBrightness: Brightness.dark,
  ));

  final userPrefs = UserPreferencesService();
  final bool userIsAuthenticate = !await TokenService().isAuthenticate();
  await userPrefs.initUserPreferences();

  runApp(MultiBlocProvider(
    providers: [
      BlocProvider(
        create: (_) => ThemeCubit(userPrefs.themeIsDark),
      ),
      BlocProvider(create: (_) => SpacesBloc()),
    ],
    child: DemosApp(
        initialRoute: userIsAuthenticate ? Routes.spaces : Routes.login),
  ));
}

class DemosApp extends StatelessWidget {
  final String initialRoute;

  DemosApp({Key? key, required this.initialRoute}) : super(key: key) {
    final router = FluroRouter();
    Routes.configureRoutes(router, initialRoute);
    Application.router = router;

    final webSocketService = WebSocketService();
    webSocketService.listenToEvents();
  }

  @override
  Widget build(BuildContext context) {
    final app = BlocBuilder<ThemeCubit, ThemeData>(
      builder: (context, theme) {
        return MaterialApp(
          theme: theme,
          title: 'DemosApp',
          debugShowCheckedModeBanner: false,
          onGenerateRoute: Application.router.generator,
        );
      },
    );
    return app;
  }
}

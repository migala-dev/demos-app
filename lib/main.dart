import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluro/fluro.dart';

import 'package:demos_app/core/bloc/connection/connection_status_bloc.dart';
import 'package:demos_app/core/bloc/spaces/spaces_bloc.dart';
import 'package:demos_app/config/themes/cubit/theme_cubit.dart';

import 'package:demos_app/core/models/user.model.dart';
import 'package:demos_app/core/services/cache.service.dart';
import 'package:demos_app/core/services/current_user.service.dart';
import 'package:demos_app/core/services/websocket.service.dart';
import 'package:demos_app/core/services/token.service.dart';

import 'package:demos_app/shared/services/user_preferences_service.dart';
import 'package:demos_app/config/routes/application.dart';
import 'package:demos_app/config/routes/routes.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
    statusBarColor: Colors.transparent,
    statusBarIconBrightness: Brightness.dark,
  ));

  final userPrefs = UserPreferencesService();
  final bool userIsAuthenticate = await TokenService().isAuthenticate();
  await userPrefs.initUserPreferences();

  if (userIsAuthenticate) {
    User? currentUser = await CurrentUserService().getCurrentUser();
    WebSocketService webSocketService = WebSocketService();
    webSocketService.createConnection(currentUser!.userId!);
    await TokenService().refreshTokens();
    CacheService().getCache();
  }

  runApp(MultiBlocProvider(
    providers: [
      BlocProvider(
        create: (_) => ThemeCubit(userPrefs.themeIsDark),
      ),
      BlocProvider(create: (_) {
        final spacesBloc = SpacesBloc();
        spacesBloc.add(LoadInitSpacesEvent());

        return spacesBloc;
      }),
      BlocProvider(
        create: (_) => ConnectionStatusBloc(),
      ),
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

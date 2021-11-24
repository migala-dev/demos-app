import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluro/fluro.dart';
import 'package:connectivity/connectivity.dart';

import 'package:demos_app/app_initializer.dart';
import 'package:demos_app/core/bloc/connection/connection_status_bloc.dart';
import 'package:demos_app/core/bloc/spaces/spaces_bloc.dart';
import 'package:demos_app/core/services/token.service.dart';
import 'package:demos_app/config/themes/cubit/theme_cubit.dart';

import 'package:demos_app/shared/services/user_preferences_service.dart';
import 'package:demos_app/config/routes/application.dart';
import 'package:demos_app/config/routes/routes.dart';
import 'package:demos_app/widgets/general/no_connection_notificator.widget.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
    statusBarColor: Colors.transparent,
    statusBarIconBrightness: Brightness.dark,
  ));

  final connectivityResult = await Connectivity().checkConnectivity();
  ConnectionStatusBloc().add(ConnectionStartedEvent(connectivityResult));
  if (connectivityResult != ConnectivityResult.none) {
    await AppInitializer().initApp();
  }

  final userPrefs = UserPreferencesService();
  await userPrefs.initUserPreferences();

  final connectionStatusBloc = ConnectionStatusBloc();
  connectionStatusBloc.listenStatusConnection();

  final bool userIsAuthenticate = await TokenService().isAuthenticate();

  runApp(MultiBlocProvider(
    providers: [
      BlocProvider(
        create: (_) => ThemeCubit(userPrefs.themeIsDark),
      ),
      BlocProvider(create: (_) {
        final spacesBloc = SpacesBloc();
        spacesBloc.add(LoadSpacesEvent());

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
            builder: (context, child) => Column(
                  children: [
                    Expanded(child: child ?? Container()),
                    NoConnectionNotificator()
                  ],
                ));
      },
    );

    return BlocListener<ConnectionStatusBloc, ConnectionStatusState>(
      listener: (context, state) {
        final appInitializer = AppInitializer();
        if (state == ConnectionStatusState.Connected) {
          appInitializer.initApp();
        } else if (state == ConnectionStatusState.Unconnected) {
          appInitializer.disconnectWebsocket();
        }
      },
      child: app,
    );
  }
}

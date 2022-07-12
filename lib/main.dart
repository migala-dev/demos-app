/*
  DEMOS
  Copyright (C) 2022 Julian Alejandro Ortega Zepeda, Erik Ivanov Domínguez Rivera, Luis Ángel Meza Acosta
  This file is part of DEMOS.

  DEMOS is free software: you can redistribute it and/or modify
  it under the terms of the GNU General Public License as published by
  the Free Software Foundation, either version 3 of the License, or
  (at your option) any later version.

  DEMOS is distributed in the hope that it will be useful,
  but WITHOUT ANY WARRANTY; without even the implied warranty of
  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
  GNU General Public License for more details.

  You should have received a copy of the GNU General Public License
  along with this program.  If not, see <https://www.gnu.org/licenses/>.
*/

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluro/fluro.dart';
import 'package:connectivity/connectivity.dart';

import 'package:demos_app/app_initializer.dart';
import 'package:demos_app/core/services/cache.service.dart';
import 'package:demos_app/core/bloc/connection/connection_status_bloc.dart';
import 'package:demos_app/core/bloc/current_user_bloc/current_user_bloc.dart';
import 'package:demos_app/modules/spaces/bloc/spaces/spaces_bloc.dart';
import 'package:demos_app/core/services/token.service.dart';
import 'package:demos_app/config/themes/cubit/theme_cubit.dart';
import 'package:demos_app/config/themes/cubit/api-pending.cubit.dart';

import 'package:demos_app/shared/services/user_preferences_service.dart';
import 'package:demos_app/config/routes/application.dart';
import 'package:demos_app/config/routes/routes.dart';
import 'package:demos_app/widgets/general/no_connection_notificator.widget.dart';
import 'package:loading_overlay/loading_overlay.dart';
import 'navigation.service.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
    statusBarColor: Colors.transparent,
    statusBarIconBrightness: Brightness.dark,
  ));
  SystemChrome.setPreferredOrientations(
      [DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]);

  CurrentUserBloc().add(CurrentUserLoaded());

  final connectivityResult = await Connectivity().checkConnectivity();
  ConnectionStatusBloc().add(ConnectionStartedEvent(connectivityResult));
  if (connectivityResult != ConnectivityResult.none) {
    await AppInitializer().initApp();
  }

  final userPrefs = UserPreferencesService();
  await userPrefs.initUserPreferences();

  final connectionStatusBloc = ConnectionStatusBloc();
  connectionStatusBloc.listenStatusConnection();

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
      BlocProvider(create: (_) => ApiPendingCubit())
    ],
    child: DemosApp(),
  ));
}

class DemosApp extends StatefulWidget {

  DemosApp({Key? key}) : super(key: key) {
    final router = FluroRouter();
    Routes.configureRoutes(router);
    Application.router = router;
  }

  @override
  State<DemosApp> createState() => _DemosAppState();
}

class _DemosAppState extends State<DemosApp> with WidgetsBindingObserver {

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance?.addObserver(this);
  }

  @override
  void dispose() {
    WidgetsBinding.instance?.removeObserver(this);
    super.dispose();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) async {
    super.didChangeAppLifecycleState(state);
    if (state == AppLifecycleState.resumed) {
      final bool userIsAuthenticate = await TokenService().isAuthenticate();

      if (userIsAuthenticate) {
        await TokenService().refreshTokens();
        CacheService().getCache();
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    // ignore: prefer_function_declarations_over_variables
    final isLoadingWrapper = (Widget child) =>
        BlocBuilder<ApiPendingCubit, bool>(builder: (context, isLoading) {
          return LoadingOverlay(
            child: child,
            isLoading: isLoading,
          );
        });

    final app = BlocBuilder<ThemeCubit, ThemeData>(
      builder: (context, theme) {
        return MaterialApp(
            theme: theme,
            title: 'DemosApp',
            debugShowCheckedModeBanner: false,
            onGenerateRoute: Application.router.generator,
            navigatorKey: NavigationService.navigatorKey,
            builder: (context, child) => Column(
                  children: [
                    Expanded(
                        child: child != null
                            ? isLoadingWrapper(child)
                            : Container()),
                    const NoConnectionNotificator()
                  ],
                ));
      },
    );

    return BlocListener<ConnectionStatusBloc, ConnectionStatusState>(
      listener: (context, state) {
        final appInitializer = AppInitializer();
        if (state == ConnectionStatusState.connected) {
          appInitializer.initApp();
        } else if (state == ConnectionStatusState.unconnected) {
          appInitializer.disconnectWebsocket();
        }
      },
      child: app,
    );
  }
}

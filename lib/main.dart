import 'package:demos_app/utils/services/token.service.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluro/fluro.dart';

import 'package:demos_app/config/routes/application.dart';
import 'package:demos_app/config/routes/routes.dart';
import 'package:demos_app/config/themes/cubit/theme_cubit.dart';

void main() {
  runApp(MultiBlocProvider(
    providers: [
      BlocProvider(
        create: (_) => ThemeCubit(),
      )
    ],
    child: DemosApp(),
  ));
}

class DemosApp extends StatefulWidget {
  @override
  State createState() => DemosAppState();
}

class DemosAppState extends State<DemosApp> {
  DemosAppState() {
    final router = FluroRouter();
    Routes.configureRoutes(router);
    Application.router = router;
    TokenService().refreshTokens();
  }

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(
        SystemUiOverlayStyle.dark.copyWith(statusBarColor: Colors.transparent));

    final app = BlocBuilder<ThemeCubit, ThemeData>(
      builder: (context, theme) {
        return MaterialApp(
          theme: theme,
          title: 'DemosApp',
          debugShowCheckedModeBanner: false,
          initialRoute: Routes.login,
          onGenerateRoute: Application.router.generator,
        );
      },
    );
    return app;
  }
}

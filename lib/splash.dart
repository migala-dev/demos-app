import 'package:demos_app/config/routes/routes.dart';
import 'package:demos_app/core/services/token.service.dart';
import 'package:flutter/material.dart';

class Splash extends StatefulWidget {
  const Splash({Key? key}) : super(key: key);

  @override
  State<Splash> createState() => _SplashState();
}

class _SplashState extends State<Splash> {
  @override
  void initState() {
    super.initState();
    _navigateToInitialRoute();
  }

  void _navigateToInitialRoute() async {
    await Future.delayed(const Duration(seconds: 2));
    final bool userIsAuthenticate = await TokenService().isAuthenticate();
    final String initialRoute =
        userIsAuthenticate ? Routes.spaces : Routes.login;

    Navigator.pushNamedAndRemoveUntil(context, initialRoute, (r) => false);
  }

  @override
  Widget build(BuildContext context) {
    final double width = MediaQuery.of(context).size.width * 0.3;
    return Scaffold(
      body: Center(
          child: Container(
        decoration: const BoxDecoration(
            gradient: LinearGradient(
          begin: Alignment.topRight,
          end: Alignment.bottomLeft,
          colors: [
            Color(0xffFFCC00),
            Color(0xffFF3333),
            Color(0xffFF0099),
          ],
        )),
        child: SizedBox(
            width: double.infinity,
            height: double.infinity,
            child: Column(
              children: [
                Expanded(flex: 1, child: Container()),
                Expanded(
                    flex: 5,
                    child: Image(
                        image:
                            const AssetImage('assets/images/splash-logo.png'),
                        width: width,
                        height: width,
                        fit: BoxFit.contain)),
                const Expanded(
                  flex: 1,
                  child: Center(
                      child: Text(
                    'Powered by Migala.',
                    style: TextStyle(
                        color: Colors.white, fontStyle: FontStyle.italic),
                  )),
                )
              ],
            )),
      )),
    );
  }


}

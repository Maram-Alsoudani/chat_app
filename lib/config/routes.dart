import 'package:flutter/material.dart';

import '../presentation/pages/login_screen.dart';
import '../presentation/pages/register_screen.dart';

class Routes {
  static const String registerScreenRoute = "/register screen";
  static const String loginScreenRoute = "/login screen";
}

class RouteGenerator {
  static Route<dynamic> getRoute(RouteSettings settings) {
    switch (settings.name) {
      case Routes.registerScreenRoute:
        return MaterialPageRoute(builder: (_) => RegisterScreen());
      case Routes.loginScreenRoute:
        return MaterialPageRoute(builder: (_) => LoginScreen());
      default:
        return unDefinedRouteName();
    }
  }

  static Route<dynamic> unDefinedRouteName() {
    return MaterialPageRoute(
        builder: (_) => Scaffold(
              appBar: AppBar(
                title: const Text("No Route Found"),
              ),
              body: Center(
                child: Text("No Route Found"),
              ),
            ));
  }
}
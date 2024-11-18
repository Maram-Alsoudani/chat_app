import 'package:chat_app/domain/entities/room_entity.dart';
import 'package:chat_app/presentation/pages/create_new_room.dart';
import 'package:flutter/material.dart';

import '../presentation/pages/chat_screen.dart';
import '../presentation/pages/home_screen.dart';
import '../presentation/pages/login_screen.dart';
import '../presentation/pages/register_screen.dart';

class Routes {
  static const String registerScreenRoute = "/register screen";
  static const String loginScreenRoute = "/login screen";
  static const String homeScreenRoute = "/home screen";
  static const String createNewRouteScreen = "/create new room";
  static const String chatScreen = "/chat screen";
}

class RouteGenerator {
  static Route<dynamic> getRoute(RouteSettings settings) {
    switch (settings.name) {
      case Routes.registerScreenRoute:
        return MaterialPageRoute(builder: (_) => RegisterScreen());
      case Routes.loginScreenRoute:
        return MaterialPageRoute(builder: (_) => LoginScreen());
      case Routes.homeScreenRoute:
        return MaterialPageRoute(builder: (_) => HomeScreen());
      case Routes.createNewRouteScreen:
        return MaterialPageRoute(builder: (_) => CreateNewRoomScreen());
      case Routes.chatScreen:
        final room =
            settings.arguments as RoomEntity; // Cast the argument to RoomEntity
        return MaterialPageRoute(builder: (_) => ChatScreen(room: room));

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
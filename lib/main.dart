import 'package:chat_app/config/routes.dart';
import 'package:chat_app/config/theming.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    String route = Routes.registerScreenRoute;
    return ScreenUtilInit(
      designSize: const Size(375, 812),
      minTextAdapt: true,
      splitScreenMode: true,
      builder: (context, child) {
        return MaterialApp(
          debugShowCheckedModeBanner: false,
          theme: MyThemeData.themeData,
          onGenerateRoute: RouteGenerator.getRoute,
          initialRoute: route,
        );
      },
    );
  }
}

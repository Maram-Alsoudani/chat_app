import 'package:chat_app/config/routes.dart';
import 'package:chat_app/config/theming.dart';
import 'package:chat_app/presentation/manager/providers/user_provider.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

import 'di/di.dart';
import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  configureDependencies();
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => getIt<UserProvider>()),
      ],
      child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<UserProvider>(
      builder: (context, userProvider, child) {
        // Wait until the initialization is complete
        if (userProvider.isInitializing) {
          return MaterialApp(
            home: Scaffold(
              body: Center(
                  child:
                      CircularProgressIndicator()), // Show loading while initializing
            ),
          );
        }

        // After initialization, decide the route based on user state
        String route = userProvider.firebaseUser == null
            ? Routes.loginScreenRoute
            : Routes.homeScreenRoute;

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
      },
    );
  }
}


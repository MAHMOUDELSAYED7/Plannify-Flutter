import 'package:flutter/material.dart';
import 'package:plannify/core/router/route_manager.dart';
import 'core/router/app_router.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Plannify',
      debugShowCheckedModeBanner: false,
      initialRoute: RouteManager.initialRoute,
      onGenerateRoute: AppRouter.onGenerateRoute,
    );
  }
}

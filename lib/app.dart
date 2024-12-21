import 'package:flutter/material.dart';
import 'package:weather_app/config/route/route.dart';

import 'config/theme/app_theme.dart';

class App extends StatelessWidget {
  final String flavor;

  const App({
    super.key,
    required this.flavor,
});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      title: flavor,
      routerConfig: appRouter,
      debugShowCheckedModeBanner: false,
      theme: AppTheme().getTheme(),
    );
  }

}
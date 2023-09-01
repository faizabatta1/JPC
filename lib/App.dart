import 'package:flutter/material.dart';
import 'package:jpc/presentation/screens/home_screen.dart';
import 'package:jpc/presentation/screens/more_screen.dart';
import 'package:jpc/presentation/screens/products_screen.dart';
import 'package:jpc/presentation/wrappers/auth_status_wrapper.dart';

import 'core/helpers/theme_helper.dart';

class App extends StatefulWidget {
  const App({super.key});

  @override
  State<App> createState() => _AppState();
}

class _AppState extends State<App> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'JPC',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primaryColor: ThemeHelper.primaryColor,
        appBarTheme: AppBarTheme(
          backgroundColor: ThemeHelper.primaryColor
        )
      ),
      home:  AuthStatusWrapper(),
    );
  }
}

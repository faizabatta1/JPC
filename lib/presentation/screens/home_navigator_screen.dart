import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/scheduler.dart';
import 'package:material_dialogs/material_dialogs.dart';
import '../../core/routing/home_router.dart';

class HomeNavigatorScreen extends StatefulWidget {
  const HomeNavigatorScreen({super.key});

  @override
  State<HomeNavigatorScreen> createState() => _HomeNavigatorScreenState();
}

class _HomeNavigatorScreenState extends State<HomeNavigatorScreen> {
  final GlobalKey<NavigatorState> _nestedNavigatorKey = GlobalKey<NavigatorState>();
  bool _showExitSnackbar = false;

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        if (_nestedNavigatorKey.currentState!.canPop()) {
          _nestedNavigatorKey.currentState!.pop();
          return false;
        } else {
          if (_showExitSnackbar) {
            SystemNavigator.pop();
            return true;
          } else {
            _showExitSnackbar = true;
            _showExitSnackbarSnackbar();
            SchedulerBinding.instance!.addPostFrameCallback((timeStamp) {
              Future.delayed(Duration(seconds: 5), () {
                setState(() {
                  _showExitSnackbar = false;
                });
              });
            });
            return false;
          }
        }
      },
      child: Scaffold(
        body: Navigator(
          key: _nestedNavigatorKey,
          onGenerateRoute: HomeRouter.generatedRoute,
        ),
      ),
    );
  }

  void _showExitSnackbarSnackbar() {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: AutoSizeText("Are you sure you want to exit the app"),
        duration: Duration(seconds: 5),
      ),
    );
  }
}

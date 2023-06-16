import 'package:flutter/material.dart';
import 'package:jpc/presentation/widgets/drawer_screen.dart';

class TestScreen extends StatelessWidget {
  static const String testScreen = '/testScreen';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      endDrawer: DrawerScreen(),
      body: Center(
        child: Text('test screen',style: TextStyle(fontSize: 30),),
      ),
    );
  }
}

import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';

class UnknownRouteScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              'assets/unknown_route.png',
              width: 200,
            ),
            SizedBox(height: 16),
            AutoSizeText(
              'Sorry, the requested route was not found.',
              style: TextStyle(fontSize: 18),
              maxLines: 1,
            ),
          ],
        ),
      ),
    );
  }
}
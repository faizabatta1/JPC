import 'package:flutter/material.dart';

class ThemeHelper{

  static Color primaryColor = Color(0xff2a2f3f);
  static Color secondaryColor = Color.fromARGB(255, 44, 62, 121);
  static Color accentColor = Color(0xff6c90aa);
  static Color childMainComponentColor = Color(0xA8792B47);
  static Color scaffoldColor = Color(0xFFCED0CC);
  static ButtonStyle fullSizePrimaryButtonStyle(BuildContext context){
    return ElevatedButton.styleFrom(
        backgroundColor: Theme.of(context).primaryColor,
        minimumSize: const Size(double.infinity, 40),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8),
        ),
        textStyle: buttonTextStyle(context)
    );
  }

  static ButtonStyle fullSizeSecondaryButtonStyle(BuildContext context){
    return ElevatedButton.styleFrom(
        backgroundColor: secondaryColor,
        minimumSize: const Size(double.infinity, 40),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8),
        ),
        textStyle: buttonTextStyle(context)
    );
  }


  static ButtonStyle normalPrimaryButtonStyle(BuildContext context){
    return ElevatedButton.styleFrom(
      backgroundColor: Theme.of(context).primaryColor,
    );
  }

  static TextStyle buttonTextStyle(BuildContext context){
    return const TextStyle(
      color: Colors.white,
      fontSize: 16,
    );
  }

  static TextStyle? headingText(BuildContext context){
    return Theme.of(context).textTheme.headlineLarge;
  }
}
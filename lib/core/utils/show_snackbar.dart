import 'package:flutter/material.dart';

void showSnackbar({
  required BuildContext context,
  required String message
}) async{
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      duration: const Duration(seconds: 3),
      content: Text(message),
      dismissDirection: DismissDirection.horizontal,
    )
  );
}
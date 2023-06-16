import 'dart:convert';
import 'dart:math';

import 'package:firebase_messaging/firebase_messaging.dart';
import "package:http/http.dart" as http;

class CloudMessaging{
  static Future sendPushMessage(String body, String title, String token) async {
    try {
      await http.post(
        Uri.parse('https://fcm.googleapis.com/fcm/send'),
        headers: <String, String>{
          'Content-Type': 'application/json',
          'Authorization':
          'key=AAAAqO6o3_g:APA91bEUJq0Cv9wqLX4Dh2luFmE8QrtvENxShvtzl7hUzdlhk3NwgNbfG-d3-13XvRY3U8zAscLm1hGe1Sr4DCPusUBfcoXM83SoRFWgs4Gh87zBYU8bkhmAACA_hP0T6lxeDH6amuuH',
        },
        body: jsonEncode(
          <String, dynamic>{
            'notification': <String, dynamic>{
              'body': body,
              'title': title,
            },
            "to": token,
            'data':{
              'random':'${Random().nextInt(3000)}'
            }
          },
        ),
      );
      print('done');
    } catch (e) {
      print("error push notification");
    }
  }


  static Future<String?> getToken() async {
    String? mtoken = "";
    await FirebaseMessaging.instance.getToken().then((token) {
      mtoken = token;
    });

    return mtoken;
  }

}
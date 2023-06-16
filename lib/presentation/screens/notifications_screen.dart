import 'package:flutter/material.dart';
import 'package:jpc/presentation/widgets/drawer_screen.dart';

import '../widgets/notification_list.dart';


class NotificationsScreen extends StatefulWidget {
  static const String notificationsScreen = '/notificationsScreen';

  const NotificationsScreen({super.key});

  @override
  _NotificationsScreenState createState() => _NotificationsScreenState();
}

class _NotificationsScreenState extends State<NotificationsScreen> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('الاشعارات'),
      ),
      endDrawer: DrawerScreen(),
      body: NotificationsList(),
    );
  }
}


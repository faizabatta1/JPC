import 'package:flutter/material.dart';
import 'package:jpc/core/helpers/theme_helper.dart';
import 'package:jpc/presentation/screens/about_screen.dart';
import 'package:jpc/presentation/screens/faq_screen.dart';
import 'package:jpc/presentation/screens/terms_and_conditions.dart';

import '../screens/notifications_screen.dart';
import '../screens/profile_screen.dart';
import '../screens/settings_screen.dart';

class DrawerScreen extends StatelessWidget {
  const DrawerScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child:Column(
        children: [
          UserAccountsDrawerHeader(
            decoration: BoxDecoration(
              color: ThemeHelper.primaryColor
            ),
            accountName: Text('John Doe'),
            accountEmail: Text('johndoe@example.com'),
            currentAccountPicture: CircleAvatar(
              backgroundImage: AssetImage('assets/avatar.png'),
            ),
          ),
          Expanded(
            child: Directionality(
              textDirection: TextDirection.rtl,
              child: ListView(
                children: [
                  ListTile(
                    leading: const Icon(Icons.home),
                    title: const Text('الصفحة الرئيسية'),
                    onTap: () {
                      Navigator.pop(context);
                      Navigator.pushReplacementNamed(context, '/');
                      // Navigate to home page
                    },
                  ),
                  ListTile(
                    leading: const Icon(Icons.notifications),
                    title: const Text('الاشعارات'),
                    onTap: () {
                      Navigator.pop(context);
                      Navigator.pushNamed(context, NotificationsScreen.notificationsScreen);
                    },
                  ),
                  ListTile(
                    leading: const Icon(Icons.settings),
                    title: const Text('الاعدادات'),
                    onTap: () {
                      Navigator.pop(context);
                      Navigator.pushNamed(context, SettingsScreen.settingsScreen);
                    },
                  ),
                  ListTile(
                    leading: const Icon(Icons.info),
                    title: const Text('حول التطبيق'),
                    onTap: () {
                      Navigator.pop(context);
                      Navigator.pushNamed(context, AboutScreen.route);
                    },
                  ),
                  ListTile(
                    leading: const Icon(Icons.copyright),
                    title: const Text('الحقوق و الشروط'),
                    onTap: () {
                      Navigator.pop(context);
                      Navigator.pushNamed(context, TermsAndConditionsScreen.route);
                    },
                  ),
                  ListTile(
                    leading: const Icon(Icons.question_answer),
                    title: const Text('الاسئلة المتكررة'),
                    onTap: () {
                      Navigator.pop(context);
                      Navigator.pushNamed(context, FAQScreen.route);
                    },
                  ),
                  const Divider(),
                  ListTile(
                    leading: const Icon(Icons.person),
                    title: const Text('الصفحة الشخصية'),
                    onTap: () {
                      Navigator.pop(context);
                      Navigator.pushNamed(context,ProfileScreen.profile);
                    },
                  ),
                  ListTile(
                    iconColor: Colors.red,
                    textColor: Colors.red,
                    leading: const Icon(Icons.logout),
                    title: const Text('تسجيل الخروج'),
                    onTap: () async{

                    },
                  ),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
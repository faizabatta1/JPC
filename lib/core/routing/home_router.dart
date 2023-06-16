import 'package:flutter/material.dart';
import 'package:jpc/presentation/screens/about_screen.dart';
import 'package:jpc/presentation/screens/faq_screen.dart';
import 'package:jpc/presentation/screens/unknown_route_screen.dart';
import 'package:jpc/presentation/screens/home_screen.dart';

import '../../presentation/screens/notifications_screen.dart';
import '../../presentation/screens/profile_screen.dart';
import '../../presentation/screens/settings_screen.dart';
import '../../presentation/screens/terms_and_conditions.dart';


class HomeRouter{
  static Route<dynamic> generatedRoute(RouteSettings settings){
    switch(settings.name){
      case '/':
        return MaterialPageRoute(builder: (context) => HomeScreen());

      case NotificationsScreen.notificationsScreen:
        return MaterialPageRoute(builder: (context) => NotificationsScreen());

      case SettingsScreen.settingsScreen:
        return MaterialPageRoute(builder: (context) => SettingsScreen());

      case ProfileScreen.profile:
        return MaterialPageRoute(builder: (context) => ProfileScreen());

      case AboutScreen.route:
        return MaterialPageRoute(builder: (context) => AboutScreen());

      case FAQScreen.route:
        return MaterialPageRoute(builder: (context) => FAQScreen());

      case TermsAndConditionsScreen.route:
        return MaterialPageRoute(builder: (context) => TermsAndConditionsScreen());
      default:
        return MaterialPageRoute(builder: (context) => UnknownRouteScreen());
    }
  }
}
import 'package:flutter/material.dart';
import 'package:jpc/presentation/screens/login_screen.dart';
import 'package:jpc/presentation/screens/merchant_login_screen_navigator.dart';
import 'package:jpc/presentation/screens/unknown_route_screen.dart';

import '../../presentation/screens/login_screen_navigator.dart';
import '../../presentation/screens/register_screen.dart';
import '../../presentation/screens/reset_password.dart';


class LoginRouter{
  static Route<dynamic> generatedRoute(RouteSettings settings){
    switch(settings.name){
      case LoginScreenNavigator.login:
        return MaterialPageRoute(builder: (context) => LoginScreen());

      case RegisterScreen.register:
        return PageRouteBuilder(
          pageBuilder: (context,animation,secondaryAnimation) => RegisterScreen(),
          transitionDuration: Duration(milliseconds: 300),
          transitionsBuilder: (context,animation,secondaryAnimation,child){
            return SlideTransition(
              position: animation.drive(Tween(begin: Offset(1.0,0.0),end: Offset.zero).chain(
                CurveTween(curve: Curves.ease)
              )),

              child: child,
            );
          }
        );

      case MerchantLoginScreenNavigator.merchantLogin:
        return PageRouteBuilder(
            pageBuilder: (context,animation,secondaryAnimation) => MerchantLoginScreenNavigator(),
            transitionDuration: Duration(milliseconds: 300),
            transitionsBuilder: (context,animation,secondaryAnimation,child){
              return SlideTransition(
                position: animation.drive(Tween(begin: Offset(1.0,0.0),end: Offset.zero).chain(
                    CurveTween(curve: Curves.ease)
                )),

                child: child,
              );
            }
        );

      case ResetPasswordScreen.reset:
        return PageRouteBuilder(
            pageBuilder: (context,animation,secondaryAnimation) => ResetPasswordScreen(),
            transitionDuration: Duration(milliseconds: 300),
            transitionsBuilder: (context,animation,secondaryAnimation,child){
              return SlideTransition(
                position: animation.drive(Tween(begin: Offset(1.0,0.0),end: Offset.zero).chain(
                    CurveTween(curve: Curves.easeIn)
                )),

                child: child,
              );
            }
        );

      default:
        return MaterialPageRoute(builder: (context) => UnknownRouteScreen());
    }
  }
}
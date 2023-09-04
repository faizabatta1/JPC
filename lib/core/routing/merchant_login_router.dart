import 'package:flutter/material.dart';
import 'package:jpc/presentation/screens/merchant_register_screen.dart';

import '../../presentation/screens/merchant_login_screen.dart';
import '../../presentation/screens/merchant_login_screen_navigator.dart';

class MerchantLoginRouter{
  static Route<dynamic> generatedRoute(RouteSettings settings){
    switch(settings.name){
      case MerchantLoginScreenNavigator.merchantLogin:
        return MaterialPageRoute(builder: (context) => MerchantLoginScreen());

      case MerchantRegisterScreen.register:
      return MaterialPageRoute(builder: (context) => MerchantRegisterScreen());


      default:
        return MaterialPageRoute(builder: (context) => Container());
    }
  }
}
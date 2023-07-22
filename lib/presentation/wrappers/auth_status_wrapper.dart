import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:jpc/presentation/blocs/auth_status/auth_status_bloc.dart';
import 'package:jpc/presentation/screens/home_navigator_screen.dart';
import 'package:jpc/presentation/screens/login_screen_navigator.dart';

import '../screens/splash_screen.dart';

class AuthStatusWrapper extends StatefulWidget {
  const AuthStatusWrapper({Key? key}) : super(key: key);

  @override
  State<AuthStatusWrapper> createState() => _AuthStatusWrapperState();
}

class _AuthStatusWrapperState extends State<AuthStatusWrapper>{
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocBuilder<AuthStatusBloc,AuthStatusState>(
        builder: (context,state){
          if(state is UserLoggedInState){
            return const HomeNavigatorScreen();
          }
          else if(state is UserNotLoggedInState){
            return const LoginScreenNavigator();
          }else if(state is AuthStatusInitial){
            return const SplashScreen();
          }else{
            return Container(
              alignment: Alignment.center,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const CircularProgressIndicator(),
                  const SizedBox(height: 20,),
                  const Text('Loading',style: TextStyle(fontSize: 30),)
                ],
              ),
            );
          }
        },
      ),
    );
  }
}

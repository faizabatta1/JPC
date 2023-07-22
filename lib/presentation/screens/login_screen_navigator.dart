import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:jpc/core/utils/show_snackbar.dart';
import 'package:jpc/presentation/blocs/auth_status/auth_status_bloc.dart';
import 'package:jpc/presentation/blocs/login_bloc/login_bloc.dart';
import 'package:jpc/presentation/blocs/register_bloc/register_bloc.dart';
import 'package:jpc/presentation/screens/register_screen.dart';

import '../../core/routing/login_router.dart';


class LoginScreenNavigator extends StatefulWidget {
  static const String login = '/';
  const LoginScreenNavigator({super.key});

  @override
  State<LoginScreenNavigator> createState() => _LoginScreenNavigatorState();
}

class _LoginScreenNavigatorState extends State<LoginScreenNavigator> {

  final GlobalKey<NavigatorState> _nestedNavigatorKey = GlobalKey<NavigatorState>();

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => LoginBloc()..add(ResetLoginInitial()),
      child: WillPopScope(
        onWillPop: () async{

          if (_nestedNavigatorKey.currentState!.canPop()) {
            _nestedNavigatorKey.currentState!.pop();
            return false;
          } else {
            bool willPopup = await showDialog(
                context: context,
                builder: (context){
                  return AlertDialog(
                      content: AutoSizeText("are you sure you want to exit the app ?"),
                      actions: [
                        OutlinedButton(
                          onPressed: () {
                            Navigator.pop(context,false);
                          },
                          child: Text('Cancel',style: TextStyle(color: Colors.grey),),
                        ),
                        ElevatedButton(
                          style: ButtonStyle(
                            backgroundColor: MaterialStatePropertyAll(Colors.red),
                          ),
                          onPressed: () {
                            Navigator.pop(context,true);
                          },
                          child: Text('exit',style: TextStyle(color: Colors.white),),
                        ),
                      ]);
                }
            );

            if(willPopup){
              if(Navigator.canPop(context)){
                return true;
              }else{
                SystemNavigator.pop();
                return false;
              }
            }else{
              return false;
            }
          }
        },
        child: BlocConsumer<LoginBloc,LoginState>(
          listener: (context,state){
            if(state is UserNotFound){
              showSnackbar(context: context, message: "User Not Found");
            }else if(state is WrongCredentials){
              showSnackbar(context: context, message: "Wrong Credentials");
            }else if(state is LoginSuccess){
              showSnackbar(context: context, message: "Logged in Successfully");
              AuthStatusBloc.sink.add(AuthUserActiveEvent());
            }
          },

          builder: (context,state){
            if(state is LoginLoading){
              return const Center(
                child: CircularProgressIndicator(),
              );
            } else if(state is UnknownState){
              return Center(
                child: Column(
                  children: const [
                    CircularProgressIndicator(),
                    Text('something unknown in login')
                  ],
                ),
              );
            }

            return Navigator(
              key: _nestedNavigatorKey,
              onGenerateRoute: LoginRouter.generatedRoute,
              initialRoute: '/',
            );
          },
        ),
      ),
    );
  }
}
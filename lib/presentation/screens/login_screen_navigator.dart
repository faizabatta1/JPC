import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:jpc/core/utils/show_snackbar.dart';
import 'package:jpc/presentation/blocs/login_bloc/login_bloc.dart';

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
    return SafeArea(
      child: BlocProvider(
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
          child: Scaffold(
            body: BlocConsumer<LoginBloc,LoginState>(
              listener: (context,state){
                if(state is LoginFailure){
                  showSnackbar(context: context, message: state.message);
                }
              },

              builder: (context,state){
                if(state is LoginLoading){
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                }
                else if(state is LoginInitial){
                  return Navigator(
                    key: _nestedNavigatorKey,
                    onGenerateRoute: LoginRouter.generatedRoute,
                    initialRoute: '/',
                  );
                }
                else if(state is LoginSuccess){
                  return Container();
                }else{
                  return Center(
                    child: Column(
                      children: const [
                        CircularProgressIndicator(),
                        Text('something unknown in login')
                      ],
                    ),
                  );
                }
              },
            ),
          ),
        ),
      ),
    );
  }
}
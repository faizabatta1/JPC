import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:material_dialogs/material_dialogs.dart';
import '../../core/routing/home_router.dart';

class HomeNavigatorScreen extends StatefulWidget{
  const HomeNavigatorScreen({super.key});

  @override
  State<HomeNavigatorScreen> createState() => _HomeNavigatorScreenState();
}

class _HomeNavigatorScreenState extends State<HomeNavigatorScreen> {
  final GlobalKey<NavigatorState> _nestedNavigatorKey = GlobalKey<NavigatorState>();


  @override
  Widget build(BuildContext context) {
    return SafeArea(
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
          body: Navigator(
            key: _nestedNavigatorKey,
            onGenerateRoute: HomeRouter.generatedRoute,
          ),
        ),
      ),
    );
  }
}

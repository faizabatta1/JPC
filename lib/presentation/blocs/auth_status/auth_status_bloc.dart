import 'dart:async';
import 'dart:math';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:jpc/data/datasource/remote/users_data/firestore_users_remote_data_source.dart';
import 'package:jpc/data/models/user_information.dart';
import 'package:shared_preferences/shared_preferences.dart';

part 'auth_status_event.dart';
part 'auth_status_state.dart';

class AuthStatusBloc extends Bloc<AuthStatusEvent, AuthStatusState> {
  static final _controller = StreamController<AuthStatusEvent>.broadcast();
  static Stream<AuthStatusEvent> get streamChannel => _controller.stream;
  static StreamSink<AuthStatusEvent> get sink => _controller.sink;


  @override
  Future<void> close() {
    sink.close();
    _controller.close();
    return super.close();
  }

  AuthStatusBloc() : super(AuthStatusInitial()){

    Future.delayed(const Duration(seconds: 4)).whenComplete(() async{
      final SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
      final String? token = sharedPreferences.getString('token');

      if(token != null){
        print('authed');
        add(AuthUserActiveEvent());
      }else{
        add(AuthUserNotActiveEvent());
        print('not authed');
      }

      streamChannel.listen((event) {
        add(event);
      });

    });
    on<AuthStatusEvent>((event, emit) async{
      if(event is AuthUserActiveEvent){
        emit(UserLoggedInState());

      }else if(event is AuthUserNotActiveEvent){
        emit(UserNotLoggedInState());
      }else if(event is SignOutEvent){
        final SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
        await sharedPreferences.remove('token');
        sink.add(AuthUserNotActiveEvent());
      }
    });
  }
}

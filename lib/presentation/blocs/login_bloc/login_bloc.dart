import 'dart:async';
import 'package:dartz/dartz.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:jpc/core/error_handling/user_login_error.dart';
import 'package:jpc/data/entities/user_auth_credentials.dart';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:jpc/data/repositories/user_authentication_repository_impl.dart';
import 'package:jpc/domain/usecase/login_case.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../core/constants/login_status.dart';

part 'login_event.dart';
part 'login_state.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  final UserAuthenticationRepositoryImpl userAuthenticationRepositoryImpl = UserAuthenticationRepositoryImpl();
  LoginBloc() : super(LoginInitial()) {
    on<LoginEvent>((event, emit) async{
      if(event is LoginButtonPressed){
        emit(LoginLoading());
        final LoginUseCase loginUseCase = LoginUseCase(
            userAuthenticationRepositoryImpl: userAuthenticationRepositoryImpl,
            userAuthCredentials: event.userAuthCredentials
        );

        Either<UserLoginError,({ bool state, LoginStatus loginStatus })> response = await loginUseCase.execute();

        response.fold(
          (userLoginError){
            emit(LoginFailure(message: userLoginError.message));
            emit(LoginInitial());
          },
          (response) async{
            // final SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
            switch(response.loginStatus){

              case LoginStatus.success:
                return emit(LoginSuccess());
              case LoginStatus.notFound:
                return emit(UserNotFound());
              case LoginStatus.wrongCredentials:
                return emit(WrongCredentials());
              case LoginStatus.serverError:
                return emit(ServerError());
              case LoginStatus.unknown:
                return emit(UnknownState());
      }
          }
        );



      }else if(event is ResetLoginInitial){
        emit(LoginInitial());
      }
    });
  }
}

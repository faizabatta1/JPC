import 'dart:async';
import 'package:dartz/dartz.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:jpc/core/error_handling/user_login_error.dart';
import 'package:jpc/data/entities/user_auth_credentials.dart';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:jpc/data/repositories/user_authentication_repository_impl.dart';
import 'package:jpc/domain/usecase/firebase_login_case.dart';

part 'login_event.dart';
part 'login_state.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  final UserAuthenticationRepositoryImpl firebaseLoginRepositoryImpl = UserAuthenticationRepositoryImpl();
  LoginBloc() : super(LoginInitial()) {
    on<LoginEvent>((event, emit) async{
      if(event is LoginButtonPressed){
        emit(LoginLoading());
        final FirebaseLoginUseCase firebaseLoginUseCase = FirebaseLoginUseCase(
            firebaseLoginRepositoryImpl: firebaseLoginRepositoryImpl,
            userAuthCredentials: event.userAuthCredentials
        );

        Either<UserLoginError,UserCredential> response = await firebaseLoginUseCase.execute();

        response.fold(
          (userLoginError){
            emit(LoginFailure(message: userLoginError.message));
            emit(LoginInitial());
          },
          (credentials){
            emit(LoginSuccess());
          }
        );



      }else if(event is ResetLoginInitial){
        emit(LoginInitial());
      }
    });
  }
}

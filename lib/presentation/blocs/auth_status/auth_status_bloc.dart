import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:jpc/data/datasource/remote/users_data/firestore_users_remote_data_source.dart';
import 'package:jpc/data/models/user_information.dart';

part 'auth_status_event.dart';
part 'auth_status_state.dart';

class AuthStatusBloc extends Bloc<AuthStatusEvent, AuthStatusState> {
  FirebaseAuth firebaseAuth = FirebaseAuth.instance;
  UserInformation? userInformation;
  String? uid;

  AuthStatusBloc() : super(AuthStatusInitial()){
    Future.delayed(const Duration(seconds: 4)).whenComplete((){
      firebaseAuth.authStateChanges().listen((user) {
        if(user != null){
          uid = user.uid;
          add(AuthUserActiveEvent(uid: user.uid));
        }else{
          add(AuthUserNotActiveEvent());
          uid = null;
        }
      });
    });

    on<AuthStatusEvent>((event, emit) async{
      if(event is AuthUserActiveEvent){
        FirestoreUsersRemoteDataSource firestoreUsersRemoteDataSource = FirestoreUsersRemoteDataSource();
        userInformation = await firestoreUsersRemoteDataSource.getUserInformation(uid!);
        emit(UserLoggedInState());
        // if(!firebaseAuth.currentUser!.emailVerified){
        //   emit(UserEmailNotVerifiedState());
        // }else{
        //   FirestoreUsersRemoteDataSource firestoreUsersRemoteDataSource = FirestoreUsersRemoteDataSource();
        //   userInformation = await firestoreUsersRemoteDataSource.getUser(uid!);
        //   emit(UserLoggedInState());
        // }
      }else if(event is AuthUserNotActiveEvent){
        emit(UserNotLoggedInState());
        print('recieved');
      }

      // else if(event is SendVerificationCodeEvent){
      //   await firebaseAuth.currentUser!.sendEmailVerification().whenComplete((){
      //     emit(VerificationLinkSentSuccessfully());
      //   }).catchError((onError){
      //     emit(VerificationLinkFailedToSend());
      //   });
      // }else if(event is EmailVerifiedEvent){
      //   if(firebaseAuth.currentUser!.emailVerified){
      //     emit(UserLoggedInState());
      //   }else{
      //     emit(VerificationLinkSentSuccessfully());
      //   }
      // }
    });
  }
}

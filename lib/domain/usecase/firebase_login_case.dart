import 'package:dartz/dartz.dart';

import '../../core/use_case/use_case.dart';
import 'package:jpc/core/error_handling/user_login_error.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../../core/use_case/use_case_params.dart';
import '../../data/entities/user_auth_credentials.dart';
import '../../data/repositories/user_authentication_repository_impl.dart';



class FirebaseLoginUseCase implements UseCase<UserLoginError,UserCredential>{
  final UserAuthenticationRepositoryImpl firebaseLoginRepositoryImpl;
  final UserAuthCredentials userAuthCredentials;

  FirebaseLoginUseCase({
    required this.firebaseLoginRepositoryImpl,
    required this.userAuthCredentials
  });

  @override
  Future<Either<UserLoginError, UserCredential>> execute() async{
    try{
      UserCredential userCredential = (await firebaseLoginRepositoryImpl.loginWithEmailAndPassword(userAuthCredentials))!;
      return Right(userCredential);
    }on FirebaseAuthException catch(error){
      return Left(UserLoginError(error.message!));
    }
  }
}
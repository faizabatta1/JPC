import 'package:dartz/dartz.dart';
import 'package:jpc/core/constants/login_status.dart';

import '../../core/use_case/use_case.dart';
import 'package:jpc/core/error_handling/user_login_error.dart';
import '../../core/use_case/use_case_params.dart';
import '../../data/entities/user_auth_credentials.dart';
import '../../data/repositories/user_authentication_repository_impl.dart';



class LoginUseCase implements UseCase<UserLoginError,({ bool state, LoginStatus loginStatus, Map? data })>{
  final UserAuthenticationRepositoryImpl userAuthenticationRepositoryImpl;
  final UserAuthCredentials userAuthCredentials;

  LoginUseCase({
    required this.userAuthenticationRepositoryImpl,
    required this.userAuthCredentials
  });

  @override
  Future<Either<UserLoginError, ({ bool state, LoginStatus loginStatus, Map? data })>> execute() async{
    try{
      ({ bool state, LoginStatus loginStatus, Map? data }) response = await userAuthenticationRepositoryImpl.loginWithEmailAndPassword(userAuthCredentials);
      return Right(response);
    }catch(error){
      return Left(UserLoginError(error.toString()!));
    }
  }
}
import 'package:dartz/dartz.dart';
import 'package:jpc/core/error_handling/user_register_error.dart';
import 'package:jpc/data/entities/user_auth_credentials.dart';
import 'package:jpc/data/models/user_information.dart';
import 'package:jpc/data/repositories/user_authentication_repository_impl.dart';

import '../../core/use_case/use_case.dart';

class RegisterUseCase implements UseCase<UserRegisterError,String>{
  final UserAuthenticationRepositoryImpl userAuthenticationRepositoryImpl;
  final UserInformation userInformation;

  RegisterUseCase({
    required this.userAuthenticationRepositoryImpl,
    required this.userInformation
  });

  @override
  Future<Either<UserRegisterError,String>> execute() async{
    try{
      ({ bool state, String message}) response = await userAuthenticationRepositoryImpl.registerUser(userInformation);
      if(response.state){
        return Right(response.message);
      }else{
        return Left(UserRegisterError(response.message.toString()));
      }
    } catch(error){
      return Left(UserRegisterError(error.toString()));
    }
  }
}
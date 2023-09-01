import 'dart:convert';

import 'package:jpc/data/entities/user_auth_credentials.dart';
import 'package:jpc/data/entities/user_register_entity.dart';
import 'package:jpc/domain/repositories/user_authentication_repository.dart';
import 'package:http/http.dart' as http;

import '../../core/constants/app_constants.dart';
import '../../core/constants/login_status.dart';
import '../../core/utils/build_headers.dart';
import '../models/user_information.dart';


class UserAuthenticationRepositoryImpl implements UserAuthenticationRepository{

  @override
  Future<({ bool state, LoginStatus loginStatus, Map? data })> loginWithEmailAndPassword(UserAuthCredentials user) async {
    try{
      final Uri uri = Uri.parse('$baseUrl/users/login');

      http.Response response = await http.post(
        uri,
        headers: {
          'Content-Type': 'application/json; charset=utf-8'
        },
        body: user.toJsonEncoded()
      );

      if(response.statusCode == 200){
        return (state: true,loginStatus: LoginStatus.success,data: jsonDecode(response.body) as Map);
      } else if(response.statusCode == 404){
        return (state: false,loginStatus: LoginStatus.notFound, data:null);
      }else if(response.statusCode == 400){
        return (state: false,loginStatus: LoginStatus.wrongCredentials, data:null);
      }else if(response.statusCode == 500){
        return (state: false,loginStatus: LoginStatus.serverError,data:null);
      }



      return (state: false,loginStatus: LoginStatus.unknown,data:null);
    } catch(loginError){
      rethrow;
    }
  }

  @override
  Future<({ bool state, String message })> registerUser(UserInformation userInformation) async{
    try{
      final Uri uri = Uri.parse('$baseUrl/users');
      http.Response response = await http.post(
          uri,
          headers: BuildHeaders().makeJson().finish(),
          body: userInformation.toJsonEncoded()
      );

      if(response.statusCode == 200){
        return (state: true, message: "User was added successfully");
      }else if(response.statusCode == 400){
        return (state: false, message: response.body);
      }else{
        return (state: false, message: "Unknown Status Code");
      }
    } catch(registerError){
      rethrow;
    }
  }

  @override
  Future<void> userSignOut() {
    // TODO: implement userSignOut
    throw UnimplementedError();
  }
}
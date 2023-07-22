import 'dart:convert';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:jpc/data/entities/user_auth_credentials.dart';
import 'package:jpc/data/entities/user_register_entity.dart';
import 'package:jpc/domain/repositories/user_authentication_repository.dart';
import 'package:http/http.dart' as http;

import '../../core/constants/login_status.dart';


class UserAuthenticationRepositoryImpl implements UserAuthenticationRepository{
  FirebaseAuth firebaseAuth = FirebaseAuth.instance;


  @override
  Future<({ bool state, LoginStatus loginStatus })> loginWithEmailAndPassword(UserAuthCredentials user) async {
    try{
      Uri? uri = Uri.parse('http://10.0.2.2:8080/api/users/login');

      http.Response response = await http.post(
        uri,
        headers: {
          'Content-Type': 'application/json; charset=utf-8'
        },
        body: user.toJsonEncoded()
      );

      if(response.statusCode == 200){
        return (state: true,loginStatus: LoginStatus.success);
      } else if(response.statusCode == 404){
        return (state: true,loginStatus: LoginStatus.notFound);
      }else if(response.statusCode == 400){
        return (state: true,loginStatus: LoginStatus.wrongCredentials);
      }else if(response.statusCode == 500){
        return (state: true,loginStatus: LoginStatus.serverError);
      }



      return (state: true,loginStatus: LoginStatus.unknown);
    } catch(loginError){
      rethrow;
    }
  }

  @override
  Future<UserCredential> registerWithEmailAndPassword(UserAuthCredentials userAuthCredentials) async{
    try{
      return await firebaseAuth.createUserWithEmailAndPassword(
          email: userAuthCredentials.email,
          password: userAuthCredentials.password
      );
    }on FirebaseAuthException catch(registerError){
      rethrow;
    }
  }

  @override
  Future<void> userSignOut() {
    // TODO: implement userSignOut
    throw UnimplementedError();
  }
}
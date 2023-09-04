import 'dart:convert';

import 'package:jpc/data/entities/merchant_auth_credentials.dart';

import 'package:jpc/data/models/merchant.dart';

import '../../core/constants/app_constants.dart';
import '../../core/constants/login_status.dart';
import '../../core/utils/build_headers.dart';
import '../../domain/repositories/merchant_authentication_repository.dart';
import 'package:http/http.dart' as http;

class MerchantAuthenticationRepositoryImpl implements MerchantAuthenticationRepository{
  @override
  Future<({ bool state, LoginStatus loginStatus, Map? data })> loginWithEmailAndPassword(MerchantAuthCredentials merchantAuthCredentials) async {
    try{
      final Uri uri = Uri.parse('$baseUrl/merchants/login');

      http.Response response = await http.post(
          uri,
          headers: {
            'Content-Type': 'application/json; charset=utf-8'
          },
          body: merchantAuthCredentials.toJsonEncoded()
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
  Future<void> merchantSignOut() async {

  }

  @override
  Future<({ bool state, String message })> registerMerchant(Merchant merchant) async {
    try{
      final Uri uri = Uri.parse('$baseUrl/merchants');
      http.Response response = await http.post(
          uri,
          headers: BuildHeaders().makeJson().finish(),
          body: merchant.toJsonEncoded()
      );

      if(response.statusCode == 200){
        return (state: true, message: "Merchant was added successfully");
      }else if(response.statusCode == 400){
        return (state: false, message: response.body);
      }else{
        return (state: false, message: "Unknown Status Code");
      }
    } catch(registerError){
      rethrow;
    }
  }

}
import 'dart:convert';

class MerchantAuthCredentials{
  final String email;
  final String password;

  const MerchantAuthCredentials({required this.email,required this.password});

  String toJsonEncoded(){
    return jsonEncode({
      'email':email,
      'password':password
    });
  }
}
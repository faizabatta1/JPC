import 'dart:convert';

class UserAuthCredentials{
  final String email;
  final String password;

  const UserAuthCredentials({required this.email,required this.password});

  String toJsonEncoded(){
    return jsonEncode({
      'email':email,
      'password':password
    });
  }
}
import 'dart:convert';

class Merchant{
  final String name;
  final String email;
  final String password;

  const Merchant({
    required this.password,
    required this.name,
    required this.email
  });

  String toJsonEncoded(){
    return jsonEncode({
      'name': name,
      'email': email,
      'password': password
    });
  }
}
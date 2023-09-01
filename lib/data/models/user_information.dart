
import 'dart:convert';

class UserInformation{
  final String username;
  final String phone;
  final String location;
  final String email;
  String? password;
  String? id = '';

  UserInformation({
    required this.username,
    required this.phone,
    required this.location,
    required this.email,
    required this.password,
    this.id
  });

  factory UserInformation.fromJson(Map data){

    return UserInformation(
      username: data['username'],
      phone: data['phone'],
      location: data['location'],
      id: data['id'],
      password: data['password'],
      email: data['email'] ?? '',
    );
  }

  String toJsonEncoded(){
    return jsonEncode({
      'username': username,
      'phone': phone,
      'location': location,
      'id': id,
      'email': email,
      'password': password,
    });
  }
}
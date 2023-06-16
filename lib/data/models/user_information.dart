import 'package:cloud_firestore/cloud_firestore.dart';

class UserInformation{
  final String firstName;
  final String lastName;
  final String phone;
  final String address;
  final String email;
  final String deviceToken;
  String? uid = '';

  UserInformation({
    required this.firstName,
    required this.lastName,
    required this.phone,
    required this.address,
    required this.email,
    required this.deviceToken,
    this.uid
  });

  factory UserInformation.fromFirestore(DocumentSnapshot document){
    Map data = document.data() as Map;

    return UserInformation(
      firstName: data['firstName'],
      lastName: data['lastName'],
      phone: data['phone'],
      address: data['address'],
      uid: data['uid'],
      email: data['email'] ?? '',
      deviceToken: data['deviceToken'] ?? ''
    );
  }

  Map<String,dynamic> toFirestore(){
    return {
      'firstName': firstName,
      'lastName': lastName,
      'phone': phone,
      'address': address,
      'uid': uid,
      'email': email,
      'deviceToken': deviceToken
    };
  }
}
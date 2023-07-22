import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dartz/dartz.dart';
import 'package:jpc/core/error_handling/firestore_create_user_error.dart';
import 'package:jpc/data/datasource/remote/users_data/users_remote_data_source.dart';
import 'package:jpc/data/models/user_information.dart';

class FirestoreUsersRemoteDataSource implements UsersRemoteDataSource{
  FirebaseFirestore firestore = FirebaseFirestore.instance;

  @override
  Future<Either<FirestoreCreateUserError,bool>> addUser(UserInformation userInformation) async{
    try{
      await firestore.collection('users').add(userInformation.toFirestore());
      await firestore.collection('cart').doc(userInformation.uid).set({
        'products': []
      });
      return const Right(true);
    } catch(firestoreError){
      return Left(FirestoreCreateUserError(firestoreError.toString()));
    }
  }

  @override
  Future<void> deleteUser(String uid) {
    // TODO: implement deleteUser
    throw UnimplementedError();
  }

  @override
  Future<UserInformation> getUserInformation(String uid) async{
    var users = (await firestore.collection('users').get())
        .docs.where((element) => element['uid'] == uid).toList();

    if(users.isEmpty){
      return UserInformation(
        username: 'John Doe',
        phone: '+0123456789',
        address: 'Egypt',
        email: 'johndoe@example.com',
        deviceToken: 'none'
      );
    }else{
      return UserInformation.fromFirestore(users.first);
    }
  }

  @override
  Future<void> updateUser(String uid, UserInformation userInformation) {
    // TODO: implement updateUser
    throw UnimplementedError();
  }

  @override
  Future<void> uploadUserImage(File file) {
    // TODO: implement uploadUserImage
    throw UnimplementedError();
  }

}
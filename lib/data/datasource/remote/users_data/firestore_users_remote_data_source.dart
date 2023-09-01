import 'dart:io';

import 'package:dartz/dartz.dart';
import 'package:jpc/core/error_handling/firestore_create_user_error.dart';
import 'package:jpc/data/datasource/remote/users_data/users_remote_data_source.dart';
import 'package:jpc/data/models/user_information.dart';

class UsersRemoteDataSource implements IUsersRemoteDataSource{
  @override
  Future<Either<CreateUserError, bool>> addUser(UserInformation userInformation) {
    // TODO: implement addUser
    throw UnimplementedError();
  }

  @override
  Future<void> deleteUser(String uid) {
    // TODO: implement deleteUser
    throw UnimplementedError();
  }

  @override
  Future<UserInformation> getUserInformation(String id) {
    // TODO: implement getUserInformation
    throw UnimplementedError();
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
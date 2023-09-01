import 'dart:io';

import 'package:dartz/dartz.dart';
import 'package:jpc/core/error_handling/firestore_create_user_error.dart';
import 'package:jpc/data/models/user_information.dart';

abstract class IUsersRemoteDataSource{
  Future<UserInformation> getUserInformation(String id);
  Future<void> uploadUserImage(File file);
  Future<Either<CreateUserError,bool>> addUser(UserInformation userInformation);
  Future<void> updateUser(String uid,UserInformation userInformation);
  Future<void> deleteUser(String uid);
}
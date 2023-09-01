import 'package:jpc/data/entities/user_auth_credentials.dart';
import 'package:jpc/data/models/user_information.dart';

abstract class UserAuthenticationRepository{


  Future<void> loginWithEmailAndPassword(UserAuthCredentials userLogin);
  Future<void> registerUser(UserInformation userInformation);
  Future<void> userSignOut();
}
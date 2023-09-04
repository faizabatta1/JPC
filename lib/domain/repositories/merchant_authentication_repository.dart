import 'package:jpc/data/entities/merchant_auth_credentials.dart';
import 'package:jpc/data/entities/user_auth_credentials.dart';
import 'package:jpc/data/models/user_information.dart';

import '../../core/constants/login_status.dart';
import '../../data/models/merchant.dart';

abstract class MerchantAuthenticationRepository{


  Future<({ bool state, LoginStatus loginStatus, Map? data })> loginWithEmailAndPassword(MerchantAuthCredentials merchantAuthCredentials);
  Future<({ bool state, String message })> registerMerchant(Merchant merchant);
  Future<void> merchantSignOut();
}
import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:jpc/data/entities/merchant_auth_credentials.dart';

part 'merchant_login_event.dart';
part 'merchant_login_state.dart';

class MerchantLoginBloc extends Bloc<MerchantLoginEvent, MerchantLoginState> {
  MerchantLoginBloc() : super(MerchantLoginInitial()) {
    on<MerchantLoginEvent>((event, emit) {
      if(event is MerchantLoginButtonPressed){
      //   emit(LoginLoading());
      //
      //   final LoginUseCase loginUseCase = LoginUseCase(
      //       userAuthenticationRepositoryImpl: userAuthenticationRepositoryImpl,
      //       userAuthCredentials: event.userAuthCredentials
      //   );
      //
      //   Either<UserLoginError,({ bool state, LoginStatus loginStatus, Map? data })> response = await loginUseCase.execute();
      //
      // await response.fold(
      // (userLoginError){
      // emit(LoginFailure(message: userLoginError.message));
      // emit(LoginInitial());
      // },
      // (response) async{
      // final SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
      // switch(response.loginStatus){
      //
      // case LoginStatus.success:
      // print('yes am here');
      // await sharedPreferences.setString('token', response.data!['token']);
      // emit(LoginSuccess());
      // break;
      // case LoginStatus.notFound:
      // emit(UserNotFound());
      // break;
      // case LoginStatus.wrongCredentials:
      // emit(WrongCredentials());
      // break;
      // case LoginStatus.serverError:
      // emit(ServerError());
      // break;
      // case LoginStatus.unknown:
      // emit(UnknownState());
      // break;
      // }
      // }
      // );
      }
    });
  }
}

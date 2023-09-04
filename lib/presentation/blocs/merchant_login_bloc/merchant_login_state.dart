part of 'merchant_login_bloc.dart';

abstract class MerchantLoginState extends Equatable {
  const MerchantLoginState();
}

class MerchantLoginInitial extends MerchantLoginState {
  @override
  List<Object> get props => [];
}

class MerchantLoginLoading extends MerchantLoginState {
  @override
  List<Object?> get props => [];
}

class MerchantLoginSuccess extends MerchantLoginState {
  @override
  List<Object?> get props => [];
}

class MerchantNotFound extends MerchantLoginState {
  @override
  List<Object?> get props => [];
}

class MerchantServerError extends MerchantLoginState {
  @override
  List<Object?> get props => [];
}

class MerchantUnknownState extends MerchantLoginState {
  @override
  List<Object?> get props => [];
}

class MerchantWrongCredentials extends MerchantLoginState {
  @override
  List<Object?> get props => [];
}

class MerchantLoginFailure extends MerchantLoginState {
  final String message;
  const MerchantLoginFailure({required this.message});

  @override
  List<Object?> get props => [message];
}

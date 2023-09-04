part of 'merchant_login_bloc.dart';

abstract class MerchantLoginEvent extends Equatable {
  const MerchantLoginEvent();
}

class MerchantLoginButtonPressed extends MerchantLoginEvent{
  final MerchantAuthCredentials merchantAuthCredentials;
  const MerchantLoginButtonPressed({required this.merchantAuthCredentials});

  @override
  List<Object?> get props => [merchantAuthCredentials];
}

class ResetMerchantLoginInitial extends MerchantLoginEvent{
  @override
  List<Object?> get props => [];
}
part of 'merchant_register_bloc.dart';

abstract class MerchantRegisterEvent extends Equatable {
  const MerchantRegisterEvent();
}

class MerchantRegisterButtonPressed extends MerchantRegisterEvent{
  final Merchant merchant;
  const MerchantRegisterButtonPressed({required this.merchant});

  @override
  List<Object?> get props => [merchant];
}

class MerchantResetRegisterInitial extends MerchantRegisterEvent{
  @override
  List<Object?> get props => [];
}
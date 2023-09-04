part of 'merchant_register_bloc.dart';

abstract class MerchantRegisterState extends Equatable {
  const MerchantRegisterState();
}

class MerchantRegisterInitial extends MerchantRegisterState {
  @override
  List<Object> get props => [];
}


class MerchantRegisterLoading extends MerchantRegisterState{
  @override
  List<Object?> get props => [];
}

class MerchantRegisterSuccess extends MerchantRegisterState{
  final String message;

  const MerchantRegisterSuccess({ required this.message });

  @override
  List<Object?> get props => [];
}

class MerchantRegisterFailure extends MerchantRegisterState{
  final String message;
  const MerchantRegisterFailure({required this.message});
  @override
  List<Object?> get props => [message];
}
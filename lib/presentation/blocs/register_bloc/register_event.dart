part of 'register_bloc.dart';

abstract class RegisterEvent extends Equatable {
  const RegisterEvent();
}

class RegisterButtonPressed extends RegisterEvent{
  final UserInformation userInformation;
  const RegisterButtonPressed({required this.userInformation});

  @override
  List<Object?> get props => [userInformation];
}

class ResetRegisterInitial extends RegisterEvent{
  @override
  List<Object?> get props => [];
}
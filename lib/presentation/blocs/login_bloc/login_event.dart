part of 'login_bloc.dart';


abstract class LoginEvent extends Equatable {
  const LoginEvent();
}

class LoginButtonPressed extends LoginEvent{
  final UserAuthCredentials userAuthCredentials;
  const LoginButtonPressed({required this.userAuthCredentials});

  @override
  List<Object?> get props => [userAuthCredentials];
}

class ResetLoginInitial extends LoginEvent{
  @override
  List<Object?> get props => [];
}
part of 'login_bloc.dart';

abstract class LoginState extends Equatable {
  const LoginState();
}

class LoginInitial extends LoginState {
  @override
  List<Object> get props => [];
}

class LoginLoading extends LoginState {
  @override
  List<Object?> get props => [];
}

class LoginSuccess extends LoginState {
  @override
  List<Object?> get props => [];
}

class UserNotFound extends LoginState {
  @override
  List<Object?> get props => [];
}

class ServerError extends LoginState {
  @override
  List<Object?> get props => [];
}

class UnknownState extends LoginState {
  @override
  List<Object?> get props => [];
}

class WrongCredentials extends LoginState {
  @override
  List<Object?> get props => [];
}

class LoginFailure extends LoginState {
  final String message;
  const LoginFailure({required this.message});

  @override
  List<Object?> get props => [message];
}
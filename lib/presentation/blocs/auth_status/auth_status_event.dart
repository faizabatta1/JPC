part of 'auth_status_bloc.dart';

abstract class AuthStatusEvent extends Equatable {
  const AuthStatusEvent();
}

class AuthUserActiveEvent extends AuthStatusEvent{
  final String uid;
  const AuthUserActiveEvent({required this.uid});

  @override
  List<Object?> get props => [uid];
}

class AuthUserNotActiveEvent extends AuthStatusEvent{
  @override
  List<Object?> get props => [];
}
//
// class SendVerificationCodeEvent extends AuthStatusEvent{
//   @override
//   List<Object?> get props => [];
// }
//
// class EmailVerifiedEvent extends AuthStatusEvent{
//   @override
//   List<Object?> get props => [];
// }
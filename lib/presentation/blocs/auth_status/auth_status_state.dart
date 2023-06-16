part of 'auth_status_bloc.dart';

abstract class AuthStatusState extends Equatable {
  const AuthStatusState();
}

class AuthStatusInitial extends AuthStatusState {
  @override
  List<Object> get props => [];
}

class UserLoggedInState extends AuthStatusState{

  @override
  List<Object?> get props => [];
}

class UserNotLoggedInState extends AuthStatusState{
  @override
  List<Object?> get props => [];
}

// class UserEmailNotVerifiedState extends AuthStatusState{
//   @override
//   List<Object?> get props => [];
// }
//
// class VerificationLinkSentSuccessfully extends AuthStatusState{
//   @override
//   List<Object?> get props => [];
// }
//
// class VerificationLinkFailedToSend extends AuthStatusState{
//   @override
//   List<Object?> get props => [];
// }
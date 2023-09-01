part of 'register_bloc.dart';

abstract class RegisterState extends Equatable {
  const RegisterState();
}

class RegisterInitial extends RegisterState {
  @override
  List<Object> get props => [];
}

class RegisterLoading extends RegisterState{
  @override
  List<Object?> get props => [];
}

class RegisterSuccess extends RegisterState{
  final String message;

  const RegisterSuccess({ required this.message });

  @override
  List<Object?> get props => [];
}

class RegisterFailure extends RegisterState{
  final String message;
  const RegisterFailure({required this.message});
  @override
  List<Object?> get props => [message];
}
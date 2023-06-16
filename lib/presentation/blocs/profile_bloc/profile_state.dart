part of 'profile_bloc.dart';

abstract class ProfileState extends Equatable {
  const ProfileState();
}

class ProfileInitial extends ProfileState {
  @override
  List<Object> get props => [];
}

class ProfileInformationLoaded extends ProfileState{
  final UserInformation userInformation;
  const ProfileInformationLoaded({required this.userInformation});

  @override
  List<Object?> get props => [];
}

class ProfileInformationLoadingError extends ProfileState{
  @override
  List<Object?> get props => [];
}
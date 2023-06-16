import 'package:equatable/equatable.dart';


abstract class IUseCaseParams extends Equatable{}

class NoParams extends IUseCaseParams{
  @override
  List<Object?> get props => [];
}

class UserCaseParams extends IUseCaseParams{
  @override
  List<Object?> get props => [];

}
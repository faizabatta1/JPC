import 'package:dartz/dartz.dart';
import 'package:jpc/core/error_handling/Failure.dart';
import 'package:jpc/core/use_case/use_case_params.dart';

abstract class UseCase<UseCaseError extends Failure,UseCaseType>{
  Future<Either<UseCaseError,UseCaseType>> execute();
}
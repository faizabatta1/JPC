import 'package:bloc/bloc.dart';
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:jpc/core/error_handling/firestore_create_user_error.dart';
import 'package:jpc/core/error_handling/user_register_error.dart';
import 'package:jpc/data/datasource/remote/users_data/firestore_users_remote_data_source.dart';
import 'package:jpc/data/entities/user_auth_credentials.dart';
import 'package:jpc/data/models/user_information.dart';
import 'package:jpc/data/repositories/user_authentication_repository_impl.dart';
import 'package:jpc/domain/usecase/regsiter_case.dart';

part 'register_event.dart';
part 'register_state.dart';

class RegisterBloc extends Bloc<RegisterEvent, RegisterState> {
  RegisterBloc() : super(RegisterInitial()) {
    on<RegisterEvent>((event, emit) async{
      if(event is RegisterButtonPressed){
        emit(RegisterLoading());

        UserAuthenticationRepositoryImpl userAuthenticationRepositoryImpl = UserAuthenticationRepositoryImpl();
        RegisterUseCase registerUseCase = RegisterUseCase(
          userInformation: event.userInformation,
          userAuthenticationRepositoryImpl: userAuthenticationRepositoryImpl
        );

        try{
          Either<UserRegisterError,String> result = await registerUseCase.execute();
          result.fold(
                  (error){
                    return emit(RegisterFailure(message: error.message));
                  },
                  (response){
                    return emit(RegisterSuccess(message: response));
                  }
          );
        } catch(error){
          emit(RegisterFailure(message: error.toString()));
        }
      }else if(event is ResetRegisterInitial){
        emit(RegisterInitial());
      }
    });
  }
}

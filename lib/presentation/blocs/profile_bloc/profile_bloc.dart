import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:firebase_auth/firebase_auth.dart';

import '../../../data/datasource/remote/users_data/firestore_users_remote_data_source.dart';
import '../../../data/models/user_information.dart';

part 'profile_event.dart';
part 'profile_state.dart';

class ProfileBloc extends Bloc<ProfileEvent, ProfileState> {
  ProfileBloc() : super(ProfileInitial()) {
    on<ProfileEvent>((event, emit) async{
      if(event is LoadProfileInformationEvent){
        emit(ProfileInitial());

        FirestoreUsersRemoteDataSource firestoreUsersRemoteDataSource = FirestoreUsersRemoteDataSource();
        String uid = FirebaseAuth.instance.currentUser!.uid;
        UserInformation userInformation = await firestoreUsersRemoteDataSource.getUserInformation(uid);
        emit(ProfileInformationLoaded(userInformation: userInformation));
      }
    });
  }
}

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:usiiname/common/repository/repository.dart';
import 'package:usiiname/features/profilefetch/models/profile_fetch.dart';

part 'profile_fetch_event.dart';
part 'profile_fetch_state.dart';

class ProfileFetchBloc extends Bloc<ProfileFetchEvent, ProfileFetchState> {
  ProfileFetchBloc() : super(ProfileFetchInitial()) {
     final ApiRepository apiRepository = ApiRepository();
    on<ProfileFetch>((event, emit) async {
      try {
        emit(ProfileFetchInitial());
        final userProfile =
            await apiRepository.fetchProfile();

        emit(ProfileFetchLoading());

        emit(ProfileFetchLoaded(profileData: userProfile));
      } catch (error) {
        emit(ProfileFetchError(message: error.toString()));
      }
    });
  }
}

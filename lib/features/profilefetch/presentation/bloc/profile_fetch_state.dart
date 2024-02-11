part of 'profile_fetch_bloc.dart';

abstract class ProfileFetchState extends Equatable {
  const ProfileFetchState();

  @override
  List<Object> get props => [];
}

class ProfileFetchInitial extends ProfileFetchState {}

class ProfileFetchLoading extends ProfileFetchState {}

class ProfileFetchLoaded extends ProfileFetchState {
  final ProfileFetchModel profileData;
 const ProfileFetchLoaded({required this.profileData});
   @override
  List<Object> get props => [profileData];

}

class ProfileFetchError extends ProfileFetchState {
  final String message;
  const ProfileFetchError({required this.message});
  @override
  List<Object> get props => [message];
}

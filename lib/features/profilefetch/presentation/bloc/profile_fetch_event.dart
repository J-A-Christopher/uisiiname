part of 'profile_fetch_bloc.dart';

abstract class ProfileFetchEvent extends Equatable {
  const ProfileFetchEvent();

  @override
  List<Object> get props => [];
}

class ProfileFetch extends ProfileFetchEvent{}

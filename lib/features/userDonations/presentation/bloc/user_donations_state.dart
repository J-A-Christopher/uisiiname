part of 'user_donations_bloc.dart';

abstract class UserDonationsState extends Equatable {
  const UserDonationsState();

  @override
  List<Object> get props => [];
}

class UserDonationsInitial extends UserDonationsState {}

class UserDonationsLoading extends UserDonationsState {}

class UserDonationsLoaded extends UserDonationsState {
  final UserDonations userDonationData;
  const UserDonationsLoaded({required this.userDonationData});
    @override
  List<Object> get props => [userDonationData];
  
}

class UserDonationsError extends UserDonationsState {
  final String message;
  const UserDonationsError({required this.message});
  @override
  List<Object> get props => [message];
}

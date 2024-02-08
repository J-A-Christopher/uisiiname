part of 'user_donations_bloc.dart';

abstract class UserDonationsEvent extends Equatable {
  const UserDonationsEvent();

  @override
  List<Object> get props => [];
}

class OnUserDonation extends UserDonationsEvent{
  
} 
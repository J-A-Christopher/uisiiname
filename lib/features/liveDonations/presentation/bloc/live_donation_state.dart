part of 'live_donation_bloc.dart';

abstract class LiveDonationState extends Equatable {
  const LiveDonationState();

  @override
  List<Object> get props => [];
}

class LiveDonationInitial extends LiveDonationState {}

class LiveDonationLoading extends LiveDonationState {}

class LiveDonationLoaded extends LiveDonationState {
  final LiveDonations liveDonationData;
 const LiveDonationLoaded({required this.liveDonationData});
 @override
  List<Object> get props => [liveDonationData];
}

class LiveDonationError extends LiveDonationState {
  final String message;
  const LiveDonationError({required this.message});

  @override
  List<Object> get props => [message];
}

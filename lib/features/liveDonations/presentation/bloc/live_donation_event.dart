part of 'live_donation_bloc.dart';

abstract class LiveDonationEvent extends Equatable {
  const LiveDonationEvent();

  @override
  List<Object> get props => [];
}

class OnLiveDonation extends LiveDonationEvent {
}

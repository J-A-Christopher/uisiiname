import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:usiiname/common/repository/repository.dart';
import 'package:usiiname/features/liveDonations/models/ive_donations_model.dart';

part 'live_donation_event.dart';
part 'live_donation_state.dart';

class LiveDonationBloc extends Bloc<LiveDonationEvent, LiveDonationState> {
  LiveDonationBloc() : super(LiveDonationInitial()) {
    final ApiRepository apiRepository = ApiRepository();
    on<OnLiveDonation>((event, emit) async {
      try {
        emit(LiveDonationInitial());

        emit(LiveDonationLoading());
        final liveDonationData = await apiRepository.liveDonations();
        emit(LiveDonationLoaded(liveDonationData: liveDonationData));
      } catch (error) {
        print(error);
        emit(LiveDonationError(message: error.toString()));
      }
    });
  }
}

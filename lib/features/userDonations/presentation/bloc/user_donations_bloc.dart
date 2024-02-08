import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:usiiname/common/repository/repository.dart';
import 'package:usiiname/features/userDonations/model/userdonations_model.dart';

part 'user_donations_event.dart';
part 'user_donations_state.dart';

class UserDonationsBloc extends Bloc<UserDonationsEvent, UserDonationsState> {
  UserDonationsBloc() : super(UserDonationsInitial()) {
     final ApiRepository apiRepository = ApiRepository();
    on<OnUserDonation>((event, emit) async{
      try {
        emit(UserDonationsInitial());
         final userDonationData =
            await apiRepository.userDonations();

        emit(UserDonationsLoading());
        emit(UserDonationsLoaded(userDonationData: userDonationData));
      } catch (error) {
        emit(UserDonationsError(message: error.toString()));
      }
    });
  }
}

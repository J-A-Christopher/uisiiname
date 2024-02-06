import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:usiiname/common/repository/repository.dart';
import 'package:usiiname/features/signupfeature/model/sign_up_model.dart';

part 'sign_up_event.dart';
part 'sign_up_state.dart';

class SignUpBloc extends Bloc<SignUpEvent, SignUpState> {
  SignUpBloc() : super(SignUpInitial()) {
    final ApiRepository apiRepository = ApiRepository();
    on<OnSignUp>((event, emit) async {
      try {
        emit(SignUpInitial());
        final loginResponse =
            await apiRepository.signUpUser(userSignUpData: event.userData);
        emit(SignUpLoading());
        emit(SignUpLoaded(successUser: loginResponse));
      } catch (err) {
        print('Bloc Error: ${err.toString()}');
        emit(SignUpError(errorMessage: err.toString()));
      }
    });
  }
}

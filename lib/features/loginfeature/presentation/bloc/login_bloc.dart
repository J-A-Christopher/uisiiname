import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:usiiname/common/repository/repository.dart';
import 'package:usiiname/features/loginfeature/model/login_response.dart';

part 'login_event.dart';
part 'login_state.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  LoginBloc() : super(LoginInitial()) {
    final ApiRepository apiRepository = ApiRepository();
    on<OnLogin>((event, emit) async {
      try {
        emit(LoginInitial());
        emit(LoginLoading());
        final loginData =
            await apiRepository.loginUser(userLoginData: event.loginResponse);
        emit(LoginLoaded(loginData: loginData));
      } catch (err) {
        print('Bloc error : $err');
        emit(LoginError(message: err.toString()));
      }
    });
  }
}

part of 'login_bloc.dart';

abstract class LoginEvent extends Equatable {
  const LoginEvent();

  @override
  List<Object> get props => [];
}

class OnLogin extends LoginEvent {
  final Map<String, dynamic> loginResponse;
  const OnLogin({required this.loginResponse});
   @override
  List<Object> get props => [loginResponse];
}



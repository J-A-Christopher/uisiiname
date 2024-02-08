part of 'login_bloc.dart';

abstract class LoginState extends Equatable {
  const LoginState();

  @override
  List<Object> get props => [];
}

class LoginInitial extends LoginState {}

class LoginLoading extends LoginState {}

class LoginLoaded extends LoginState {
  final LoginResponse loginData;
 const LoginLoaded({required this.loginData});
  @override
  List<Object> get props => [loginData];
}

class LoginError extends LoginState {
  final String message;
  const LoginError({required this.message});
  @override
  List<Object> get props => [message];
}

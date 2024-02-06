part of 'sign_up_bloc.dart';

abstract class SignUpState extends Equatable {
  const SignUpState();

  @override
  List<Object> get props => [];
}

class SignUpInitial extends SignUpState {}

class SignUpLoading extends SignUpState {}

class SignUpLoaded extends SignUpState {
  final SignUpModelResponse successUser;
  const SignUpLoaded({required this.successUser});
   @override
  List<Object> get props => [successUser];

}

class SignUpError extends SignUpState {
  final String errorMessage;
  const SignUpError({required this.errorMessage});
  @override
  List<Object> get props => [errorMessage];
}

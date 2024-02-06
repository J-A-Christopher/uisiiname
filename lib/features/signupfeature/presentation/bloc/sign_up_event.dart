part of 'sign_up_bloc.dart';

abstract class SignUpEvent extends Equatable {
  const SignUpEvent();

  @override
  List<Object> get props => [];
}

class OnSignUp extends SignUpEvent {
  final Map<String, dynamic> userData;
  const OnSignUp({required this.userData});
   @override
  List<Object> get props => [userData];
}

import 'package:flutter_bloc/flutter_bloc.dart';

class OnboardingCubit extends Cubit<bool> {
  OnboardingCubit() : super(false);
  //void updatePage(int page) => emit(page);
  void updateTheme() => emit(!state);
}

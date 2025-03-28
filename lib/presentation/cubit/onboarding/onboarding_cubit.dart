import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'onboarding_state.dart';

class OnboardingCubit extends Cubit<OnboardingState> {
  OnboardingCubit() : super(const OnboardingState());

  void updateCurrentPage(int page) {
    emit(
      state.copyWith(
        currentPage: page,
        isLastPage: page == state.pageCount - 1,
      ),
    );
  }
}

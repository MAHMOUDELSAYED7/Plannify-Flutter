part of 'onboarding_cubit.dart';

@immutable
class OnboardingState {
  final int currentPage;
  final bool isLastPage;
  final int pageCount;

  const OnboardingState({
    this.currentPage = 0,
    this.isLastPage = false,
    this.pageCount = 3,
  });

  OnboardingState copyWith({
    int? currentPage,
    bool? isLastPage,
    int? pageCount,
  }) {
    return OnboardingState(
      currentPage: currentPage ?? this.currentPage,
      isLastPage: isLastPage ?? this.isLastPage,
      pageCount: pageCount ?? this.pageCount,
    );
  }
}

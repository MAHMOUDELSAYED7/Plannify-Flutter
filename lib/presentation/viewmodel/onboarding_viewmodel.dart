import 'package:flutter/material.dart';
import 'package:plannify/core/constants/images.dart';

import '../../data/models/onboarding_page_model.dart';

class OnboardingViewModel {
  final List<OnboardingPage> pages;
  final PageController pageController;

  OnboardingViewModel()
    : pages = _createPages(),
      pageController = PageController();

  void dispose() {
    pageController.dispose();
  }

  static List<OnboardingPage> _createPages() => [
    OnboardingPage(
      title: "Your convenience in making a todo list",
      description:
          "Here's a mobile platform that helps you create task or to list so that it can help you in every job\neasier and faster.",
      image: ImageManager.onPordingFirst,
    ),
    OnboardingPage(
      title: "Find the practicality in making your todo list",
      description:
          "Easy-to-understand user interface  that makes you more comfortable when you want to create a task or to do list, Todyapp can also improve productivity",
      image: ImageManager.onPordingSecond,
    ),
  ];

  bool isLastPage(int currentIndex) => currentIndex == pages.length - 1;

  void nextPage() {
    pageController.nextPage(
      duration: const Duration(milliseconds: 300),
      curve: Curves.easeIn,
    );
  }
}

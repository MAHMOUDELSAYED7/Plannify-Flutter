import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:plannify/core/router/routes.dart';
import 'package:plannify/core/utils/extensions/extensions.dart';
import 'package:plannify/core/widgets/custom_text_button.dart';

import '../../core/utils/constants/images.dart';
import '../../core/widgets/custom_elevated_button.dart';
import '../../data/models/onboarding_page_model.dart';
import '../cubit/onboarding/onboarding_cubit.dart';
import '../widgets/onboarding_page.dart';
import '../widgets/page_indicator.dart';

class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({super.key});

  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  late final PageController _pageController;
  @override
  void initState() {
    _pageController = PageController();
    super.initState();
  }

  void nextPage() {
    _pageController.nextPage(
      duration: const Duration(milliseconds: 300),
      curve: Curves.easeIn,
    );
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocBuilder<OnboardingCubit, OnboardingState>(
        builder: (context, state) {
          return Stack(
            children: <Widget>[
              PageView.builder(
                controller: _pageController,
                itemCount: _pages.length,
                onPageChanged:
                    (page) => context
                        .cubit<OnboardingCubit>()
                        .updateCurrentPage(page),
                itemBuilder:
                    (context, index) =>
                        OnboardingPageWidget(page: _pages[index]),
              ),

              PageIndicator(
                currentPage: state.currentPage,
                pageCount: state.pageCount,
              ).center().positionedBottom(bottom: context.height * 0.2),
              Column(
                children: [
                  if (state.isLastPage)
                    MyElevatedButton(
                      title: "Get Started",
                      onPressed:
                          () =>
                              context.pushReplacementNamed(RouteManager.login),
                    )
                  else
                    MyElevatedButton(title: "Continue", onPressed: nextPage),
                ],
              ).center().positionedBottom(bottom: context.height * 0.03),
              MyTextButton(
                title: "Skip",
                onTap: () => context.pushReplacementNamed(RouteManager.login),
              ).positionedTopRight(top: 24),
            ],
          ).withAllPadding(24);
        },
      ),
    );
  }

  static final List<OnboardingPage> _pages = [
    OnboardingPage(
      title: "Your convenience in making a todo list",
      description:
          "Here's a mobile platform that helps you create task or to list so that it can help you in every job\neasier and faster.",
      image: ImageManager.onPordingFirst,
    ),
    OnboardingPage(
      title: "Find the practicality in making your todo list",
      description:
          "Easy-to-understand user interface that makes you more comfortable when you want to create a task or to do list, Todyapp can also improve productivity",
      image: ImageManager.onPordingSecond,
    ),
    OnboardingPage(
      title: "Welcome to Plannify",
      description:
          "Start your journey towards better organization and productivity. Plannify is here to simplify your tasks and help you achieve your goals effortlessly.",
      image: ImageManager.onPordingThird,
    ),
  ];
}

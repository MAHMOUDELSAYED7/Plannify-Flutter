import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:plannify/core/locator/locator.dart';
import 'package:plannify/core/router/routes.dart';
import 'package:plannify/core/utils/extensions/extensions.dart';

import '../../core/themes/colors.dart';
import '../../core/widgets/custom_elevated_button.dart';
import '../cubit/onboarding/onboarding_cubit.dart';
import '../viewmodel/onboarding_viewmodel.dart';
import 'widgets/onboarding_page.dart';
import 'widgets/page_indicator.dart';

class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({super.key});

  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  late final OnboardingViewModel _viewModel;

  @override
  void initState() {
    super.initState();
    _viewModel = locator<OnboardingViewModel>();
  }

  @override
  void dispose() {
    _viewModel.dispose();
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
                controller: _viewModel.pageController,
                itemCount: _viewModel.pages.length,
                onPageChanged:
                    (page) => context
                        .cubit<OnboardingCubit>()
                        .updateCurrentPage(page),
                itemBuilder:
                    (context, index) =>
                        OnboardingPageWidget(page: _viewModel.pages[index]),
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
                    MyElevatedButton(
                      title: "Continue",
                      onPressed: _viewModel.nextPage,
                    ),
                ],
              ).center().positionedBottom(bottom: context.height * 0.03),
              InkWell(
                onTap: () => context.pushReplacementNamed(RouteManager.login),
                child: Text(
                  "Skip",
                  style: context.textTheme.bodyMedium?.copyWith(
                    color: ColorManager.primary,
                  ),
                ),
              ).positionedTopRight(top: 24),
            ],
          ).withAllPadding(24);
        },
      ),
    );
  }
}

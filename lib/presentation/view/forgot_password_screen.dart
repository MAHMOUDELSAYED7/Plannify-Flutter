import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:plannify/core/router/routes.dart';
import 'package:plannify/core/utils/extensions/extensions.dart';
import 'package:plannify/core/utils/helpers/toast_message.dart';
import 'package:plannify/core/widgets/custom_text_button.dart';
import 'package:plannify/presentation/cubit/auth/forgot_password/forgot_password_cubit.dart';
import 'package:plannify/presentation/viewmodel/forgot_password_viewmodel.dart';

import '../../core/constants/font_size.dart';
import '../../core/locator/locator.dart';
import '../../core/themes/colors.dart';
import '../../core/widgets/custom_elevated_button.dart';
import '../../core/widgets/custom_text_form_field.dart';

class ForgotPasswordScreen extends StatefulWidget {
  const ForgotPasswordScreen({super.key});

  @override
  State<ForgotPasswordScreen> createState() => _ForgotPasswordScreenState();
}

class _ForgotPasswordScreenState extends State<ForgotPasswordScreen> {
  late final ForgotPasswordViewModel _viewModel;

  @override
  void initState() {
    super.initState();
    _viewModel = locator<ForgotPasswordViewModel>();
  }

  void _navigateToResetPassword() => context.pushNamedAndRemoveUntil(
    RouteManager.resetPassword,
    arguments: _viewModel.email,
  );
  @override
  void dispose() {
    _viewModel.formKey.currentState?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<ForgotPasswordCubit, ForgotPasswordState>(
      bloc: _viewModel.cubit,
      listener: (context, state) {
        if (state is ForgotPasswordError) {
          ToastHelper.showCustomToast(state.message);
        }
        if (state is ForgotPasswordSuccess) {
          ToastHelper.showCustomToast(
            state.response.message ?? 'Verification code sent to your email!',
          );
          _navigateToResetPassword();
        }
      },
      child: Scaffold(
        body: Column(
          children: [
            Text(
              'Forgot Password',
              style: context.textTheme.bodyLarge?.copyWith(
                fontSize: FontSizeManager.large + 4.sp,
              ),
            ).center().withOnlyPadding(top: 50.h),
            Text(
              'Please enter your email to reset your password',
              style: context.textTheme.bodyMedium?.copyWith(
                fontSize: FontSizeManager.medium,
                color: ColorManager.grayDark,
              ),
              textAlign: TextAlign.center,
            ).withOnlyPadding(top: 4),
            Form(
              key: _viewModel.formKey,
              child: Column(
                children: [
                  MyTextFormField(
                    onSaved: (val) => _viewModel.email = val,
                    title: 'Email',
                    hintText: 'Enter your email',
                    validator: _viewModel.formValidationManager.validateEmail,
                  ).withOnlyPadding(bottom: 16.h),
                ],
              ),
            ),
            MyTextButton(
              title: 'Back to Login?',
              onTap: () => context.back(),
            ).alignCenterRight(),
          ],
        ).withAllPadding(24),
        bottomNavigationBar:
            BlocBuilder<ForgotPasswordCubit, ForgotPasswordState>(
              bloc: _viewModel.cubit,
              builder: (context, state) {
                return MyElevatedButton(
                  onPressed:
                      state is ForgotPasswordLoading
                          ? null
                          : _viewModel.forgotPassword,
                  title: 'Forgot Password',
                  isLoading: state is ForgotPasswordLoading,
                ).withOnlyPadding(
                  bottom: context.height * 0.03 + 24,
                  left: 24,
                  right: 24,
                );
              },
            ),
      ),
    );
  }
}

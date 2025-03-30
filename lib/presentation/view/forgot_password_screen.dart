import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:plannify/core/router/routes.dart';
import 'package:plannify/core/utils/extensions/extensions.dart';
import 'package:plannify/core/utils/helpers/toast_message.dart';
import 'package:plannify/core/widgets/custom_text_button.dart';
import 'package:plannify/presentation/cubit/auth/forgot_password/forgot_password_cubit.dart';

import '../../core/constants/font_size.dart';
import '../../core/locator/locator.dart';
import '../../core/themes/colors.dart';
import '../../core/utils/formatters/form_validation.dart';
import '../../core/widgets/custom_elevated_button.dart';
import '../../core/widgets/custom_gap.dart';
import '../../core/widgets/custom_text_form_field.dart';
import '../../data/models/auth_model.dart';

class ForgotPasswordScreen extends StatefulWidget {
  const ForgotPasswordScreen({super.key});

  @override
  State<ForgotPasswordScreen> createState() => _ForgotPasswordScreenState();
}

class _ForgotPasswordScreenState extends State<ForgotPasswordScreen> {
  late final GlobalKey<FormState> _formKey;
  late final FormValidationManager _formValidationManager;
  String? _email;

  Future<void> forgotPassword() async {
    if (_formKey.currentState?.validate() ?? false) {
      _formKey.currentState?.save();
      final request = ForgotPasswordRequest(email: _email?.trim() ?? '');
      await context.cubit<ForgotPasswordCubit>().forgotPassword(request);
    }
  }

  @override
  void initState() {
    super.initState();
    _formKey = GlobalKey<FormState>();
    _formValidationManager = sl<FormValidationManager>();
  }

  void _navigateToResetPassword() => context.pushNamedAndRemoveUntil(
    RouteManager.resetPassword,
    arguments: _email,
  );
  @override
  void dispose() {
    _formKey.currentState?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<ForgotPasswordCubit, ForgotPasswordState>(
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
        body: SingleChildScrollView(
          child: Column(
            children: [
              Text(
                'Forgot Password',
                style: context.textTheme.bodyLarge?.copyWith(
                  fontSize: FontSizeManager.large.sp + 4.sp,
                ),
              ).center().withOnlyPadding(top: 50.h),
              Text(
                'Please enter your email to reset your password',
                style: context.textTheme.bodyMedium?.copyWith(
                  fontSize: FontSizeManager.medium.sp,
                  color: ColorManager.grayDark,
                ),
                textAlign: TextAlign.center,
              ).withOnlyPadding(top: 4),
              Gap(size: 24.h),
              Form(
                key: _formKey,
                child: Column(
                  children: [
                    MyTextFormField(
                      keyboardType: TextInputType.emailAddress,
                      onSaved: (val) => _email = val,
                      title: 'Email',
                      hintText: 'Enter your email',
                      validator: _formValidationManager.validateEmail,
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
        ),
        bottomNavigationBar:
            BlocBuilder<ForgotPasswordCubit, ForgotPasswordState>(
              builder: (context, state) {
                return MyElevatedButton(
                  onPressed:
                      state is ForgotPasswordLoading ? null : forgotPassword,
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

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:plannify/core/utils/extensions/extensions.dart';
import 'package:plannify/core/utils/helpers/toast_message.dart';
import 'package:plannify/core/widgets/custom_text_button.dart';
import 'package:plannify/presentation/cubit/auth/reset_password/reset_password_cubit.dart';

import '../../core/constants/font_size.dart';
import '../../core/locator/locator.dart';
import '../../core/router/routes.dart';
import '../../core/themes/colors.dart';
import '../../core/utils/formatters/form_validation.dart';
import '../../core/widgets/custom_elevated_button.dart';
import '../../core/widgets/custom_gap.dart';
import '../../core/widgets/custom_otp_field.dart';
import '../../core/widgets/custom_text_form_field.dart';
import '../../data/models/auth_model.dart';

class ResetPasswordScreen extends StatefulWidget {
  const ResetPasswordScreen({super.key, required this.email});
  final String email;

  @override
  State<ResetPasswordScreen> createState() => _ResetPasswordScreenState();
}

class _ResetPasswordScreenState extends State<ResetPasswordScreen> {
  late final GlobalKey<FormState> _formKey;
  late final FormValidationManager _formValidationManager;
  String? _email;
  String? _newPassword;

  Future<void> resetPassword(String otp) async {
    if (_formKey.currentState?.validate() ?? false) {
      _formKey.currentState?.save();
      final request = ResetPasswordRequest(
        email: _email?.trim() ?? '',
        otp: otp.trim(),
        newPassword: _newPassword?.trim() ?? '',
      );
      await context.cubit<ResetPasswordCubit>().resetPassword(request);
    }
  }

  @override
  void initState() {
    super.initState();
    _formKey = GlobalKey<FormState>();
    _formValidationManager = sl<FormValidationManager>();
    _email = widget.email;
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.cubit<ResetPasswordCubit>().startOtpExpirationTimer();
    });
  }

  @override
  void dispose() {
    _formKey.currentState?.dispose();
    super.dispose();
  }

  void _navigateToLogin() =>
      context.pushNamedAndRemoveUntil(RouteManager.login);
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ResetPasswordCubit, ResetPasswordState>(
      listener: (context, state) {
        if (state is ResetPasswordError) {
          ToastHelper.showCustomToast(state.message);
        }
        if (state is ResetPasswordSuccess) {
          ToastHelper.showCustomToast(
            'Password reset successfully!, you can login now.',
          );
          _navigateToLogin();
        }
        if (state is ResetPasswordLoading) {
          ToastHelper.showCustomToast('Loading...');
        }
        if (state is VerifyOtpTimerExpired) {
          ToastHelper.showCustomToast('Timer expired!');
          _navigateToLogin();
        }
      },
      builder: (context, state) {
        return Scaffold(
          body: PopScope(
            canPop: false,
            child: SingleChildScrollView(
              child: Column(
                children: [
                  Text(
                    'Reset Password',
                    style: context.textTheme.bodyLarge?.copyWith(
                      fontSize: FontSizeManager.large.sp + 4.sp,
                    ),
                  ).center().withOnlyPadding(top: 50.h),
                  Text(
                    'Enter your new password',
                    style: context.textTheme.bodyMedium?.copyWith(
                      fontSize: FontSizeManager.medium.sp,
                      color: ColorManager.grayDark,
                    ),
                    textAlign: TextAlign.center,
                  ).withOnlyPadding(top: 4),
                  Gap(size: 30.h),
                  MyOtpField(
                    isClear:
                        state is ResetPasswordError ||
                        state is VerifyOtpTimerExpired,
                    isLoading: state is ResetPasswordLoading,
                    onCompleted: (val) async => await resetPassword(val),
                  ),
                  Gap(size: 25.h),
                  Form(
                    key: _formKey,
                    child: Column(
                      children: [
                        MyTextFormField(
                          title: 'New Password',
                          hintText: 'Enter your password',
                          obscureText: true,
                          onChanged: (val) => _newPassword = val,
                          validator: _formValidationManager.validatePassword,
                        ).withOnlyPadding(bottom: 16.h),
                        MyTextFormField(
                          title: 'Confirm Password',
                          hintText: 'Enter your password',
                          obscureText: true,
                          validator:
                              (val) => _formValidationManager
                                  .validateConfirmPassword(val, _newPassword),
                        ).withOnlyPadding(bottom: 16.h),
                        MyTextButton(
                          title: 'Back to Login?',
                          onTap:
                              () => context.pushNamedAndRemoveUntil(
                                RouteManager.login,
                              ),
                        ).alignCenterRight(),
                      ],
                    ),
                  ),
                ],
              ).withAllPadding(24),
            ),
          ),
          bottomNavigationBar: MyElevatedButton(
            onPressed:
                state is ResetPasswordLoading
                    ? null
                    : () => resetPassword(widget.email),
            title: 'Reset Password',
            isLoading: state is ResetPasswordLoading,
          ).withOnlyPadding(
            bottom: context.height * 0.03 + 24,
            left: 24,
            right: 24,
          ),
        );
      },
    );
  }
}

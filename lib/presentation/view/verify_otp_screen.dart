import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:plannify/core/utils/extensions/extensions.dart';
import 'package:plannify/core/utils/helpers/toast_message.dart';
import 'package:plannify/core/widgets/custom_gap.dart';
import 'package:plannify/core/widgets/custom_otp_field.dart';
import 'package:plannify/presentation/cubit/auth/verify_otp/verify_otp_cubit.dart';

import '../../core/router/routes.dart';
import '../../core/themes/colors.dart';
import '../../core/widgets/custom_text_button.dart';
import '../../data/models/auth_model.dart';

class VerifyOtpScreen extends StatefulWidget {
  final String email;

  const VerifyOtpScreen({super.key, required this.email});

  @override
  State<VerifyOtpScreen> createState() => _VerifyOtpScreenState();
}

class _VerifyOtpScreenState extends State<VerifyOtpScreen> {
  String? _email;

  Future<void> _verifyOtp(String otp) async {
    final request = VerifyOtpRequest(
      otp: otp.trim(),
      email: _email?.trim() ?? '',
    );
    await context.cubit<VerifyOtpCubit>().verifyOtp(request);
    otp = '';
  }

  @override
  void initState() {
    super.initState();
    context.cubit<VerifyOtpCubit>().startOtpExpirationTimer();
    _email = widget.email;
  }

  void _navigateToLogin() =>
      context.pushNamedAndRemoveUntil(RouteManager.login);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<VerifyOtpCubit, VerifyOtpState>(
      listener: (context, state) {
        if (state is VerifyOtpError) {
          ToastHelper.showCustomToast(state.message);
        }
        if (state is VerifyOtpSuccess) {
          ToastHelper.showCustomToast(
            'Verification successful! You can login now.',
          );
          _navigateToLogin();
        }
        if (state is VerifyOtpTimerExpired) {
          _navigateToLogin();
        }
      },
      builder: (context, state) {
        return PopScope(
          canPop: false,
          child: Scaffold(
            body: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    'Verify OTP',
                    style: context.textTheme.headlineMedium?.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
                  ).center().withOnlyPadding(top: 100.h),
                  Gap(size: 24.h),
                  Text(
                    'We sent a verification code to',
                    style: context.textTheme.bodyMedium?.copyWith(
                      color: ColorManager.grayDark,
                    ),
                    textAlign: TextAlign.center,
                  ).center(),
                  Gap(size: 8.h),
                  Text(
                    widget.email,
                    style: context.textTheme.bodySmall?.copyWith(
                      color: ColorManager.primary,
                      fontWeight: FontWeight.bold,
                    ),
                    textAlign: TextAlign.center,
                  ).center(),
                  Gap(size: 32.h),
                  MyOtpField(
                    isClear:
                        state is VerifyOtpError ||
                        state is VerifyOtpTimerExpired,
                    isLoading: state is VerifyOtpLoading,
                    onCompleted: (val) async => await _verifyOtp(val),
                  ),
                  Gap(size: 25.h),
                  MyTextButton(
                    title: 'Back to Login?',
                    onTap:
                        () => context.pushReplacementNamed(RouteManager.login),
                  ).alignCenterRight(),
                ],
              ).withAllPadding(24),
            ),
          ),
        );
      },
    );
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:plannify/core/utils/extensions/extensions.dart';
import 'package:plannify/core/utils/helpers/toast_message.dart';
import 'package:plannify/core/widgets/custom_gap.dart';
import 'package:plannify/core/widgets/custom_text_button.dart';

import '../../core/constants/font_size.dart';
import '../../core/locator/locator.dart';
import '../../core/router/routes.dart';
import '../../core/themes/colors.dart';
import '../../core/utils/formatters/form_validation.dart';
import '../../core/widgets/custom_elevated_button.dart';
import '../../core/widgets/custom_text_form_field.dart';
import '../../data/models/auth_model.dart';
import '../cubit/auth/login/login_cubit.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  late final GlobalKey<FormState> _formKey;
  late final FormValidationManager _formValidationManager;
  String? _email;
  String? _password;

  Future<void> _login() async {
    if (_formKey.currentState?.validate() ?? false) {
      _formKey.currentState?.save();
      final request = LoginRequest(
        email: _email?.trim() ?? '',
        password: _password?.trim() ?? '',
      );
      await context.cubit<LoginCubit>().login(request);
    }
  }

  @override
  void initState() {
    super.initState();

    _formKey = GlobalKey<FormState>();
    _formValidationManager = sl<FormValidationManager>();
  }

  @override
  void dispose() {
    _formKey.currentState?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<LoginCubit, LoginState>(
      listener: (context, state) {
        if (state is LoginError) {
          ToastHelper.showCustomToast(state.message);
        }
        if (state is LoginSuccess) {
          ToastHelper.showCustomToast('Login successful!');
          context.pushNamedAndRemoveUntil(RouteManager.home);
        }
        if (state is EmailNotVerified) {
          ToastHelper.showCustomToast(state.message);
          context.pushNamedAndRemoveUntil(
            RouteManager.verifyOtp,
            arguments: _email,
          );
        }
      },
      child: Scaffold(
        body: SingleChildScrollView(
          child: Column(
            children: [
              Text(
                'Welcome Back!',
                style: context.textTheme.bodyLarge?.copyWith(
                  fontSize: FontSizeManager.large.sp + 4.sp,
                ),
              ).center().withOnlyPadding(top: 50.h),
              Text(
                'please Log in to access your account',
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
                    MyTextFormField(
                      keyboardType: TextInputType.visiblePassword,
                      title: 'Password',
                      hintText: 'Enter your password',
                      obscureText: true,
                      onSaved: (val) => _password = val,
                      validator: _formValidationManager.validatePassword,
                    ).withOnlyPadding(bottom: 16.h),
                    MyTextButton(
                      title: 'Forgot Password?',
                      onTap:
                          () => context.pushNamed(RouteManager.forgotPassword),
                    ).alignCenterRight(),
                    MyTextButton(
                      title: 'Create an account?',
                      onTap: () => context.pushNamed(RouteManager.register),
                    ).alignCenterRight(),
                  ],
                ),
              ),
            ],
          ).withAllPadding(24),
        ),
        bottomNavigationBar: BlocBuilder<LoginCubit, LoginState>(
          builder: (context, state) {
            return MyElevatedButton(
              onPressed: state is LoginLoading ? null : _login,
              title: 'Login',
              isLoading: state is LoginLoading,
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

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:plannify/core/utils/extensions/extensions.dart';
import 'package:plannify/core/utils/helpers/toast_message.dart';

import '../../core/constants/font_size.dart';
import '../../core/locator/locator.dart';
import '../../core/themes/colors.dart';
import '../../core/widgets/custom_elevated_button.dart';
import '../../core/widgets/custom_text_form_field.dart';
import '../cubit/auth/login/login_cubit.dart';
import '../viewmodel/login_viewmodel.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  late final LoginViewModel _viewModel;

  @override
  void initState() {
    super.initState();
    _viewModel = locator<LoginViewModel>();
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<LoginCubit, LoginState>(
      bloc: _viewModel.cubit,
      listener: (context, state) {
        if (state is LoginError) {
          ToastHelper.showCustomToast(state.message);
        }
        if (state is LoginSuccess) {
          ToastHelper.showCustomToast('Login successful!');
        }
      },
      child: Scaffold(
        body: Column(
          children: [
            Text(
              'Welcome Back!',
              style: context.textTheme.bodyLarge?.copyWith(
                fontSize: FontSizeManager.large + 4.sp,
              ),
            ).center().withOnlyPadding(top: 50.h),
            Text(
              'please Log in to access your account',
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
                  MyTextFormField(
                    title: 'Password',
                    hintText: 'Enter your password',
                    obscureText: true,
                    onSaved: (val) => _viewModel.password = val,
                    validator:
                        _viewModel.formValidationManager.validatePassword,
                  ).withOnlyPadding(bottom: 16.h),
                  BlocBuilder<LoginCubit, LoginState>(
                    bloc: _viewModel.cubit,
                    builder: (context, state) {
                      return MyElevatedButton(
                        onPressed:
                            state is LoginLoading ? null : _viewModel.login,
                        title: 'Login',
                        isLoading: state is LoginLoading,
                      );
                    },
                  ),
                ],
              ),
            ),
          ],
        ).withAllPadding(24),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:plannify/core/utils/extensions/extensions.dart';
import 'package:plannify/core/utils/helpers/toast_message.dart';
import 'package:plannify/presentation/cubit/auth/register/register_cubit.dart';
import 'package:plannify/presentation/viewmodel/register_viewmodel.dart';

import '../../core/constants/font_size.dart';
import '../../core/locator/locator.dart';
import '../../core/themes/colors.dart';
import '../../core/widgets/custom_elevated_button.dart';
import '../../core/widgets/custom_text_form_field.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  late final RegisterViewModel _viewModel;

  @override
  void initState() {
    super.initState();
    _viewModel = locator<RegisterViewModel>();
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<RegisterCubit, RegisterState>(
      bloc: _viewModel.cubit,
      listener: (context, state) {
        if (state is RegisterError) {
          ToastHelper.showCustomToast(state.message);
        }
        if (state is RegisterSuccess) {
          ToastHelper.showCustomToast('Register successful, Verify your email');
        }
      },
      child: Scaffold(
        body: Column(
          children: [
            Text(
              'Create account',
              style: context.textTheme.bodyLarge?.copyWith(
                fontSize: FontSizeManager.large + 4.sp,
              ),
            ).center().withOnlyPadding(top: 50.h),
            Text(
              'Create your account and feel the benefits',
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
                    onSaved: (val) => _viewModel.username = val,
                    title: 'Username',
                    hintText: 'Enter your username',
                    validator:
                        _viewModel.formValidationManager.validateUsername,
                  ).withOnlyPadding(bottom: 16.h),
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
                ],
              ),
            ),
          ],
        ).withAllPadding(24),
        bottomNavigationBar: BlocBuilder<RegisterCubit, RegisterState>(
          bloc: _viewModel.cubit,
          builder: (context, state) {
            return MyElevatedButton(
              onPressed: state is RegisterLoading ? null : _viewModel.register,
              title: 'Register',
              isLoading: state is RegisterLoading,
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

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:plannify/core/utils/extensions/extensions.dart';
import 'package:plannify/core/utils/helpers/toast_message.dart';
import 'package:plannify/presentation/cubit/auth/register/register_cubit.dart';

import '../../core/utils/constants/font_size.dart';
import '../../core/locator/locator.dart';
import '../../core/router/routes.dart';
import '../../core/themes/colors.dart';
import '../../core/utils/formatters/form_validation.dart';
import '../../core/widgets/custom_elevated_button.dart';
import '../../core/widgets/custom_gap.dart';
import '../../core/widgets/custom_text_form_field.dart';
import '../../data/models/auth_model.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  late final GlobalKey<FormState> _formKey;
  late final FormValidationManager _formValidationManager;
  String? _email;
  String? _password;
  String? _username;

  Future<void> _register() async {
    if (_formKey.currentState?.validate() ?? false) {
      _formKey.currentState?.save();
      final request = RegisterRequest(
        username: _username?.trim() ?? '',
        email: _email?.trim() ?? '',
        password: _password?.trim() ?? '',
      );
      await context.cubit<RegisterCubit>().register(request);
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
    return BlocListener<RegisterCubit, RegisterState>(
      listener: (context, state) {
        if (state is RegisterError) {
          ToastHelper.showCustomToast(state.message);
        }
        if (state is RegisterSuccess) {
          ToastHelper.showCustomToast(
            state.response.message ?? 'Verification code sent to your email!',
          );
          context.pushNamedAndRemoveUntil(
            RouteManager.verifyOtp,
            arguments: _email,
          );
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
                'Create account',
                style: context.textTheme.bodyLarge?.copyWith(
                  fontSize: FontSizeManager.large.sp + 4.sp,
                ),
              ).center().withOnlyPadding(top: 50.h),
              Text(
                'Create your account and feel the benefits',
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
                      keyboardType: TextInputType.name,
                      onSaved: (val) => _username = val,
                      title: 'Username',
                      hintText: 'Enter your username',
                      validator: _formValidationManager.validateUsername,
                    ).withOnlyPadding(bottom: 16.h),
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
                  ],
                ),
              ),
            ],
          ).withAllPadding(24),
        ),
        bottomNavigationBar: BlocBuilder<RegisterCubit, RegisterState>(
          builder: (context, state) {
            return MyElevatedButton(
              onPressed: state is RegisterLoading ? null : _register,
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

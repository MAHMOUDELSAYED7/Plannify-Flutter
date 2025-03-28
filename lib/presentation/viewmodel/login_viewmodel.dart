import 'package:flutter/material.dart';
import 'package:plannify/core/locator/locator.dart';
import 'package:plannify/data/models/auth_model.dart';

import '../../core/utils/formatters/form_validation.dart';
import '../cubit/auth/login/login_cubit.dart';
class LoginViewModel {
  final LoginCubit cubit;
  final GlobalKey<FormState> formKey;
  final FormValidationManager formValidationManager;
  String? email;
  String? password;

  LoginViewModel()
      : formKey = GlobalKey<FormState>(),
        formValidationManager = locator<FormValidationManager>(),
        cubit = locator<LoginCubit>();

  Future<void> login() async {
    if (formKey.currentState?.validate() ?? false) {
      formKey.currentState?.save();
      final request = LoginRequest(
        email: email?.trim() ?? '',
        password: password?.trim() ?? '',
      );
      await cubit.login(request);
    }
  }
}

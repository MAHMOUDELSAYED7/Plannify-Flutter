import 'package:flutter/material.dart';
import 'package:plannify/core/locator/locator.dart';
import 'package:plannify/data/models/auth_model.dart';
import 'package:plannify/presentation/cubit/auth/forgot_password/forgot_password_cubit.dart';

import '../../core/utils/formatters/form_validation.dart';

class ForgotPasswordViewModel {
  final ForgotPasswordCubit cubit;
  final GlobalKey<FormState> formKey;
  final FormValidationManager formValidationManager;
  String? email;
  
  ForgotPasswordViewModel()
    : formKey = GlobalKey<FormState>(),
      formValidationManager = locator<FormValidationManager>(),
      cubit = locator<ForgotPasswordCubit>();

  Future<void> forgotPassword() async {
    if (formKey.currentState?.validate() ?? false) {
      formKey.currentState?.save();
      final request = ForgotPasswordRequest(email: email?.trim() ?? '');
      await cubit.forgotPassword(request);
    }
  }
}

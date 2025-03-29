import 'package:flutter/material.dart';
import 'package:plannify/core/locator/locator.dart';
import 'package:plannify/data/models/auth_model.dart';
import 'package:plannify/presentation/cubit/auth/reset_password/reset_password_cubit.dart';

import '../../core/utils/formatters/form_validation.dart';

class ResetPasswordViewModel {
  final ResetPasswordCubit cubit;
  final GlobalKey<FormState> formKey;
  final FormValidationManager formValidationManager;
  String? email;
  String? newPassword;

  ResetPasswordViewModel()
    : formKey = GlobalKey<FormState>(),
      formValidationManager = locator<FormValidationManager>(),
      cubit = locator<ResetPasswordCubit>();

  Future<void> resetPassword(String otp) async {
    if (formKey.currentState?.validate() ?? false) {
      formKey.currentState?.save();
      final request = ResetPasswordRequest(
        email: email?.trim() ?? '',
        otp: otp.trim(),
        newPassword: newPassword?.trim() ?? '',
      );
      await cubit.resetPassword(request);
    }
  }
}

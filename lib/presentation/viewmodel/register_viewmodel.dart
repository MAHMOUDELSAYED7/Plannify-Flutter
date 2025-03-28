import 'package:flutter/material.dart';
import 'package:plannify/core/locator/locator.dart';
import 'package:plannify/data/models/auth_model.dart';
import 'package:plannify/presentation/cubit/auth/register/register_cubit.dart';

import '../../core/utils/formatters/form_validation.dart';

class RegisterViewModel {
  final RegisterCubit cubit;
  final GlobalKey<FormState> formKey;
  final FormValidationManager formValidationManager;
  String? email;
  String? password;
  String? username;
  RegisterViewModel()
    : formKey = GlobalKey<FormState>(),
      formValidationManager = locator<FormValidationManager>(),
      cubit = locator<RegisterCubit>();

  Future<void> register() async {
    if (formKey.currentState?.validate() ?? false) {
      formKey.currentState?.save();
      final request = RegisterRequest(
        username: username?.trim() ?? '',
        email: email?.trim() ?? '',
        password: password?.trim() ?? '',
      );
      await cubit.register(request);
    }
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:plannify/core/utils/extensions/extensions.dart';
import 'package:plannify/core/utils/helpers/toast_message.dart';
import 'package:plannify/core/widgets/custom_elevated_button.dart';
import 'package:plannify/core/widgets/custom_gap.dart';
import 'package:plannify/presentation/cubit/auth/auth_status/auth_status_cubit.dart';

import '../../core/router/routes.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Home Screen')),
      body:
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'Welcome to the Home Screen!',
                style: context.textTheme.bodyLarge,
              ),
              Gap(size: 25.h),
              BlocConsumer<AuthStatusCubit, AuthStatusState>(
                listener: (context, state) {
                  if (state is AuthStatusUnauthenticated) {
                    context.pushNamedAndRemoveUntil(RouteManager.login);
                    ToastHelper.showCustomToast('Logged out successfully!');
                  }
                  if (state is AuthStatusError) {
                    context.pushNamedAndRemoveUntil(RouteManager.login);
                    ToastHelper.showCustomToast('there was an error');
                  }
                },
                builder: (context, state) {
                  return MyElevatedButton(
                    title: 'logout',
                    isLoading: state is AuthStatusLoading,
                    onPressed:
                        () =>
                            state is AuthStatusLoading
                                ? null
                                : context.cubit<AuthStatusCubit>().logout(),
                  );
                },
              ),
            ],
          ).withAllPadding(24).center(),
    );
  }
}

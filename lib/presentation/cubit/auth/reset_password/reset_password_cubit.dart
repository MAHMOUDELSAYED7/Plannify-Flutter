import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

import '../../../../data/models/auth_model.dart';
import '../../../../data/repositories/auth_repository_impl.dart';

part 'reset_password_state.dart';

class ResetPasswordCubit extends Cubit<ResetPasswordState> {
  final IAuthRepository repository;

  ResetPasswordCubit(this.repository) : super(ResetPasswordInitial());

  Future<void> resetPassword(ResetPasswordRequest request) async {
    emit(ResetPasswordLoading());
    final result = await repository.resetPassword(request);
    result.fold(
      (failure) => emit(ResetPasswordError(failure.message)),
      (response) => emit(ResetPasswordSuccess(response)),
    );
  }

  Future<void> startOtpExpirationTimer() async {
    await Future.delayed(
      const Duration(minutes: 5),
      () => emit(VerifyOtpTimerExpired('OTP expired.')),
    );
  }
}

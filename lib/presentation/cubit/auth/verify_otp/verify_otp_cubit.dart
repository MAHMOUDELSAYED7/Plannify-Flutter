import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

import '../../../../data/models/auth_model.dart';
import '../../../../data/repositories/auth_repository_impl.dart';

part 'verify_otp_state.dart';

class VerifyOtpCubit extends Cubit<VerifyOtpState> {
  final IAuthRepository repository;

  VerifyOtpCubit(this.repository) : super(VerifyOtpInitial());

  Future<void> verifyOtp(VerifyOtpRequest request) async {
    emit(VerifyOtpLoading());
    final result = await repository.verifyOtp(request);
    result.fold((failure) => emit(VerifyOtpError(failure.message)), (response) {
      emit(VerifyOtpSuccess(response));
    });
  }

  Future<void> startOtpExpirationTimer() async {
    await Future.delayed(
      const Duration(minutes: 5),
      () => emit(VerifyOtpTimerExpired('OTP expired.')),
    );
  }
}

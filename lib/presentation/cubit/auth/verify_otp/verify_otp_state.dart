part of 'verify_otp_cubit.dart';

@immutable
abstract class VerifyOtpState {}

class VerifyOtpInitial extends VerifyOtpState {}

class VerifyOtpLoading extends VerifyOtpState {}

class VerifyOtpSuccess extends VerifyOtpState {
  final AuthResponse response;
  VerifyOtpSuccess(this.response);
}

class VerifyOtpError extends VerifyOtpState {
  final String message;
  VerifyOtpError(this.message);
}

import 'package:plannify/core/locator/locator.dart';
import 'package:plannify/data/models/auth_model.dart';
import 'package:plannify/presentation/cubit/auth/verify_otp/verify_otp_cubit.dart';

class VerifyOtpViewModel {
  final VerifyOtpCubit cubit;

  String? email;
  String? otp;
  VerifyOtpViewModel() : cubit = locator<VerifyOtpCubit>();

  Future<void> verifyOtp() async {
    final request = VerifyOtpRequest(
      otp: otp?.trim() ?? '',
      email: email?.trim() ?? '',
    );
    await cubit.verifyOtp(request);
  }
}

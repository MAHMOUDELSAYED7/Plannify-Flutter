import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:plannify/core/errors/error_handler.dart';

import '../../../../data/models/auth_model.dart';
import '../../../../data/repositories/auth_repository_impl.dart';

part 'verify_otp_state.dart';

class VerifyOtpCubit extends Cubit<VerifyOtpState> {
  final IAuthRepository repository;

  VerifyOtpCubit(this.repository) : super(VerifyOtpInitial());

  Future<void> verifyOtp(VerifyOtpRequest request) async {
    emit(VerifyOtpLoading());
    final result = await repository.verifyOtp(request);
    result.fold(
      (failure) =>
          emit(VerifyOtpError(ErrorHandler.handleError(failure).message)),
      (response) => emit(VerifyOtpSuccess(response)),
    );
  }
}

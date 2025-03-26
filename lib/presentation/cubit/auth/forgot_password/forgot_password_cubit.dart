import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:plannify/core/errors/error_handler.dart';

import '../../../../data/models/auth_model.dart';
import '../../../../data/repositories/auth_repository_impl.dart';

part 'forgot_password_state.dart';

class ForgotPasswordCubit extends Cubit<ForgotPasswordState> {
  final IAuthRepository repository;

  ForgotPasswordCubit(this.repository) : super(ForgotPasswordInitial());

  Future<void> forgotPassword(ForgotPasswordRequest request) async {
    emit(ForgotPasswordLoading());
    final result = await repository.forgotPassword(request);
    result.fold(
      (failure) =>
          emit(ForgotPasswordError(ErrorHandler.handleError(failure).message)),
      (response) => emit(ForgotPasswordSuccess(response)),
    );
  }
}

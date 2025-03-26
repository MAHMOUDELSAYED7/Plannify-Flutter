import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:plannify/core/errors/app_exceptions.dart';
import 'package:plannify/core/errors/error_handler.dart';

import '../../../../core/errors/failure.dart';
import '../../../../data/models/auth_model.dart';
import '../../../../data/repositories/auth_repository_impl.dart';

part 'login_state.dart';

class LoginCubit extends Cubit<LoginState> {
  final IAuthRepository repository;

  LoginCubit(this.repository) : super(LoginInitial());

  Future<void> login(LoginRequest request) async {
    emit(LoginLoading());
    final result = await repository.login(request);
    result.fold(
      (failure) => emit(LoginError(ErrorHandler.handleError(failure).message)),
      (response) => emit(LoginSuccess(response)),
    );
  }
}

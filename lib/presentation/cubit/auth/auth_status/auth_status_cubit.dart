import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

import '../../../../core/errors/error_handler.dart';
import '../../../../core/security/secure_storage_repository.dart';

part 'auth_status_state.dart';

class AuthStatusCubit extends Cubit<AuthStatusState> {
  final SecureStorageManager _secureStorage;

  AuthStatusCubit(this._secureStorage) : super(AuthStatusInitial()) {
    checkAuthStatus();
  }

  Future<void> checkAuthStatus() async {
    emit(AuthStatusLoading());
    try {
      final token = await _secureStorage.getAuthToken();
      if (token != null && token.isNotEmpty) {
        emit(AuthStatusAuthenticated());
      } else {
        emit(AuthStatusUnauthenticated());
      }
    } catch (e) {
      emit(AuthStatusError(ErrorHandler.handleError(e).message));
    }
  }

  Future<void> logout() async {
    emit(AuthStatusLoading());
    try {
      await _secureStorage.clearUserData();
      emit(AuthStatusUnauthenticated());
    } catch (e) {
      emit(AuthStatusError(ErrorHandler.handleError(e).message));
    }
  }
}

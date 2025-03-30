import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

import '../../../../core/errors/failure.dart';
import '../../../../core/security/secure_storage_repository.dart';

part 'auth_status_state.dart';

class AuthStatusCubit extends Cubit<AuthStatusState> {
  final SecureStorageManager _secureStorage;

  AuthStatusCubit(this._secureStorage) : super(AuthStatusInitial());

  Future<void> checkAuthStatus() async {
    emit(AuthStatusLoading());
    try {
      await Future.delayed(Duration(seconds: 2));
      final token = await _secureStorage.getAuthToken();
      if (token != null && token.isNotEmpty) {
        emit(AuthStatusAuthenticated());
      } else {
        emit(AuthStatusUnauthenticated());
      }
    } on Failure catch (err) {
      emit(AuthStatusError(err.message));
    }
  }

  Future<void> logout() async {
    emit(AuthStatusLoading());
    try {
      await _secureStorage.clearUserData();
      await Future.delayed(Duration(seconds: 1));
      emit(AuthStatusUnauthenticated());
    } on Failure catch (err) {
      emit(AuthStatusError(err.message));
    }
  }
}

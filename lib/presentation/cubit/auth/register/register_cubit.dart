import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

import '../../../../data/models/auth_model.dart';
import '../../../../data/repositories/auth_repository_impl.dart';

part 'register_state.dart';

class RegisterCubit extends Cubit<RegisterState> {
  final IAuthRepository repository;

  RegisterCubit(this.repository) : super(RegisterInitial());

  Future<void> register(RegisterRequest request) async {
    emit(RegisterLoading());
    final result = await repository.register(request);
    result.fold(
      (failure) {
          if (failure.code == 403) {
        emit(EmailNotVerified(failure.message));
        return;
      }
        emit(RegisterError(failure.message));
      },
      (response) => emit(RegisterSuccess(response)),
    );
  }
}

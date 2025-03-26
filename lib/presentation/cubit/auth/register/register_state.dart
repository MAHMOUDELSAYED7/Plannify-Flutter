part of 'register_cubit.dart';

@immutable
abstract class RegisterState {}

class RegisterInitial extends RegisterState {}

class RegisterLoading extends RegisterState {}

class RegisterSuccess extends RegisterState {
  final AuthResponse response;
  RegisterSuccess(this.response);
}

class RegisterError extends RegisterState {
  final String message;
  RegisterError(this.message);
}

part of 'auth_status_cubit.dart';

@immutable
abstract class AuthStatusState {}

class AuthStatusInitial extends AuthStatusState {}

class AuthStatusLoading extends AuthStatusState {}

class AuthStatusAuthenticated extends AuthStatusState {}

class AuthStatusUnauthenticated extends AuthStatusState {}

class AuthStatusError extends AuthStatusState {
  final String message;
  AuthStatusError(this.message);
}

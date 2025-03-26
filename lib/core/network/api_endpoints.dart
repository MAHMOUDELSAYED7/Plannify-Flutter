import 'package:flutter_dotenv/flutter_dotenv.dart';

class ApiEndpoints {
  const ApiEndpoints._();

  static String baseUrl = dotenv.env['BASE_URL']!;
  static const String login = '/api/auth/login';
  static const String register = '/api/auth/register';
  static const String verifyOtp = '/api/auth/verify-otp';
  static const String forgotPassword = '/api/auth/forgot-password';
  static const String resetPassword = '/api/auth/reset-password';
  static const String todos = '/api/todos';
}

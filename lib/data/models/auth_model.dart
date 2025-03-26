class AuthResponse {
  final String? token;
  final String? message;

  AuthResponse({this.message, this.token});

  factory AuthResponse.fromJson(Map<String, dynamic> json) =>
      AuthResponse(token: json['token'], message: json['message']);
}

class LoginRequest {
  final String email;
  final String password;

  LoginRequest({required this.email, required this.password});

  Map<String, dynamic> toJson() => {'email': email, 'password': password};
}

class RegisterRequest {
  final String username;
  final String email;
  final String password;

  RegisterRequest({
    required this.username,
    required this.email,
    required this.password,
  });

  Map<String, dynamic> toJson() => {
    'username': username,
    'email': email,
    'password': password,
  };
}

class VerifyOtpRequest {
  final String email;
  final String otp;

  VerifyOtpRequest({required this.email, required this.otp});

  Map<String, dynamic> toJson() => {'email': email, 'otp': otp};
}

class ForgotPasswordRequest {
  final String email;

  ForgotPasswordRequest({required this.email});

  Map<String, dynamic> toJson() => {'email': email};
}

class ResetPasswordRequest {
  final String email;
  final String otp;
  final String newPassword;

  ResetPasswordRequest({
    required this.email,
    required this.otp,
    required this.newPassword,
  });

  Map<String, dynamic> toJson() => {
    'email': email,
    'otp': otp,
    'newPassword': newPassword,
  };
}

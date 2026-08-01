class Endpoints {
  static const base = 'https://dummyjson.com';

  // Authentication
  static const String register = '/auth/register/';
  static const String login = '/auth/login';
  static const String currentUser = '/auth/me';
  static const String forgotPassword = '/auth/forgot_password/';
  static const String resetPassword = '/auth/reset_password/';
  static const String refreshToken = '/auth/refresh';

  // OTP
  static const String verifyOtp = '/otp/verify_otp/';
  static const String resendOtp = '/otp/resend_otp/';
}

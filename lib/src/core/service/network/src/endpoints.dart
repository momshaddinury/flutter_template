class Endpoints {
  static const base = "https://dummyjson.com";

  /// Authentication
  static const String register = '/auth/register/';
  static const String login = '/user/login';
  static const String forgotPassword = '/auth/forgot_password/';
  static const String resetPassword = '/auth/reset_password/';

  /// OTP
  static const String verifyOtp = '/otp/verify_otp/';
  static const String resendOtp = '/otp/resend_otp/';
}

// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for English (`en`).
class AppLocalizationsEn extends AppLocalizations {
  AppLocalizationsEn([String locale = 'en']) : super(locale);

  @override
  String get home => 'Home';

  @override
  String get profile => 'Profile';

  @override
  String get login => 'Login';

  @override
  String get createNewPassword => 'Create New password';

  @override
  String get createNewPasswordHint =>
      'Your new password must be different from previous used passwords.';

  @override
  String get resetPassword => 'Reset Password';

  @override
  String get newPassword => 'New Password';

  @override
  String get passwordChangeSuccess => 'Password Changed Successfully';

  @override
  String get emailRequired => 'Email is required';

  @override
  String get passwordRequired => 'Password is required';

  @override
  String get isRequired => 'This field is required';

  @override
  String get validEmail => 'Please enter valid email address';

  @override
  String get enterAssociatedEmail =>
      'Enter the email associated with your account and we’ll send an email with instructions to reset your password.';

  @override
  String minLengthValidation(int min) {
    return 'This field must be at least $min characters long';
  }

  @override
  String maxLengthValidation(int max) {
    return 'This field must be at most $max characters long';
  }

  @override
  String get yourPasswordChanged =>
      'Your password has been changed successfully.';

  @override
  String get confirmPassword => 'Confirm Password';

  @override
  String get logout => 'Logout';

  @override
  String get getStarted => 'Get Started';

  @override
  String get rememberMe => 'Remember me';

  @override
  String get forgotPassword => 'Forgot password';

  @override
  String get backToLogin => 'Back to login';

  @override
  String get continueAction => 'Continue';

  @override
  String get signUp => 'Sign up';

  @override
  String get signIn => 'Sign in';

  @override
  String get email => 'Email';

  @override
  String get emailAddress => 'Email Address';

  @override
  String get password => 'Password';

  @override
  String get firstName => 'First Name';

  @override
  String get lastName => 'Last Name';

  @override
  String get dontHaveAccount => 'Don\'t have an account? ';

  @override
  String get alreadyHaveAccount => 'Already have an account? ';

  @override
  String get checkYourMail => 'Check your mail';

  @override
  String get enterVerificationCode =>
      'Please enter 4 digit code sent to your mail hello**@gmail.com.';

  @override
  String get didntGetCode => 'Didn\'t get a code? ';

  @override
  String get clickToResend => 'Click to resend';

  @override
  String get didNotReceiveEmail =>
      'Did not receive the email? Check your spam filter. or ';

  @override
  String get tryAnotherEmail => 'try another email address';

  @override
  String get learnFlutterTitle => 'Learn Flutter with comprehensive tutorials.';

  @override
  String get learnFlutterSubtitle =>
      'Step-by-step guides for building Flutter apps.';

  @override
  String get learnFlutterDescription =>
      'Get notifications for new tutorials and updates.';

  @override
  String get joinCommunityTitle => 'Join the Flutter community.';

  @override
  String get joinCommunitySubtitle => 'Connect with other Flutter developers.';

  @override
  String get joinCommunityDescription =>
      'Participate in community events and discussions.';

  @override
  String get buildDeployTitle => 'Build and deploy Flutter apps easily.';

  @override
  String get buildDeploySubtitle =>
      'Access tools and resources for app development.';

  @override
  String get buildDeployDescription =>
      'Deploy your apps to multiple platforms with ease.';

  @override
  String get english => 'English';

  @override
  String get bangla => 'বাংলা';

  @override
  String get arabic => 'العربية';

  @override
  String passwordMinLengthValidation(String minLength) {
    return 'Password must be at least $minLength characters';
  }

  @override
  String get passwordNumberValidation =>
      'Password must contain at least one number';

  @override
  String get passwordLowerCaseValidation =>
      'Password must contain at least one lowercase letter';

  @override
  String get passwordUpperCaseValidation =>
      'Password must contain at least one uppercase letter';

  @override
  String get passwordSpecialCharValidation =>
      'Password must contain at least one special character';
}

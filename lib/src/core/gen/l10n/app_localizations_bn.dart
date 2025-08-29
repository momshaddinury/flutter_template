// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Bengali Bangla (`bn`).
class AppLocalizationsBn extends AppLocalizations {
  AppLocalizationsBn([String locale = 'bn']) : super(locale);

  @override
  String get home => 'হোম';

  @override
  String get profile => 'প্রোফাইল';

  @override
  String get login => 'লগইন';

  @override
  String get createNewPassword => 'নতুন পাসওয়ার্ড তৈরি করুন';

  @override
  String get createNewPasswordHint =>
      'আপনার নতুন পাসওয়ার্ড আগে ব্যবহৃত পাসওয়ার্ড থেকে আলাদা হতে হবে।';

  @override
  String get resetPassword => 'পাসওয়ার্ড রিসেট করুন';

  @override
  String get newPassword => 'নতুন পাসওয়ার্ড';

  @override
  String get passwordChangeSuccess => 'পাসওয়ার্ড সফলভাবে পরিবর্তন করা হয়েছে';

  @override
  String get emailRequired => 'ইমেইল প্রয়োজন';

  @override
  String get passwordRequired => 'পাসওয়ার্ড প্রয়োজন';

  @override
  String get isRequired => 'এই ক্ষেত্রটি প্রয়োজন';

  @override
  String get validEmail => 'অনুগ্রহ করে একটি বৈধ ইমেইল ঠিকানা দিন';

  @override
  String get enterAssociatedEmail =>
      'আপনার অ্যাকাউন্টের সাথে যুক্ত ইমেইল দিন এবং আমরা আপনার পাসওয়ার্ড রিসেট করার নির্দেশনা সহ একটি ইমেইল পাঠাব।';

  @override
  String minLengthValidation(int min) {
    return 'এই ক্ষেত্রটি কমপক্ষে $min অক্ষর দীর্ঘ হতে হবে';
  }

  @override
  String maxLengthValidation(int max) {
    return 'এই ক্ষেত্রটি সর্বাধিক $max অক্ষর দীর্ঘ হতে হবে';
  }

  @override
  String get yourPasswordChanged =>
      'আপনার পাসওয়ার্ড সফলভাবে পরিবর্তন করা হয়েছে।';

  @override
  String get confirmPassword => 'পাসওয়ার্ড নিশ্চিত করুন';

  @override
  String get logout => 'লগআউট';

  @override
  String get getStarted => 'শুরু করুন';

  @override
  String get rememberMe => 'আমাকে মনে রাখুন';

  @override
  String get forgotPassword => 'পাসওয়ার্ড ভুলে গেছেন';

  @override
  String get backToLogin => 'লগইনে ফিরে যান';

  @override
  String get continueAction => 'চালিয়ে যান';

  @override
  String get signUp => 'সাইন আপ';

  @override
  String get signIn => 'সাইন ইন';

  @override
  String get email => 'ইমেইল';

  @override
  String get emailAddress => 'ইমেইল ঠিকানা';

  @override
  String get password => 'পাসওয়ার্ড';

  @override
  String get firstName => 'প্রথম নাম';

  @override
  String get lastName => 'শেষ নাম';

  @override
  String get dontHaveAccount => 'অ্যাকাউন্ট নেই? ';

  @override
  String get alreadyHaveAccount => 'ইতিমধ্যে অ্যাকাউন্ট আছে? ';

  @override
  String get checkYourMail => 'আপনার মেইল চেক করুন';

  @override
  String get enterVerificationCode =>
      'অনুগ্রহ করে আপনার মেইলে পাঠানো 4 অঙ্কের কোড দিন hello**@gmail.com।';

  @override
  String get didntGetCode => 'কোড পাননি? ';

  @override
  String get clickToResend => 'পুনরায় পাঠাতে ক্লিক করুন';

  @override
  String get didNotReceiveEmail =>
      'ইমেইল পাননি? আপনার স্প্যাম ফিল্টার চেক করুন। অথবা ';

  @override
  String get tryAnotherEmail => 'অন্য ইমেইল ঠিকানা চেষ্টা করুন';

  @override
  String get learnFlutterTitle => 'ব্যাপক টিউটোরিয়াল সহ Flutter শিখুন।';

  @override
  String get learnFlutterSubtitle =>
      'Flutter অ্যাপ তৈরি করার জন্য ধাপে ধাপে গাইড।';

  @override
  String get learnFlutterDescription =>
      'নতুন টিউটোরিয়াল এবং আপডেটের জন্য বিজ্ঞপ্তি পান।';

  @override
  String get joinCommunityTitle => 'Flutter সম্প্রদায়ে যোগ দিন।';

  @override
  String get joinCommunitySubtitle =>
      'অন্যান্য Flutter ডেভেলপারদের সাথে সংযুক্ত হন।';

  @override
  String get joinCommunityDescription =>
      'সম্প্রদায়ের ইভেন্ট এবং আলোচনায় অংশগ্রহণ করুন।';

  @override
  String get buildDeployTitle => 'সহজে Flutter অ্যাপ তৈরি এবং ডেপ্লয় করুন।';

  @override
  String get buildDeploySubtitle =>
      'অ্যাপ ডেভেলপমেন্টের জন্য টুল এবং সম্পদ অ্যাক্সেস করুন।';

  @override
  String get buildDeployDescription =>
      'সহজে একাধিক প্ল্যাটফর্মে আপনার অ্যাপ ডেপ্লয় করুন।';

  @override
  String get english => 'English';

  @override
  String get bangla => 'বাংলা';

  @override
  String get arabic => 'العربية';

  @override
  String passwordMinLengthValidation(String minLength) {
    return 'পাসওয়ার্ড কমপক্ষে $minLength অক্ষর দীর্ঘ হতে হবে';
  }

  @override
  String get passwordNumberValidation =>
      'পাসওয়ার্ডে কমপক্ষে একটি সংখ্যা থাকতে হবে';

  @override
  String get passwordLowerCaseValidation =>
      'পাসওয়ার্ডে কমপক্ষে একটি ছোট হাতের অক্ষর থাকতে হবে';

  @override
  String get passwordUpperCaseValidation =>
      'পাসওয়ার্ডে কমপক্ষে একটি বড় হাতের অক্ষর থাকতে হবে';

  @override
  String get passwordSpecialCharValidation =>
      'পাসওয়ার্ডে কমপক্ষে একটি বিশেষ অক্ষর থাকতে হবে';
}

// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Arabic (`ar`).
class AppLocalizationsAr extends AppLocalizations {
  AppLocalizationsAr([String locale = 'ar']) : super(locale);

  @override
  String get home => 'الرئيسية';

  @override
  String get profile => 'الملف الشخصي';

  @override
  String get login => 'تسجيل الدخول';

  @override
  String get createNewPassword => 'إنشاء كلمة مرور جديدة';

  @override
  String get createNewPasswordHint =>
      'يجب أن تكون كلمة المرور الجديدة مختلفة عن كلمات المرور المستخدمة سابقاً.';

  @override
  String get resetPassword => 'إعادة تعيين كلمة المرور';

  @override
  String get newPassword => 'كلمة المرور الجديدة';

  @override
  String get passwordChangeSuccess => 'تم تغيير كلمة المرور بنجاح';

  @override
  String get emailRequired => 'البريد الإلكتروني مطلوب';

  @override
  String get passwordRequired => 'كلمة المرور مطلوبة';

  @override
  String get isRequired => 'هذا الحقل مطلوب';

  @override
  String get validEmail => 'يرجى إدخال عنوان بريد إلكتروني صحيح';

  @override
  String get enterAssociatedEmail =>
      'أدخل البريد الإلكتروني المرتبط بحسابك وسنرسل لك بريداً إلكترونياً مع تعليمات لإعادة تعيين كلمة المرور.';

  @override
  String minLengthValidation(int min) {
    return 'يجب أن يحتوي هذا الحقل على $min أحرف على الأقل';
  }

  @override
  String maxLengthValidation(int max) {
    return 'يجب أن يحتوي هذا الحقل على $max أحرف كحد أقصى';
  }

  @override
  String get yourPasswordChanged => 'تم تغيير كلمة المرور بنجاح.';

  @override
  String get confirmPassword => 'تأكيد كلمة المرور';

  @override
  String get logout => 'تسجيل الخروج';

  @override
  String get getStarted => 'ابدأ';

  @override
  String get rememberMe => 'تذكرني';

  @override
  String get forgotPassword => 'نسيت كلمة المرور';

  @override
  String get backToLogin => 'العودة إلى تسجيل الدخول';

  @override
  String get continueAction => 'متابعة';

  @override
  String get signUp => 'إنشاء حساب';

  @override
  String get signIn => 'تسجيل الدخول';

  @override
  String get email => 'البريد الإلكتروني';

  @override
  String get emailAddress => 'عنوان البريد الإلكتروني';

  @override
  String get password => 'كلمة المرور';

  @override
  String get firstName => 'الاسم الأول';

  @override
  String get lastName => 'اسم العائلة';

  @override
  String get dontHaveAccount => 'ليس لديك حساب؟ ';

  @override
  String get alreadyHaveAccount => 'لديك حساب بالفعل؟ ';

  @override
  String get checkYourMail => 'تحقق من بريدك الإلكتروني';

  @override
  String get enterVerificationCode =>
      'يرجى إدخال الرمز المكون من 4 أرقام المرسل إلى بريدك الإلكتروني hello**@gmail.com.';

  @override
  String get didntGetCode => 'لم تحصل على رمز؟ ';

  @override
  String get clickToResend => 'انقر لإعادة الإرسال';

  @override
  String get didNotReceiveEmail =>
      'لم تستلم البريد الإلكتروني؟ تحقق من مجلد الرسائل غير المرغوب فيها. أو ';

  @override
  String get tryAnotherEmail => 'جرب عنوان بريد إلكتروني آخر';

  @override
  String get learnFlutterTitle => 'تعلم Flutter مع دروس شاملة.';

  @override
  String get learnFlutterSubtitle => 'دليل خطوة بخطوة لبناء تطبيقات Flutter.';

  @override
  String get learnFlutterDescription =>
      'احصل على إشعارات للدروس الجديدة والتحديثات.';

  @override
  String get joinCommunityTitle => 'انضم إلى مجتمع Flutter.';

  @override
  String get joinCommunitySubtitle => 'تواصل مع مطوري Flutter الآخرين.';

  @override
  String get joinCommunityDescription => 'شارك في أحداث المجتمع والمناقشات.';

  @override
  String get buildDeployTitle => 'ابن ونشر تطبيقات Flutter بسهولة.';

  @override
  String get buildDeploySubtitle => 'احصل على أدوات وموارد لتطوير التطبيقات.';

  @override
  String get buildDeployDescription => 'انشر تطبيقاتك على منصات متعددة بسهولة.';

  @override
  String get english => 'English';

  @override
  String get bangla => 'বাংলা';

  @override
  String get arabic => 'العربية';

  @override
  String passwordMinLengthValidation(String minLength) {
    return 'يجب أن تحتوي كلمة المرور على $minLength أحرف على الأقل';
  }

  @override
  String get passwordNumberValidation =>
      'يجب أن تحتوي كلمة المرور على رقم واحد على الأقل';

  @override
  String get passwordLowerCaseValidation =>
      'يجب أن تحتوي كلمة المرور على حرف صغير واحد على الأقل';

  @override
  String get passwordUpperCaseValidation =>
      'يجب أن تحتوي كلمة المرور على حرف كبير واحد على الأقل';

  @override
  String get passwordSpecialCharValidation =>
      'يجب أن تحتوي كلمة المرور على رمز خاص واحد على الأقل';
}

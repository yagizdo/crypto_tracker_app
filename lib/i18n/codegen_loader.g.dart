// DO NOT EDIT. This is code generated via package:easy_localization/generate.dart

// ignore_for_file: prefer_single_quotes

import 'dart:ui';

import 'package:easy_localization/easy_localization.dart' show AssetLoader;

class CodegenLoader extends AssetLoader{
  const CodegenLoader();

  @override
  Future<Map<String, dynamic>> load(String fullPath, Locale locale ) {
    return Future.value(mapLocales[locale.toString()]);
  }

  static const Map<String,dynamic> tr = {
  "errors": {
    "invalid_email": "E-posta adresiniz geçersiz.",
    "wrong_password": "E-posta adresi veya şifre yanlış.",
    "user_disabled": "Kullanıcı hesabı aktif değil.",
    "password_not_enough": "Parolanız 6 karakterden uzun olmalıdır.",
    "invalid_verification_code": "Girdiğiniz kod yanlıştır.",
    "invalid_phone_number": "Telefon numaranız geçersiz.",
    "too_many_requests": "Çok fazla istek gönderildi. Lütfen daha sonra tekrar deneyin.",
    "operation_not_allowed": "E-posta adresiyle girişe izin verilmiyor.",
    "email_already_exists": "Bu E-posta adresiyle daha önce hesap oluşturulmuş. Lütfen başka bir e-posta adresi kullanın.",
    "account_already_exists": "Bu E-posta adresiyle daha önce hesap oluşturulmuş. Lütfen başka bir e-posta adresi kullanın.",
    "credential_already_in_use": "Bu giriş kimliği başka bir hesapla ilişkilendirilmiş. Lütfen başka bir hesapla giriş yapmayı deneyin.",
    "invalid_credential": "Bu giriş yönteminde bir sorun var. Lütfen farklı bir giriş yöntemi seçiniz.",
    "aborted_by_user": "Giriş kullanıcı tarafından iptal edildi.",
    "expired_action_code": "Sifre sifirlama kodunuzun suresi doldu.",
    "invalid_verification_id": "ID valid degil.",
    "apple_unknown": "Apple tarafinda tanimlanamayan bir hata olustu.",
    "apple_cancelled": "Kullanıcı, yetkilendirme girişimini iptal etti.",
    "apple_invalid_response": "Gecersiz istek.",
    "apple_not_handled": "Tanimlanmamis bir hata olustu.",
    "apple_not_interactive": "Yetkilendirme talebi etkileşimli değildir.",
    "apple_failed": "Yetkilendirme girişimi başarısız oldu.",
    "apple_credential_error": "Apple yetkilendirme kimlik bilgileri alınamadı.",
    "undefinied": "Tanımlanamayan bir hata oluştu.",
    "email_send": "E-posta adresi geçerliyse, kısa süre içinde bir şifre sıfırlama e-postası alacaksınız.",
    "apple_unsupported_device": "Bu cihaz, apple oturum açma için uygun değildir."
  }
};
static const Map<String,dynamic> en = {
  "errors": {
    "invalid_email": "Your e-mail address is invalid.",
    "wrong_password": "Email address or password is incorrect.",
    "user_disabled": "User account is not active.",
    "password_not_enough": "Your password must be longer than 6 characters.",
    "invalid_verification_code": "The code you entered is incorrect.",
    "invalid_phone_number": "Your phone number is invalid.",
    "too_many_requests": "Too many requests sent. Please try again later.",
    "operation_not_allowed": "Login with e-mail address is not allowed.",
    "email_already_exists": "An account has already been created with this E-mail address. Please use another email address.",
    "account_already_exists": "An account has already been created with this E-mail address. Please use another email address.",
    "credential_already_in_use": "This login ID is associated with another account. Please try logging in with another account.",
    "invalid_credential": "There is a problem with this input method. Please choose a different input method.",
    "aborted_by_user": "Login canceled by user.",
    "expired_action_code": "Your password reset code has expired.",
    "invalid_verification_id": "ID is not valid.",
    "apple_unknown": "An error occurred that cannot be identified by Apple.",
    "apple_cancelled": "The user canceled the authorization attempt.",
    "apple_invalid_response": "Invalid request.",
    "apple_not_handled": "An unidentified error has occurred.",
    "apple_not_interactive": "The authorization request is not interactive.",
    "apple_failed": "The authorization attempt failed.",
    "apple_credential_error": "Failed to retrieve Apple authorization credentials.",
    "undefinied": "An unidentified error has occurred.",
    "email_send": "If the email address is valid, you will receive a password reset email shortly.",
    "apple_unsupported_device": "This device is not suitable for apple sign in."
  }
};
static const Map<String, Map<String,dynamic>> mapLocales = {"tr": tr, "en": en};
}

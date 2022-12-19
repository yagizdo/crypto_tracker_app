import 'package:crypto_tracker/i18n/locale_keys.g.dart';
import 'package:easy_localization/easy_localization.dart';

import '../utils/extensions/validation_query.dart';

class Validator {

  static String? email(String? value) {
    if (ValidationQuery.emailValidationQuery.hasMatch(value!)) {
      return null;
    }
    return LocaleKeys.errors_auth_validation_valid_email.tr();
  }

  static String? name(String? value) {
    if (value == null || value.isEmpty) {
      return LocaleKeys.errors_auth_validation_empty_error.tr();
    } else if (value.length < 3) {
      return LocaleKeys.errors_auth_validation_name_length.tr();
    }
    return null;
  }

  static String? password(String? value) {
    if (value == null || value.isEmpty) {
      return LocaleKeys.errors_auth_validation_empty_error.tr();
    } else if (value.length < 6) {
      return LocaleKeys.errors_auth_validation_pw_length.tr();
    }
    return null;
  }

  static String? passwordsMatch(String? value, String? passwordOne, String? passwordTwo) {
    if (value == null || value.isEmpty) {
      return LocaleKeys.errors_auth_validation_empty_error.tr();
    } else if (value.length < 6) {
      return LocaleKeys.errors_auth_validation_pw_length.tr();
    } else if (passwordOne != passwordTwo) {
      return LocaleKeys.errors_auth_validation_pw_match.tr();
    }
    return null;
  }
}
import 'package:crypto_tracker/i18n/locale_keys.g.dart';
import 'package:easy_localization/easy_localization.dart';

enum AuthResultStatus {
  successful,
  emailAlreadyExists,
  wrongPassword,
  invalidEmail,
  userNotFound,
  userDisabled,
  operationNotAllowed,
  tooManyRequests,
  undefined,
  invalidCredential,
  abortedByUser,
  accountAlreadyExist,
  credentialAlreadyInUse,
  passwordNotEnough,
  invalidPhoneNumber,
  invalidVerificationCode,
  invalidVerificationId,
  expiredActionCode,
  appleUnknown,
  appleInvalidResponse,
  appleCancelled,
  appleFailed,
  appleNotHandled,
  appleNotInteractive,
  appleCredentialError,
}

class AuthExceptionHandler {
  static dynamic handleException(e) {
    AuthResultStatus status;
    switch (e.code.toString()) {
      case 'invalid-email':
        status = AuthResultStatus.invalidEmail;
        break;
      case 'invalid-phone-number':
        status = AuthResultStatus.invalidPhoneNumber;
        break;
      case 'invalid-verification-code':
        status = AuthResultStatus.invalidVerificationCode;
        break;
      case 'weak-password':
        status = AuthResultStatus.passwordNotEnough;
        break;
      case 'ınvalıd-emaıl':
        status = AuthResultStatus.invalidEmail;
        break;
      case 'wrong-password':
        status = AuthResultStatus.wrongPassword;
        break;
      case 'user-not-found':
        status = AuthResultStatus.userNotFound;
        break;
      case 'user-disabled':
        status = AuthResultStatus.userDisabled;
        break;
      case 'too-many-requests':
        status = AuthResultStatus.tooManyRequests;
        break;
      case 'operation-not-allowed':
        status = AuthResultStatus.operationNotAllowed;
        break;
      case 'email-already-in-use':
        status = AuthResultStatus.emailAlreadyExists;
        break;
      case 'invalid-credential':
        status = AuthResultStatus.invalidCredential;
        break;
      case 'ERROR_INVALID_CREDENTIAL':
        status = AuthResultStatus.invalidCredential;
        break;
      case 'aborted-by-user':
        status = AuthResultStatus.abortedByUser;
        break;
      case 'credential-already-in-use':
        status = AuthResultStatus.credentialAlreadyInUse;
        break;
      case 'account-exists-with-different-credential':
        status = AuthResultStatus.accountAlreadyExist;
        break;
      case 'expired-action-code':
        status = AuthResultStatus.expiredActionCode;
        break;
      case 'invalid-verification-id':
        status = AuthResultStatus.invalidVerificationId;
        break;
      // Apple Sign In Start //
      case 'AuthorizationErrorCode.canceled':
        status = AuthResultStatus.appleCancelled;
        break;
      case 'AuthorizationErrorCode.unknown':
        status = AuthResultStatus.appleUnknown;
        break;
      case 'AuthorizationErrorCode.failed':
        status = AuthResultStatus.appleFailed;
        break;
      case 'AuthorizationErrorCode.invalidResponse':
        status = AuthResultStatus.appleInvalidResponse;
        break;
      case 'AuthorizationErrorCode.notHandled':
        status = AuthResultStatus.appleNotHandled;
        break;
      case 'AuthorizationErrorCode.notInteractive':
        status = AuthResultStatus.appleNotInteractive;
        break;
      case 'credentials-error':
        status = AuthResultStatus.appleCredentialError;
        break;
      // Apple Sign In End //
      default:
        status = AuthResultStatus.undefined;
    }
    return status;
  }

  ///
  /// Accepts AuthExceptionHandler.errorType
  ///
  static String generateExceptionMessage(e) {
    AuthResultStatus exceptionStatus = handleException(e);
    String errorMessage;
    switch (exceptionStatus) {
      case AuthResultStatus.invalidEmail:
        errorMessage = LocaleKeys.errors_invalid_email.tr();
        break;
      case AuthResultStatus.passwordNotEnough:
        errorMessage = LocaleKeys.errors_password_not_enough.tr();
        break;
      case AuthResultStatus.invalidVerificationCode:
        errorMessage = LocaleKeys.errors_invalid_verification_code.tr();
        break;
      case AuthResultStatus.invalidPhoneNumber:
        errorMessage = LocaleKeys.errors_invalid_phone_number.tr();
        break;
      case AuthResultStatus.wrongPassword:
        errorMessage = LocaleKeys.errors_wrong_password.tr();
        break;
      case AuthResultStatus.userNotFound:
        errorMessage = LocaleKeys.errors_wrong_password.tr();
        break;
      case AuthResultStatus.userDisabled:
        errorMessage = LocaleKeys.errors_user_disabled.tr();
        break;
      case AuthResultStatus.tooManyRequests:
        errorMessage =
            LocaleKeys.errors_too_many_requests.tr();
        break;
      case AuthResultStatus.operationNotAllowed:
        errorMessage = LocaleKeys.errors_operation_not_allowed.tr();
        break;
      case AuthResultStatus.emailAlreadyExists:
        errorMessage =
            LocaleKeys.errors_email_already_exists.tr();
        break;
      case AuthResultStatus.accountAlreadyExist:
        errorMessage =
            LocaleKeys.errors_account_already_exists.tr();
        break;
      case AuthResultStatus.credentialAlreadyInUse:
        errorMessage =
            LocaleKeys.errors_credential_already_in_use.tr();
        break;
      case AuthResultStatus.invalidCredential:
        errorMessage =
            LocaleKeys.errors_invalid_credential.tr();
        break;
      case AuthResultStatus.abortedByUser:
        errorMessage = LocaleKeys.errors_aborted_by_user.tr();
        break;
      case AuthResultStatus.expiredActionCode:
        errorMessage = LocaleKeys.errors_expired_action_code.tr();
        break;
      case AuthResultStatus.invalidVerificationId:
        errorMessage = LocaleKeys.errors_invalid_verification_id.tr();
        break;

      // Apple Sign In Start //
      case AuthResultStatus.appleUnknown:
        errorMessage = LocaleKeys.errors_apple_unknown.tr();
        break;
      case AuthResultStatus.appleCancelled:
        errorMessage = LocaleKeys.errors_apple_cancelled.tr();
        break;
      case AuthResultStatus.appleInvalidResponse:
        errorMessage = LocaleKeys.errors_apple_invalid_response.tr();
        break;
      case AuthResultStatus.appleNotHandled:
        errorMessage = LocaleKeys.errors_apple_not_handled.tr();
        break;
      case AuthResultStatus.appleNotInteractive:
        errorMessage = LocaleKeys.errors_apple_not_interactive.tr();
        break;
      case AuthResultStatus.appleFailed:
        errorMessage = LocaleKeys.errors_apple_failed.tr();
        break;
      case AuthResultStatus.appleCredentialError:
        errorMessage = LocaleKeys.errors_apple_credential_error.tr();
        break;
    // Apple Sign In End //
      default:
        errorMessage = LocaleKeys.errors_undefinied.tr();
    }

    return errorMessage;
  }
}

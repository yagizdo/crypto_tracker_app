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
      case 'user-dısabled':
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
      case 'emaıl-already-ın-use':
        status = AuthResultStatus.emailAlreadyExists;
        break;
      case 'invalid-credential':
        status = AuthResultStatus.invalidCredential;
        break;
      case 'ınvalıd-credentıal':
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
      case 'credentıal-already-ın-use':
        status = AuthResultStatus.credentialAlreadyInUse;
        break;
      case 'account-exists-with-different-credential':
        status = AuthResultStatus.accountAlreadyExist;
        break;
      case 'account-exısts-wıth-dıfferent-credentıal':
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
        print('Case ${e} is not yet implemented');
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
        errorMessage = 'E-posta adresiniz geçersiz.';
        break;
      case AuthResultStatus.passwordNotEnough:
        errorMessage = 'Parolanız 6 karakterden uzun olmalıdır';
        break;
      case AuthResultStatus.invalidVerificationCode:
        errorMessage = 'Girdiğiniz kod yanlıştır';
        break;
      case AuthResultStatus.invalidPhoneNumber:
        errorMessage = 'Telefon numaranız geçersiz';
        break;
      case AuthResultStatus.wrongPassword:
        errorMessage = 'E-posta adresi veya şifre yanlış.';
        break;
      case AuthResultStatus.userNotFound:
        errorMessage = 'E-posta adresi veya şifre yanlış.';
        break;
      case AuthResultStatus.userDisabled:
        errorMessage = 'Kullanıcı hesabı aktif değil.';
        break;
      case AuthResultStatus.tooManyRequests:
        errorMessage =
            'Çok fazla istek gönderildi. Lütfen daha sonra tekrar deneyin.';
        break;
      case AuthResultStatus.operationNotAllowed:
        errorMessage = 'E-posta adresiyle girişe izin verilmiyor.';
        break;
      case AuthResultStatus.emailAlreadyExists:
        errorMessage =
            'Bu E-posta adresiyle daha önce hesap oluşturulmuş. Lütfen başka bir e-posta adresi kullanın.';
        break;
      case AuthResultStatus.accountAlreadyExist:
        errorMessage =
            'Kullandığınız e-posta adresiyle başka bir hesap mevcut. Lütfen diğer yöntemlerle giriş yapın.';
        break;
      case AuthResultStatus.credentialAlreadyInUse:
        errorMessage =
            'Bu giriş kimliği başka bir hesapla ilişkilendirilmiş. Lütfen başka bir hesapla giriş yapmayı deneyin';
        break;
      case AuthResultStatus.invalidCredential:
        errorMessage =
            'Bu giriş yönteminde bir sorun var. Lütfen farklı bir giriş yöntemi seçiniz.';
        break;
      case AuthResultStatus.abortedByUser:
        errorMessage = 'Giriş kullanıcı tarafından iptal edildi.';
        break;
      case AuthResultStatus.expiredActionCode:
        errorMessage = 'Sifre sifirlama kodunuzun suresi doldu.';
        break;
      case AuthResultStatus.invalidVerificationId:
        errorMessage = 'ID valid degil.';
        break;

      // Apple Sign In Start //
      case AuthResultStatus.appleUnknown:
        errorMessage = 'Apple tarafinda tanimlanamayan bir hata olustu.';
        break;
      case AuthResultStatus.appleCancelled:
        errorMessage = 'Kullanıcı, yetkilendirme girişimini iptal etti.';
        break;
      case AuthResultStatus.appleInvalidResponse:
        errorMessage = 'Hatali istek.';
        break;
      case AuthResultStatus.appleNotHandled:
        errorMessage = 'Tanimlanmamis bir hata olustu.';
        break;
      case AuthResultStatus.appleNotInteractive:
        errorMessage = 'Yetkilendirme talebi etkileşimli değildir.';
        break;
      case AuthResultStatus.appleFailed:
        errorMessage = 'Yetkilendirme girişimi başarısız oldu.';
        break;
      // Apple Sign In End //
      case AuthResultStatus.appleCredentialError:
        errorMessage = 'Apple yetkilendirme kimlik bilgileri alınamadı.';
        break;
      default:
        errorMessage = 'Tanımsız bir hata oluştu.';
    }

    return errorMessage;
  }
}

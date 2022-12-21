import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'app_colors.dart';

class AppTextStyle {
  AppTextStyle._();

  static TextStyle homeText() {
    return TextStyle(
      color: Colors.white,
      fontSize: 22.sp,
      fontWeight: FontWeight.w700,
      letterSpacing: -0.2.sp,
      overflow: TextOverflow.ellipsis,
    );
  }

  static TextStyle loginViewTitle() {
    return TextStyle(
      color: Colors.white,
      fontSize: 22.sp,
      fontWeight: FontWeight.w700,
      letterSpacing: -0.2.sp,
      overflow: TextOverflow.ellipsis,
    );
  }
  static TextStyle loginBtnTitle() {
    return TextStyle(
      color: AppColors.blackBackground,
      fontSize: 18.sp,
      fontWeight: FontWeight.w700,
      letterSpacing: -0.2.sp,
      overflow: TextOverflow.ellipsis,
    );
  }

  static TextStyle resetPassBackBtn() {
    return TextStyle(
      color: AppColors.white,
      fontSize: 18.sp,
      fontWeight: FontWeight.w700,
      letterSpacing: -0.2.sp,
      overflow: TextOverflow.ellipsis,
    );
  }

  static TextStyle authTextButton() {
    return TextStyle(
      color: Colors.white,
      fontSize: 13.sp,
      fontWeight: FontWeight.w500,
      letterSpacing: -0.2.sp,
      overflow: TextOverflow.ellipsis,
    );
  }
  // Currency Content
  static TextStyle currencyRowItemTitle() {
    return TextStyle(
      color: Colors.white,
      fontSize: 15.sp,
      fontWeight: FontWeight.w500,
      letterSpacing: -0.2.sp,
      overflow: TextOverflow.ellipsis,
    );
  }
  static TextStyle currencyTitle() {
    return TextStyle(
      color: AppColors.blackBackground,
      fontSize: 15.sp,
      fontWeight: FontWeight.w600,
      letterSpacing: -0.2.sp,
      overflow: TextOverflow.ellipsis,
    );
  }

  static TextStyle currencyPrice() {
    return TextStyle(
      color: AppColors.blackBackground,
      fontSize: 15.sp,
      fontWeight: FontWeight.w400,
      letterSpacing: -0.2.sp,
      overflow: TextOverflow.ellipsis,
    );
  }
  static TextStyle currencyChange() {
    return TextStyle(
      color: AppColors.white,
      fontSize: 15.sp,
      fontWeight: FontWeight.w600,
      letterSpacing: -0.2.sp,
      overflow: TextOverflow.ellipsis,
    );
  }


  // Settings
  static TextStyle settingsCardTitle({Color? titleColor}) {
    return TextStyle(
      color: titleColor ?? AppColors.blackBackground,
      fontSize: 15.sp,
      fontWeight: FontWeight.w500,
      letterSpacing: -0.2.sp,
      overflow: TextOverflow.ellipsis,
    );
  }

  static TextStyle settingsCardLangCodeTxt() {
    return TextStyle(
      color: AppColors.blueBackground,
      fontSize: 15.sp,
      fontWeight: FontWeight.w400,
      letterSpacing: -0.2.sp,
      overflow: TextOverflow.ellipsis,
    );
  }
  static TextStyle settingsDeleteAccountBottomSheetTitle() {
    return TextStyle(
      color: AppColors.white,
      fontSize: 20.sp,
      fontWeight: FontWeight.w600,
      letterSpacing: -0.2.sp,
    );
  }

  static TextStyle deleteAccountBtnTitle() {
    return TextStyle(
      color: AppColors.white,
      fontSize: 18.sp,
      fontWeight: FontWeight.w700,
      letterSpacing: -0.2.sp,
      overflow: TextOverflow.ellipsis,
    );
  }

  static TextStyle deleteAccountCancelBtnTitle() {
    return TextStyle(
      color: AppColors.blackBackground,
      fontSize: 18.sp,
      fontWeight: FontWeight.w700,
      letterSpacing: -0.2.sp,
      overflow: TextOverflow.ellipsis,
    );
  }


  static TextStyle settingsDeleteAccountWarning() {
    return TextStyle(
      color: AppColors.white,
      fontSize: 15.sp,
      fontWeight: FontWeight.w400,
      letterSpacing: -0.2.sp,
    );
  }
}

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
}

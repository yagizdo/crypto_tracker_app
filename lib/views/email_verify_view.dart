import 'dart:async';

import 'package:crypto_tracker/services/navigation_service.dart';
import 'package:crypto_tracker/views/base_view.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../i18n/locale_keys.g.dart';
import '../services/auth/auth_service.dart';
import '../services/locator.dart';
import '../utils/app_colors.dart';
import '../utils/app_constants.dart';
import '../utils/extensions/auth_exception_handler.dart';
import '../widgets/main_widgets/main_layout.dart';
import '../widgets/main_widgets/tapWrapper.dart';

class EmailVerifyView extends StatefulWidget {
  const EmailVerifyView({Key? key}) : super(key: key);

  @override
  State<EmailVerifyView> createState() => _EmailVerifyViewState();
}

class _EmailVerifyViewState extends State<EmailVerifyView> {

  final AuthService _authService = getIt<AuthService>();
  Timer? timer;

  Future<bool> getEmailStatus() async {
    return await _authService.getUserEmailStatus();
  }
  @override
  void initState() {
    if (!mounted) return;
    timer = Timer.periodic(
        const Duration(seconds: 3),
            (timer) async {
          await _authService.reloadUser();
          if(await getEmailStatus()){
            timer.cancel();
            if (!mounted) return;
            Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => const BaseView(),),);
          }
        },
      );
    super.initState();
  }

  @override
  void dispose() {
    if(!mounted){
      timer?.cancel();
    }
    timer?.cancel();
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    return MainLayout(
      appBar: AppBar(
        backgroundColor: AppColors.blackBackground,
        title: Text(LocaleKeys.auth_email_verify_title.tr(),style: TextStyle(color: CupertinoColors.white,fontSize: 20.sp,fontWeight: FontWeight.bold)),
      ),
      content: Center(
        child: Column(
          children: [
            height10Per(context: context),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                TapWrapper(
                  onTap: () async {
                    await _authService.sendVerificationMail();
                  },
                  child: Container(
                    alignment: Alignment.center,
                    width: 150.w,
                    height: 40.w,
                    decoration: BoxDecoration(color: Colors.white,borderRadius: BorderRadius.circular(10)),
                    child: Text(LocaleKeys.auth_email_verify_resend_email_btn.tr(), textAlign: TextAlign.center ,style: TextStyle(color: CupertinoColors.black,fontSize: 13.5.sp, fontWeight: FontWeight.w500),),
                  ),
                ),
                TapWrapper(
                  onTap: () async {
                    timer?.cancel();
                    await _authService.logout();
                  },
                  child: Container(
                    alignment: Alignment.center,
                    width: 160.w,
                    height: 40.w,
                    decoration: BoxDecoration(color: Colors.redAccent,borderRadius: BorderRadius.circular(10)),
                    child: Text(LocaleKeys.auth_email_verify_cancel_btn.tr(),style: TextStyle(color: CupertinoColors.white,fontSize: 13.5.sp,fontWeight: FontWeight.w500)),
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
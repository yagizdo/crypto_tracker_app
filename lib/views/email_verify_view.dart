import 'dart:async';

import 'package:crypto_tracker/views/base_view.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../services/auth/auth_service.dart';
import '../services/locator.dart';
import '../utils/app_colors.dart';
import '../utils/app_constants.dart';
import '../widgets/main_widgets/main_layout.dart';
import '../widgets/main_widgets/tapWrapper.dart';

class EmailVerifyView extends StatefulWidget {
  const EmailVerifyView({Key? key}) : super(key: key);

  @override
  State<EmailVerifyView> createState() => _EmailVerifyViewState();
}

class _EmailVerifyViewState extends State<EmailVerifyView> {

  final AuthService _authService = getIt<AuthService>();
  late Timer timer;

  @override
  void initState() {
    timer = Timer.periodic(
      const Duration(seconds: 3),
          (timer) async {
        await _authService.reloadUser();
        if(_authService.currentUser.emailVerified!){
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
      timer.cancel();
    }
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    return MainLayout(
      appBar: AppBar(
        backgroundColor: AppColors.blackBackground,
        title: Text('Please Verify Your Email',style: TextStyle(color: CupertinoColors.white,fontSize: 20.sp,fontWeight: FontWeight.bold)),
      ),
      content: Center(
        child: Column(
          children: [
            height10Per(context: context),
            Text(
              '${_authService.currentUser?.emailVerified ?? 'No Data'}', style: TextStyle(color: CupertinoColors.white,fontSize: 18.sp),),
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
                    child: Text('Resend Email',style: TextStyle(color: CupertinoColors.black,fontSize: 15.sp)),
                  ),
                ),
                TapWrapper(
                  onTap: () async {
                    timer.cancel();
                    await _authService.logout();
                  },
                  child: Container(
                    alignment: Alignment.center,
                    width: 150.w,
                    height: 40.w,
                    decoration: BoxDecoration(color: Colors.redAccent,borderRadius: BorderRadius.circular(10)),
                    child: Text('Cancel',style: TextStyle(color: CupertinoColors.white,fontSize: 15.sp)),
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
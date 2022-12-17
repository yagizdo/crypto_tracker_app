import 'dart:io';

import 'package:crypto_tracker/utils/app_constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:sign_button/sign_button.dart';

import '../services/auth/auth_service.dart';
import '../services/database/database_service.dart';
import '../services/locator.dart';

class SocialAuthButtons extends StatefulWidget {
  const SocialAuthButtons({Key? key}) : super(key: key);

  @override
  State<SocialAuthButtons> createState() => _SocialAuthButtonsState();
}

class _SocialAuthButtonsState extends State<SocialAuthButtons> {
  final AuthService _authService = getIt<AuthService>();
  final DatabaseService _databaseService = getIt<DatabaseService>();


  Future<void> _signInWithGoogle() async {
    await _authService.signInWithGoogle().then(
        (user) async {
          if (user != null) {
            await _databaseService.saveUserInDatabase(user!);
          }
        });
  }

  Future<void> _signInWithApple() async {
    await _authService.signInWithApple().then(
        (user) async {
          if (user!=null) {
            await _databaseService.saveUserInDatabase(user!);
          }
        }
    );
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        SignInButton(
            buttonType: ButtonType.google,
            buttonSize: ButtonSize.medium,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
            ),
            width: 220.w,
            padding: 7.w,
            elevation: 0,
            onPressed: _signInWithGoogle),
        height5Per(context: context),
        Platform.isIOS ? SignInButton(
            buttonType: ButtonType.apple,
            buttonSize: ButtonSize.medium,
            width: 220.w,
            padding: 7.w,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
            ),
            elevation: 0,
            onPressed: _signInWithApple) : const SizedBox(),
      ],
    );
  }
}
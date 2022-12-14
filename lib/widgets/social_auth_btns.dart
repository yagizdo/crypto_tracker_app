import 'package:flutter/material.dart';
import 'package:sign_button/sign_button.dart';

class SocialAuthButtons extends StatefulWidget {
  const SocialAuthButtons({Key? key}) : super(key: key);

  @override
  State<SocialAuthButtons> createState() => _SocialAuthButtonsState();
}

class _SocialAuthButtonsState extends State<SocialAuthButtons> {
  /*final AuthService _authService = getIt<AuthService>();

  Future<void> _signInWithGoogle() async {
    await _authService.signInWithGoogle();
  }*/

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        SignInButton.mini(
            buttonType: ButtonType.google,
            buttonSize: ButtonSize.medium,
            elevation: 0,
            onPressed: (){}),
        SignInButton.mini(
            buttonType: ButtonType.apple,
            buttonSize: ButtonSize.medium,
            elevation: 0,
            onPressed: () {}),
        SignInButton.mini(
            buttonType: ButtonType.facebook,
            buttonSize: ButtonSize.medium,
            elevation: 0,
            onPressed: () {}),
        SignInButton.mini(
            buttonType: ButtonType.github,
            buttonSize: ButtonSize.medium,
            elevation: 0,
            onPressed: () {}),
      ],
    );
  }
}
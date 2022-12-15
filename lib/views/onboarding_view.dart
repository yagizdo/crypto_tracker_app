import 'package:crypto_tracker/views/base_view.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../services/auth/auth_service.dart';
import '../services/locator.dart';
import 'auth_view.dart';
import 'email_verify_view.dart';

class OnboardingView extends StatelessWidget {
  OnboardingView({Key? key}) : super(key: key);

  final AuthService _authService = getIt<AuthService>();
  @override
  Widget build(BuildContext context) {
    return StreamBuilder<User?>(
      stream: _authService.authStateChanges(),
      builder: (BuildContext context, AsyncSnapshot snapshot) {
        if (snapshot.connectionState == ConnectionState.active) {
          if (snapshot.hasData || snapshot.data != null) {
            if(!_authService.isUserEmailVerified){
              return const EmailVerifyView();
            }
            return const BaseView();
          } else {
            return const AuthView();
          }
        } else if (snapshot.connectionState == ConnectionState.waiting) {
          return const CircularProgressIndicator();
        } else {
          return const Center(
              child: Text(
                'Something went wrong',
                style: TextStyle(color: Colors.white),
              ));
        }
      },
    );
  }
}
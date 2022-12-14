import 'package:flutter/material.dart';

import '../utils/app_colors.dart';
import '../utils/app_constants.dart';
import '../utils/app_textstyles.dart';
import '../widgets/auth/login/login_component.dart';
import '../widgets/auth/register/register_component.dart';
import '../widgets/auth/reset_password_comp.dart';
import '../widgets/main_widgets/main_layout.dart';

enum AuthFormState { login, register, resetPassword }

class AuthView extends StatefulWidget {
  const AuthView({Key? key}) : super(key: key);

  @override
  State<AuthView> createState() => _AuthViewState();
}

class _AuthViewState extends State<AuthView> {
  AuthFormState _authFormState = AuthFormState.login;

  Map<AuthFormState, String> appbarTitles = {
    AuthFormState.login: 'Login',
    AuthFormState.register: 'Register',
    AuthFormState.resetPassword: 'Reset Password',
  };

  @override
  void setState(VoidCallback fn) {
    if (mounted) {
      super.setState(fn);
    }
  }

  @override
  Widget build(BuildContext context) {
    return MainLayout(
      resizeresizeToAvoidBottomInset: false,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: AppColors.blackBackground,
        title: Text(appbarTitles[_authFormState] ?? 'No Appbar Title',
            style: AppTextStyle.loginViewTitle()),
      ),
      content: SingleChildScrollView(
        child: Center(
          child: Column(
            children: [
              _buildFormContent(),
              height10Per(context: context),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildFormContent() {
    switch (_authFormState) {
      case AuthFormState.login:
        return LoginComponent(
          onRegisterChanged: (authFormStateVal) {
            setState(() {
              _authFormState = authFormStateVal;
            });
          },
        );
      case AuthFormState.register:
        return RegisterComponent(
          onRegisterChanged: (authFormStateVal) {
            setState(
              () {
                _authFormState = authFormStateVal;
              },
            );
          },
        );
      case AuthFormState.resetPassword:
        return ResetPasswordComp(
          onRegisterChanged: (authFormStateVal) {
            setState(
              () {
                _authFormState = authFormStateVal;
              },
            );
          },
        );

      default:
        LoginComponent(
          onRegisterChanged: (authFormStateVal) {
            setState(() {
              _authFormState = authFormStateVal;
            });
          },
        );
    }
    return LoginComponent(
      onRegisterChanged: (authFormStateVal) {
        setState(() {
          _authFormState = authFormStateVal;
        });
      },
    );
  }
}

import 'package:crypto_tracker/views/auth_view.dart';
import 'package:crypto_tracker/widgets/social_auth_btns.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../i18n/locale_keys.g.dart';
import '../../../services/auth/auth_service.dart';
import '../../../services/locator.dart';
import '../../../services/validator.dart';
import '../../../utils/app_colors.dart';
import '../../../utils/app_constants.dart';
import '../../../utils/app_textstyles.dart';
import '../../main_widgets/tapWrapper.dart';
import '../auth_textfield.dart';
import '../horizantal_or_line.dart';

class LoginComponent extends StatefulWidget {
  const LoginComponent({Key? key, required this.onRegisterChanged})
      : super(key: key);
  final ValueSetter<AuthFormState> onRegisterChanged;
  @override
  State<LoginComponent> createState() => _LoginComponentState();
}

class _LoginComponentState extends State<LoginComponent> {
  late GlobalKey<FormState> _formKey;
  late TextEditingController _emailController;
  late TextEditingController _passwordController;
  final AuthService _authService = getIt<AuthService>();
  bool isLoading = false;

  Future<void> loginWithEmailAndPassword() async {
    setState(() {
      isLoading = true;
    });

    await _authService.signInWithEmailAndPassword(
        userEmail: _emailController.text,
        userPassword: _passwordController.text);
    setState(() {
      isLoading = false;
    });
  }

  @override
  void initState() {
    super.initState();
    _emailController = TextEditingController();
    _passwordController = TextEditingController();
    _formKey = GlobalKey<FormState>();
  }

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    _formKey.currentState?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        _loginComponent(),
        const SocialAuthButtons(),
      ],
    );
  }

  Widget _loginComponent() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        height3Per(context: context),
        _loginFormComp(),
        height2Per(context: context),
        Padding(
          padding: EdgeInsets.only(right: 220.w),
          child: TextButton(
              onPressed: () {
                widget.onRegisterChanged(AuthFormState.resetPassword);
              },
              child: Text(
                LocaleKeys.auth_login_forgot_pass_txt.tr(),
                style: AppTextStyle.authTextButton(),
              )),
        ),
        height5Per(context: context),
        _loginButton(),
        height5Per(context: context),
        TextButton(
            onPressed: () {
              widget.onRegisterChanged(AuthFormState.register);
            },
            child: Text(
              LocaleKeys.auth_login_dont_have_acc_txt.tr(),
              style: AppTextStyle.authTextButton(),
            )),
        height5Per(context: context),
        HorizontalOrLine(
          label: LocaleKeys.auth_login_or_txt.tr().toUpperCase(),
          height: 15.w,
          color: AppColors.white,
        ),
        height5Per(context: context),
      ],
    );
  }

  Widget _loginFormComp() {
    return Form(
      key: _formKey,
      child: Column(
        children: [
          AuthTextField(
            controller: _emailController,
            label: LocaleKeys.auth_email_txt.tr(),
            isEmail: true,
            prefixIcon:
                const Icon(Icons.mail, color: AppColors.blackBackground),
            isPassword: false,
            validator: (value) => Validator.email(value),
          ),
          height10Per(context: context),
          AuthTextField(
            controller: _passwordController,
            label: LocaleKeys.auth_password_txt.tr(),
            prefixIcon:
                const Icon(Icons.lock, color: AppColors.blackBackground),
            isPassword: true,
            validator: (value) => Validator.password(
              value,
            ),
          ),
        ],
      ),
    );
  }

  Widget _loginButton() {
    return TapWrapper(
      onTap: () {
        if (_formKey.currentState!.validate()) {
          loginWithEmailAndPassword();
        }
      },
      child: Container(
        width: 250.w,
        height: 40.w,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(10),
        ),
        child: Center(
          child: isLoading
              ? CircularProgressIndicator(
                  color: Colors.black,
                  strokeWidth: 2.w,
                )
              : Text(
                  LocaleKeys.auth_login_login_btn.tr(),
                  style: AppTextStyle.loginBtnTitle(),
                ),
        ),
      ),
    );
  }
}

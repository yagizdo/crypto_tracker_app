import 'package:crypto_tracker/views/auth_view.dart';
import 'package:crypto_tracker/widgets/social_auth_btns.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../services/auth/auth_service.dart';
import '../../../services/locator.dart';
import '../../../services/validator.dart';
import '../../../utils/app_constants.dart';
import '../../main_widgets/tapWrapper.dart';
import '../auth_textfield.dart';

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

  Future<void> loginWithAnonymously() async {
    setState(() {
      isLoading = true;
    });
    //await _authService.loginWithAnonymously();
    setState(() {
      isLoading = false;
    });
  }

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
        height10Per(context: context),
        _loginFormComp(),
        height10Per(context: context),
        _loginButton(),
        height5Per(context: context),
        TextButton(
            onPressed: () {
              widget.onRegisterChanged(AuthFormState.resetPassword);
            },
            child: const Text('Forgot Password?')),
        TextButton(
            onPressed: () {
              widget.onRegisterChanged(AuthFormState.register);
            },
            child: const Text('You don\'t have an account? Register')),
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
            label: 'Email',
            isPassword: false,
            validator: (value) => Validator.email(value),
          ),
          height10Per(context: context),
          AuthTextField(
            controller: _passwordController,
            label: 'Password',
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
        } else {
          print('Form not valid');
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
            'Login',
            //style: AppTextStyle.loginBtnTitle(),
          ),
        ),
      ),
    );
  }
}
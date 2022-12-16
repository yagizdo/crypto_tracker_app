import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../services/auth/auth_service.dart';
import '../../services/locator.dart';
import '../../services/validator.dart';
import '../../utils/app_colors.dart';
import '../../utils/app_constants.dart';
import '../../utils/app_textstyles.dart';
import '../../views/auth_view.dart';
import '../main_widgets/tapWrapper.dart';
import 'auth_textfield.dart';

class ResetPasswordComp extends StatefulWidget {
  const ResetPasswordComp({Key? key, required this.onRegisterChanged}) : super(key: key);
  final ValueSetter<AuthFormState> onRegisterChanged;

  @override
  State<ResetPasswordComp> createState() => _ResetPasswordCompState();
}

class _ResetPasswordCompState extends State<ResetPasswordComp> {
  late GlobalKey<FormState> _formKey;
  late TextEditingController _emailController;
  final AuthService _authService = getIt<AuthService>();

  bool isLoading = false;

  Future<void> sendResetPasswordEmail() async {
    setState(() {
      isLoading = true;
    });
    await _authService.sendResetPasswordMail(userEmail: _emailController.text);
    setState(() {
      isLoading = false;
    });
  }

  @override
  void initState() {
    super.initState();
    _emailController = TextEditingController();
    _formKey = GlobalKey<FormState>();
  }

  @override
  void dispose() {
    _emailController.dispose();
    _formKey.currentState?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return _resetComponent();
  }

  Widget _resetComponent() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        height10Per(context: context),
        _resetFormComp(),
        height10Per(context: context),
        _resetButton(),
        height5Per(context: context),
        TextButton(
          onPressed: () {
            widget.onRegisterChanged(AuthFormState.login);
          },
          child: Container(
            width: 250.w,
            height: 40.w,
            decoration: BoxDecoration(
              color: Colors.redAccent,
              borderRadius: BorderRadius.circular(10),
            ),
            child: Center(
              child: isLoading ? CircularProgressIndicator(
                color: Colors.black,
                strokeWidth: 2.w,
              ) : Text(
                'Back to login',
                style: AppTextStyle.loginBtnTitle(),
              ),
            ),
          ),),
        height5Per(context: context),
      ],
    );
  }

  Widget _resetFormComp() {
    return Form(
      key: _formKey,
      child: Column(
        children: [
          AuthTextField(
            controller: _emailController,
            label: 'Email',
            prefixIcon: const Icon(Icons.email, color: AppColors.blackBackground),
            isPassword: false,
            validator: (value) => Validator.email(value),
          ),
          height10Per(context: context),
        ],
      ),
    );
  }

  Widget _resetButton() {
    return TapWrapper(
      onTap: () {
        if (_formKey.currentState!.validate()) {
          sendResetPasswordEmail();
        } else {
          print('Form not valid');
        }
      },
      child: Container(
        width: 250.w,
        height: 40.w,
        decoration: BoxDecoration(
          color: AppColors.white,
          borderRadius: BorderRadius.circular(10),
        ),
        child: Center(
          child: isLoading ? CircularProgressIndicator(
            color: Colors.black,
            strokeWidth: 2.w,
          ) : Text(
            'Reset Password',
            style: AppTextStyle.loginBtnTitle(),
          ),
        ),
      ),
    );
  }
}
import 'package:crypto_tracker/widgets/main_widgets/main_layout.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../i18n/locale_keys.g.dart';
import '../services/alert_helper.dart';
import '../services/auth/auth_service.dart';
import '../services/locator.dart';
import '../services/validator.dart';
import '../utils/app_colors.dart';
import '../utils/app_constants.dart';
import '../utils/app_textstyles.dart';
import '../widgets/auth/auth_textfield.dart';
import '../widgets/main_widgets/tapWrapper.dart';

class DeleteAccountView extends StatefulWidget {
  const DeleteAccountView({Key? key}) : super(key: key);

  @override
  State<DeleteAccountView> createState() => _DeleteAccountViewState();
}

class _DeleteAccountViewState extends State<DeleteAccountView> {
  late GlobalKey<FormState> _formKey;
  late TextEditingController _passwordController;
  final AuthService _authService = getIt<AuthService>();
  bool isLoading = false;

  @override
  void initState() {
    super.initState();
    _passwordController = TextEditingController();
    _formKey = GlobalKey<FormState>();
  }

  @override
  void dispose() {
    _passwordController.dispose();
    _formKey.currentState?.dispose();
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    return MainLayout(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: Text(
          'Confirm Delete Account',
          maxLines: 2,
          textAlign: TextAlign.center,
          style:
          AppTextStyle.settingsDeleteAccountBottomSheetTitle(),
        ),
      ),
      content: Column(
        children: [
          height10Per(context: context),
          _deleteAccountFormComp(),
          height10Per(context: context),
          _deleteAccountButton(),
        ],
      ),
    );
  }


  Widget _deleteAccountFormComp() {
    return Form(
      key: _formKey,
      child: Column(
        children: [
          AuthTextField(
            controller: _passwordController,
            label: LocaleKeys.auth_password_txt.tr(),
            prefixIcon:
            const Icon(Icons.email, color: AppColors.blackBackground),
            isEmail: true,
            isPassword: false,
            validator: (value) => Validator.password(value),
          ),
          height10Per(context: context),
        ],
      ),
    );
  }

  Widget _deleteAccountButton() {
    return TapWrapper(
      onTap: () {
        if (_formKey.currentState!.validate()) {
          User? currentUser = _authService.currentUser;

          if (currentUser != null) {
            _authService.deleteAccount(userEmail: currentUser.email!, userPassword: _passwordController.text);
          }
        }
      },
      child: Container(
        width: 332.9.w,
        height: 40.w,
        decoration: BoxDecoration(
          color: CupertinoColors.destructiveRed,
          borderRadius: BorderRadius.circular(10),
        ),
        child: Center(
          child: isLoading
              ? CircularProgressIndicator(
            color: Colors.black,
            strokeWidth: 2.w,
          )
              : Text(
            LocaleKeys.auth_reset_password_reset_btn_txt.tr(),
            style: AppTextStyle.loginBtnTitle(),
          ),
        ),
      ),
    );
  }
}

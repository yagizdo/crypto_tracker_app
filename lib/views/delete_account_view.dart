import 'package:crypto_tracker/services/alert_helper.dart';
import 'package:crypto_tracker/widgets/main_widgets/main_layout.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../i18n/locale_keys.g.dart';
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

  Future<void> _deleteAccount() async {
    User? currentUser = _authService.currentUser;
    setState(() {
      isLoading = true;
    });
    if (currentUser != null) {
      await _authService.deleteAccount(
          userEmail: currentUser.email!,
          userPassword: _passwordController.text);
    }
    setState(() {
      isLoading = false;
    });
  }

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
          LocaleKeys.settings_delete_account_alert_title.tr(),
          maxLines: 2,
          textAlign: TextAlign.center,
          style: AppTextStyle.settingsDeleteAccountBottomSheetTitle(),
        ),
      ),
      content: Column(
        children: [
          height7Per(context: context),
          _deleteAccountFormComp(),
          height7Per(context: context),
          _deleteAccountWarning(),
          height7Per(context: context),
          _deleteAccountButton(),
        ],
      ),
    );
  }

  Widget _deleteAccountWarning() {
    return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          _warningTextRow(title: LocaleKeys.settings_delete_account_warning_one.tr()),
          height5Per(context: context),
          _warningTextRow(
              title: LocaleKeys.settings_delete_account_warning_two.tr()),
          height5Per(context: context),
          _warningTextRow(title: LocaleKeys.settings_delete_account_warning_three.tr()),
        ]);
  }

  Widget _warningTextRow({required String title}) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 20.w),
      child: Row(
        children: [
          const Expanded(
            child: Icon(
              Icons.check_box,
              color: Colors.white,
            ),
          ),
          width3Per(context: context),
          Expanded(
            flex: 10,
            child: Text(
              title,
              maxLines: 2,
              style: AppTextStyle.settingsDeleteAccountWarning(),
            ),
          ),
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
                const Icon(Icons.lock, color: AppColors.blackBackground),
            isEmail: true,
            isPassword: true,
            validator: (value) => Validator.password(value),
          ),
        ],
      ),
    );
  }

  Widget _deleteAccountButton() {
    return TapWrapper(
      onTap: () {
        if (_formKey.currentState!.validate()) {
          AlertHelper.shared.showCupertinoChooseDialog(
            context: context,
            title: LocaleKeys.settings_delete_account_alert_title.tr(),
            actions: [
              CupertinoActionSheetAction(
                child: Text(LocaleKeys.settings_delete_account_alert_confirm.tr()),
                onPressed: () async {
                  await _deleteAccount();
                  if(!mounted) return;
                  Navigator.pop(context);
                },
              ),
            ],
          );
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
                  color: Colors.white,
                  strokeWidth: 2.w,
                )
              : Text(
                  LocaleKeys.settings_delete_account_delete_account_btn.tr(),
                  style: AppTextStyle.deleteAccountBtnTitle(),
                ),
        ),
      ),
    );
  }
}

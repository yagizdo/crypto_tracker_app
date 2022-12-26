import 'package:crypto_tracker/i18n/locale_keys.g.dart';
import 'package:crypto_tracker/utils/app_colors.dart';
import 'package:crypto_tracker/utils/app_constants.dart';
import 'package:crypto_tracker/utils/app_textstyles.dart';
import 'package:crypto_tracker/widgets/settings/delete_account_card.dart';
import 'package:crypto_tracker/widgets/settings/edit_profile_comp.dart';
import 'package:crypto_tracker/widgets/settings/settings_card.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../services/alert_helper.dart';
import '../../services/auth/auth_service.dart';
import '../../services/locator.dart';
import '../../services/validator.dart';
import '../../views/onboarding_view.dart';
import '../auth/auth_textfield.dart';
import '../main_widgets/tapWrapper.dart';

class SettingsContent extends StatefulWidget {
  const SettingsContent({Key? key}) : super(key: key);

  @override
  State<SettingsContent> createState() => _SettingsContentState();
}

class _SettingsContentState extends State<SettingsContent> {
  final AuthService _authService = getIt<AuthService>();
  late GlobalKey<FormState> _formKey;
  late TextEditingController _passwordController;

  bool isLoading = false;
  bool isDeleting = false;

  Future<void> _signOut() async {
    setState(() {
      isLoading = true;
    });
    if (_authService.currentUser != null) {
      await _authService.logout();
      if (!mounted) return;
      Navigator.pushReplacement(
          context, MaterialPageRoute(builder: (context) => OnboardingView()));
    }
    setState(() {
      isLoading = false;
    });
  }

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
    return isDeleting ? _buildDeleteAccountContent() : _buildSettingsCard();
  }

  Widget _buildSettingsCard() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        height7Per(context: context),
        // Edit Profile
        EditProfileComp(currentUser: _authService.currentUser),
        height7Per(context: context),

        // Language
        SettingsCard(
            title: LocaleKeys.settings_change_language.tr(),
            icon: const Icon(
              Icons.language,
              color: AppColors.blueBackground,
            ),
            content: Row(
              children: [
                Text(
                  localesMap[context.locale.languageCode] ?? 'English',
                  style: AppTextStyle.settingsCardLangCodeTxt(),
                ),
                width2Per(context: context),
                Icon(
                  Icons.arrow_forward_ios,
                  size: 15.w,
                ),
              ],
            ),
            onTap: () {}),
        height7Per(context: context),

        // Logout
        SettingsCard(
            title: LocaleKeys.settings_logout.tr(),
            isCenterText: true,
            onTap: _signOut),
        height7Per(context: context),

        // Delete Account
        _authService.isSocialLogin ?  const SizedBox() : DeleteAccountCard(onClick: (value) {
          setState(() {
            isDeleting = value;
          });
        },),
      ],
    );
  }

  Widget _buildDeleteAccountContent() {
    return Column(
      children: [
        height7Per(context: context),
        Text(
          LocaleKeys.settings_delete_account_alert_title.tr(),
          style: AppTextStyle.settingsDeleteAccountBottomSheetTitle(),
        ),
        height7Per(context: context),
        _deleteAccountFormComp(),
        height7Per(context: context),
        _deleteAccountWarning(),
        height7Per(context: context),
        _deleteAccountButton(),
        height7Per(context: context),
        _buildCancelDeleteAccountButton(),
      ],
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
            LocaleKeys.settings_delete_account_btn_txt.tr(),
            style: AppTextStyle.deleteAccountBtnTitle(),
          ),
        ),
      ),
    );
  }

  Widget _buildCancelDeleteAccountButton() {
    return TapWrapper(
      onTap: () {
        setState(() {
          isDeleting = false;
        });
      },
      child: Container(
        width: 332.9.w,
        height: 40.w,
        decoration: BoxDecoration(
          color: AppColors.white,
          borderRadius: BorderRadius.circular(10),
        ),
        child: Center(
          child: Text(
            LocaleKeys.settings_delete_account_alert_cancel.tr(),
            style: AppTextStyle.deleteAccountCancelBtnTitle(),
          ),
        ),
      ),
    );
  }
}

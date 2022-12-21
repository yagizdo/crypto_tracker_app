import 'package:crypto_tracker/i18n/locale_keys.g.dart';
import 'package:crypto_tracker/utils/app_colors.dart';
import 'package:crypto_tracker/utils/app_constants.dart';
import 'package:crypto_tracker/utils/app_textstyles.dart';
import 'package:crypto_tracker/widgets/settings/delete_account_card.dart';
import 'package:crypto_tracker/widgets/settings/edit_profile_comp.dart';
import 'package:crypto_tracker/widgets/settings/settings_card.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../services/auth/auth_service.dart';
import '../../services/locator.dart';
import '../../views/onboarding_view.dart';

class SettingsContent extends StatefulWidget {
  SettingsContent({Key? key}) : super(key: key);

  @override
  State<SettingsContent> createState() => _SettingsContentState();
}

class _SettingsContentState extends State<SettingsContent> {
  final AuthService _authService = getIt<AuthService>();
  bool isLoading = false;

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

  @override
  Widget build(BuildContext context) {
    return _buildSettingsCard();
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
        const DeleteAccountCard(),
      ],
    );
  }
}

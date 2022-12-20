import 'package:crypto_tracker/utils/app_colors.dart';
import 'package:crypto_tracker/utils/app_constants.dart';
import 'package:crypto_tracker/utils/app_textstyles.dart';
import 'package:crypto_tracker/widgets/main_widgets/tapWrapper.dart';
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
        // Edit Profile
        _buildEditProfileComp(),
        height10Per(context: context),

        // Language
        SettingsCard(
            title: 'Change Language',
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
        height10Per(context: context),

        // Logout
        SettingsCard(title: 'Logout', isCenterText: true, onTap: _signOut),
        height10Per(context: context),

        // Delete Account
        SettingsCard(
            title: 'Delete Account',
            backgroundColor: Colors.redAccent,
            isCenterText: true,
            titleColor: AppColors.white,
            onTap: () {}),
      ],
    );
  }

  Widget _buildEditProfileComp() {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 25.w),
      child: Container(
        height: 250.w,
        alignment: Alignment.center,
        width: double.infinity,
        decoration: BoxDecoration(
          color: AppColors.white,
          borderRadius: BorderRadius.circular(10),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const CircleAvatar(
              radius: 50,
              backgroundColor: Colors.white,
              child: CircleAvatar(
                radius: 45,
              ),
            ),
            height4Per(context: context),
            Text(
              _authService.currentUser.displayName ?? 'User Name',
              style: const TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            height4Per(context: context),
            Text(
              _authService.currentUser?.email ?? 'No Data',
              style: const TextStyle(
                fontSize: 15,
                fontWeight: FontWeight.w300,
              ),
            ),
            height7Per(context: context),
            TapWrapper(
                onTap: () {},
                child: Container(
                  height: 38.w,
                  width: 140.w,
                  decoration: BoxDecoration(
                    color: AppColors.blueBackground,
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Center(
                      child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text(
                        'Edit Profile',
                        style: TextStyle(color: Colors.white),
                      ),
                      width2Per(context: context),
                      Icon(
                        Icons.edit,
                        color: Colors.white,
                        size: 16.w,
                      ),
                    ],
                  )),
                )),
          ],
        ),
      ),
    );
  }
}

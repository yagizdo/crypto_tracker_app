import 'package:crypto_tracker/utils/app_textstyles.dart';
import 'package:crypto_tracker/widgets/main_widgets/main_layout.dart';
import 'package:crypto_tracker/widgets/main_widgets/tapWrapper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../services/auth/auth_service.dart';
import '../services/locator.dart';
import '../utils/app_colors.dart';
import 'onboarding_view.dart';

class HomeView extends StatefulWidget {
  const HomeView({Key? key}) : super(key: key);

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  final AuthService _authService = getIt<AuthService>();
  @override
  Widget build(BuildContext context) {
    return MainLayout(
      appBar: _buildHomeAppBar(),
      content: Center(
        child: Text(
          'Home',
          style: AppTextStyle.homeText(),
        ),
      ),
    );
  }

  PreferredSizeWidget _buildHomeAppBar() {
    return AppBar(
      backgroundColor: Colors.transparent,
      elevation: 0,
      title: Text(
        'Home',
        style: TextStyle(
          color: AppColors.white,
          fontSize: 30.sp,
          fontWeight: FontWeight.w600,
        ),
      ),
      actions: [
        Padding(
          padding: EdgeInsets.only(right: 10.w),
          child: TapWrapper(onTap: () async {
            if (_authService.currentUser != null) {
              await _authService.logout();
              if (!mounted) return;
              Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => OnboardingView()));

            }
          }, child: const Icon(Icons.logout)),
        )
      ],
    );
  }
}

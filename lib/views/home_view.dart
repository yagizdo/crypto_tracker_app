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
      content: Center(
        child: Text(
          'Home',
          style: AppTextStyle.homeText(),
        ),
      ),
    );
  }
}

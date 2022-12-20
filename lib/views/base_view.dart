import 'dart:async';

import 'package:crypto_tracker/services/navigation_service.dart';
import 'package:crypto_tracker/views/currency_view.dart';
import 'package:crypto_tracker/views/home_view.dart';
import 'package:crypto_tracker/views/settings_view.dart';
import 'package:crypto_tracker/widgets/main_widgets/main_layout.dart';
import 'package:crypto_tracker/widgets/main_widgets/main_navbar.dart';
import 'package:dot_navigation_bar/dot_navigation_bar.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../services/auth/auth_service.dart';
import '../services/locator.dart';
import '../utils/app_colors.dart';
import '../utils/extensions/auth_exception_handler.dart';

class BaseView extends StatefulWidget {
  const BaseView({Key? key}) : super(key: key);

  @override
  State<BaseView> createState() => _BaseViewState();
}

class _BaseViewState extends State<BaseView> {
  late Timer timer;
  final AuthService _authService = getIt<AuthService>();
  final NavigationService _navigationService = getIt<NavigationService>();
  int currentIndex = 0;

  void _reloadUserPeriodically() {
    timer = Timer.periodic(
      const Duration(seconds: 10),
      (timer) async {
        try {
          await _authService.reloadUser();
        } on FirebaseAuthException catch (e) {
          var exceptionMessage =
              AuthExceptionHandler.generateExceptionMessage(e);
          _navigationService.showErrorSnackbar(errorMessage: exceptionMessage);
        } catch (e) {
          var exceptionMessage =
              AuthExceptionHandler.generateExceptionMessage(e);
          _navigationService.showErrorSnackbar(errorMessage: exceptionMessage);
        }
      },
    );
  }

  @override
  void initState() {
    super.initState();
    _reloadUserPeriodically();
  }

  @override
  void dispose() {
    if (!mounted) {
      timer.cancel();
    }
    super.dispose();
  }

  Widget _buildView() {
    switch (currentIndex) {
      case 0:
        return const HomeView();
      case 1:
        return const CurrencyView();
      case 2:
        return const Center(
          child: Text('Coming soon'),
        );
      case 3:
        return const SettingsView();
      default:
        return const HomeView();
    }
  }

  @override
  Widget build(BuildContext context) {
    return MainLayout(
      content: _buildView(),
      bottomNavigationBar: MainNavbar(
        currentIndex: currentIndex,
        onTabChanged: (index) {
          setState(() {
            currentIndex = index;
          });
        },
      ),
    );
  }
}


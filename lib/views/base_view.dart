import 'dart:async';

import 'package:crypto_tracker/services/navigation_service.dart';
import 'package:crypto_tracker/views/home_view.dart';
import 'package:crypto_tracker/widgets/main_widgets/main_layout.dart';
import 'package:crypto_tracker/widgets/main_widgets/main_navbar.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../services/auth/auth_service.dart';
import '../services/locator.dart';
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


  void _reloadUserPeriodically() {
    timer = Timer.periodic(
      const Duration(seconds: 10),
          (timer) async {
        try {
          await _authService.reloadUser();
        } on FirebaseAuthException catch (e) {
          var exceptionMessage = AuthExceptionHandler.generateExceptionMessage(e);
          _navigationService.showErrorSnackbar(errorMessage: exceptionMessage);
        } catch (e) {
          var exceptionMessage = AuthExceptionHandler.generateExceptionMessage(e);
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

  @override
  Widget build(BuildContext context) {
    return MainLayout(
      bottomNavigationBar: MainNavbar(
        tabs: [
          const HomeView(),
          Container(),
          Container(),
        ],
      ),
    );
  }
}

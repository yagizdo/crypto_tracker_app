import 'package:crypto_tracker/views/auth_view.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class NavigationService {
  final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();
  Future<dynamic> navigateTo(String routeName) {
    return navigatorKey.currentState!.pushReplacementNamed(routeName);
  }
  
  Future<dynamic> navigatePush(Widget route) {
    return navigatorKey.currentState!.push(MaterialPageRoute(builder: (context) => route));
  }

  Future<dynamic> navigateBackToAuth() {
    return navigatorKey.currentState!.pushAndRemoveUntil(MaterialPageRoute(builder: (context) => const AuthView()), (route) => false);
  }

  // Use this method to navigate back to the previous screen
  void goBack() {
    return navigatorKey.currentState!.pop();
  }


  void showErrorSnackbar({required String errorMessage}) {
    SnackBar snackbar = SnackBar(
      content: SizedBox(
        height: 30.w,
        child: Center(
          child: Text(
            errorMessage,
          ),
        ),
      ),
      backgroundColor: CupertinoColors.destructiveRed,
      duration: const Duration(seconds: 4),
    );
    ScaffoldMessenger.of(navigatorKey.currentContext!).clearSnackBars();
    ScaffoldMessenger.of(navigatorKey.currentContext!).showSnackBar(snackbar);
  }

  void showSuccessSnackbar({required String errorMessage}) {
    SnackBar snackbar = SnackBar(
      content: SizedBox(
        height: 30.w,
        child: Center(
          child: Text(
            errorMessage,
          ),
        ),
      ),
      backgroundColor: CupertinoColors.activeGreen,
      duration: const Duration(seconds: 2),
    );
    ScaffoldMessenger.of(navigatorKey.currentContext!).clearSnackBars();
    ScaffoldMessenger.of(navigatorKey.currentContext!).showSnackBar(snackbar);
  }
}
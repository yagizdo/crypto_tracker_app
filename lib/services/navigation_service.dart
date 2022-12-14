import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class NavigationService {
  final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();
  Future<dynamic> navigateTo(String routeName) {
    return navigatorKey.currentState!.pushReplacementNamed(routeName);
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
      duration: const Duration(seconds: 2),
    );
    ScaffoldMessenger.of(navigatorKey.currentContext!).clearSnackBars();
    ScaffoldMessenger.of(navigatorKey.currentContext!).showSnackBar(snackbar);
  }
}
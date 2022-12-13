import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:persistent_bottom_nav_bar_v2/persistent-tab-view.dart';

import '../../utils/app_colors.dart';

class MainNavbar extends StatelessWidget {
  const MainNavbar({Key? key, required this.tabs}) : super(key: key);
  final List<Widget> tabs;
  @override
  Widget build(BuildContext context) {
    return PersistentTabView(
      context,
      navBarStyle: NavBarStyle.style3,
      //backgroundColor: AppColors.blackBackground,
      decoration: const NavBarDecoration(
        gradient: LinearGradient(
          colors: [AppColors.blackBackground, AppColors.navbarColorsOne],
        ),
      ),
      screens: tabs,
      screenTransitionAnimation: const ScreenTransitionAnimation( // Screen transition animation on change of selected tab.
        animateTabTransition: true,
        curve: Curves.linear,
        duration: Duration(milliseconds: 200),
      ),
      navBarHeight: 60.w,
      items: [
        // Home
        PersistentBottomNavBarItem(
            activeColorPrimary: CupertinoColors.systemBackground,
            inactiveColorPrimary: CupertinoColors.inactiveGray,
            activeColorSecondary: Colors.white,
            iconSize: 23.w,
            icon: const Icon(Icons.home),
            textStyle: TextStyle(fontSize: 11.sp),
            title: 'Home'),

        // Coins
        PersistentBottomNavBarItem(
            activeColorPrimary: CupertinoColors.white,
            inactiveColorPrimary: CupertinoColors.inactiveGray,
            activeColorSecondary: CupertinoColors.white,
            icon: const Icon(Icons.sports_football),
            textStyle: TextStyle(fontSize: 11.sp),
            title: 'Coins'),

        // Settings
        PersistentBottomNavBarItem(
            activeColorPrimary: CupertinoColors.white,
            inactiveColorPrimary: CupertinoColors.inactiveGray,
            activeColorSecondary: Colors.white,
            textStyle: TextStyle(fontSize: 11.sp),
            icon: const Icon(Icons.settings),
            title: 'Settings'),
      ],
    );
    ;
  }
}

import 'package:dot_navigation_bar/dot_navigation_bar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../utils/app_colors.dart';

class MainNavbar extends StatelessWidget {
  MainNavbar({Key? key, required this.onTabChanged, required this.currentIndex}) : super(key: key);
  final ValueSetter<int> onTabChanged;
  int currentIndex;
  @override
  Widget build(BuildContext context) {
    return DotNavigationBar(
      backgroundColor: AppColors.white,
      borderRadius: 15.w,
      curve: Curves.easeIn,
      duration: const Duration(milliseconds: 200),
      selectedItemColor: AppColors.blueBackground,
      unselectedItemColor: AppColors.blackBackground.withOpacity(0.5),
      paddingR:
      EdgeInsets.only(right: 20.w, left: 20.w, top: 8.w, bottom: 8.w),
      marginR: EdgeInsets.only(
        right: 15.w,
        left: 15.w,
        bottom: 20.w,
      ),
      itemPadding: EdgeInsets.symmetric(
        horizontal: 15.w,
        vertical: 5.w,
      ),
      currentIndex: currentIndex,
      onTap: onTabChanged,
      items: [
        DotNavigationBarItem(
          icon: const Icon(Icons.star),
        ),
        DotNavigationBarItem(
          icon: const Icon(Icons.attach_money),
        ),
        DotNavigationBarItem(
          icon: const Icon(Icons.currency_bitcoin_outlined),
        ),
        DotNavigationBarItem(
          icon: const Icon(Icons.settings),
        ),
      ],
    );
  }
}

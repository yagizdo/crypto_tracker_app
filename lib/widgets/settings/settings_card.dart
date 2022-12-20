import 'package:crypto_tracker/utils/app_constants.dart';
import 'package:crypto_tracker/utils/app_textstyles.dart';
import 'package:crypto_tracker/widgets/main_widgets/tapWrapper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../utils/app_colors.dart';

class SettingsCard extends StatelessWidget {
  const SettingsCard({
    Key? key,
    required this.title,
    required this.onTap,
    this.content,
    this.actionBtn,
    this.isLoading = false,
    this.backgroundColor,
    this.icon,
    this.isCenterText = false,
    this.titleColor,
  }) : super(key: key);
  final String title;
  final Widget? content;
  final Widget? actionBtn;
  final VoidCallback onTap;
  final bool isCenterText;
  final Widget? icon;
  final bool isLoading;
  final Color? titleColor;
  final Color? backgroundColor;
  @override
  Widget build(BuildContext context) {
    return TapWrapper(
      onTap: onTap,
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 25.w),
        child: Container(
          height: 45.w,
          alignment: Alignment.center,
          width: double.infinity,
          decoration: BoxDecoration(
            color: backgroundColor ?? AppColors.white,
            borderRadius: BorderRadius.circular(10),
          ),
          child: Row(
            mainAxisAlignment: isCenterText
                ? MainAxisAlignment.center
                : MainAxisAlignment.spaceBetween,
            children: [
              isLoading
                  ? CircularProgressIndicator(
                      color: titleColor,
                    )
                  : Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        isCenterText
                            ? const SizedBox()
                            : width4Per(context: context),
                        icon ?? const SizedBox(),
                        isCenterText
                            ? const SizedBox()
                            : width4Per(context: context),
                        Text(title,
                            style: AppTextStyle.settingsCardTitle(
                                titleColor: titleColor)),
                        isCenterText
                            ? const SizedBox()
                            : width15Per(context: context),
                        content ?? const SizedBox()
                      ],
                    ),
              actionBtn ?? const SizedBox(),
            ],
          ),
        ),
      ),
    );
  }
}

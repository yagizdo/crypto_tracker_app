import 'package:easy_localization/easy_localization.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../i18n/locale_keys.g.dart';
import '../../utils/app_colors.dart';
import '../../utils/app_constants.dart';
import '../main_widgets/tapWrapper.dart';

class EditProfileComp extends StatelessWidget {
  const EditProfileComp({Key? key, required this.currentUser}) : super(key: key);
  final User? currentUser;
  @override
  Widget build(BuildContext context) {
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
            CircleAvatar(
              radius: 45,
              backgroundImage: currentUser?.photoURL != null
                  ? NetworkImage(currentUser!.photoURL!)
                  : null,
              backgroundColor: AppColors.blackForeground,
            child: currentUser?.photoURL == null
                ? Text(
                    currentUser?.displayName?.substring(0, 1) ?? 'N',
                    style: TextStyle(
                      fontSize: 45.sp,
                      color: AppColors.white,
                    ),
                  )
                : null,
            ),
            height4Per(context: context),
            Text(
              currentUser?.displayName ?? 'User Name',
              style: const TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            height4Per(context: context),
            Text(
              currentUser?.email ?? 'No Data',
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
                  width: 150.w,
                  decoration: BoxDecoration(
                    color: AppColors.blueBackground,
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Center(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            LocaleKeys.settings_edit_btn.tr(),
                            style: const TextStyle(color: Colors.white),
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

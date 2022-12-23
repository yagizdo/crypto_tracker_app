import 'package:crypto_tracker/i18n/locale_keys.g.dart';
import 'package:crypto_tracker/utils/app_colors.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../utils/app_textstyles.dart';
import '../main_widgets/tapWrapper.dart';

class CustomListsNamesList extends StatelessWidget {
  const CustomListsNamesList({Key? key, required this.favoriteListNames})
      : super(key: key);
  final List<dynamic> favoriteListNames;
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: favoriteListNames.length,
      itemBuilder: (context, index) {
        var listName = favoriteListNames[index];
        return _buildCustomListNameCard(listName: listName);
      },
    );
  }

  Widget _buildCustomListNameCard({required String listName}) {
    return TapWrapper(
      onTap: () {},
      child: Padding(
        padding: EdgeInsets.symmetric(
          horizontal: 10.w,
          vertical: 10.w,
        ),
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(8),
            color: AppColors.white.withOpacity(0.9),
          ),
          height: 50.w,
          child: Padding(
            padding: EdgeInsets.symmetric(
              horizontal: 10.w,
              vertical: 3.w,
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Expanded(
                  flex: 1,
                  child: Icon(
                    Icons.list_alt_rounded,
                    color: AppColors.blackBackground,
                    size: 25.w,
                  ),
                ),
                Expanded(
                    flex: 4,
                    child: Text(
                      listName,
                      maxLines: 2,
                      style: AppTextStyle.cryptoTitle(),
                    )),

                Expanded(
                    flex: 1,
                    child: Text(
                      LocaleKeys.custom_lists_item_count.tr(args: ['0']),
                      maxLines: 2,
                      style: AppTextStyle.cryptoTitle(),
                    )),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

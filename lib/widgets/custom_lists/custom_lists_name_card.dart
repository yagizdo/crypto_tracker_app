import 'package:crypto_tracker/services/auth/auth_service.dart';
import 'package:crypto_tracker/utils/app_constants.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../i18n/locale_keys.g.dart';
import '../../services/database/database_service.dart';
import '../../services/locator.dart';
import '../../utils/app_colors.dart';
import '../../utils/app_textstyles.dart';
import '../main_widgets/tapWrapper.dart';

class CustomListsNameCard extends StatefulWidget {
  const CustomListsNameCard({Key? key, required this.listName}) : super(key: key);
  final String listName;
  @override
  State<CustomListsNameCard> createState() => _CustomListsNameCardState();
}

class _CustomListsNameCardState extends State<CustomListsNameCard> {
  final DatabaseService _databaseService = getIt<DatabaseService>();
  final AuthService _authService = getIt<AuthService>();
  int listItemCount = 0;

  Future<void> getItemsCount() async {
    String userUID = _authService.currentUser.uid;
    int itemCount = await _databaseService.getListItemCount(listName: widget.listName, userUID: userUID);
    setState(() {
      listItemCount = itemCount;
    });
  }

  @override
  void setState(VoidCallback fn) {
    if (mounted) {
      super.setState(fn);
    }
  }
  @override
  void initState() {
    super.initState();
    getItemsCount();
  }
  @override
  Widget build(BuildContext context) {
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
                    flex: 7,
                    child: Text(
                      widget.listName,
                      maxLines: 2,
                      style: AppTextStyle.cryptoTitle(),
                    )),

                Expanded(
                    flex: 2,
                    child: Row(
                      children: [
                        Expanded(child: Text(listItemCount.toString())),
                        width1Per(context: context),
                        Expanded(
                          flex: 5,
                          child: Text(
                            LocaleKeys.custom_lists_item_count.tr(),
                            maxLines: 2,
                            style: AppTextStyle.cryptoTitle(),
                          ),
                        ),
                      ],
                    )),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

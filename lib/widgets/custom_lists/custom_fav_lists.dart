import 'package:crypto_tracker/services/alert_helper.dart';
import 'package:crypto_tracker/utils/app_constants.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../bloc/favorites_bloc/favorites_bloc.dart';
import '../../i18n/locale_keys.g.dart';
import '../../utils/app_colors.dart';
import '../../utils/app_textstyles.dart';
import 'CustomListsNameList.dart';

class CustomFavLists extends StatefulWidget {
  const CustomFavLists({Key? key, required this.onTap}) : super(key: key);
  final ValueSetter<String> onTap;
  @override
  State<CustomFavLists> createState() => _CustomFavListsState();
}

class _CustomFavListsState extends State<CustomFavLists> {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<FavoritesBloc, FavoritesState>(
      builder: (context, state) {
        if (state is CustomListNamesLoadingState) {
          return Center(
            child: CircularProgressIndicator(
              color: AppColors.white,
              strokeWidth: 3.w,
            ),
          );
        }

        if (state is CustomListNamesErrorState) {
          return Center(
            child: Text(
              LocaleKeys.errors_custom_error.tr(),
              style: AppTextStyle.homeText(),
            ),
          );
        }

        if (state is CustomListNamesEmptyState) {
          return Center(
            child: Stack(
              alignment: Alignment.center,
              children: [
                Center(child: Text(LocaleKeys.currency_no_item.tr())),
                Positioned(
                    bottom: 120.w,
                    right: 10.w,
                    child: _buildAddCustomListBtn()),
              ],
            ),
          );
        }
        if (state is CustomListNamesLoadedState) {
          return Stack(
            children: [
              Column(
                children: [
                  height1Per(context: context),
                  Expanded(
                    child: Padding(
                      padding: EdgeInsets.only(left: 25.w, right: 25.w),
                      child: Container(
                        decoration: const BoxDecoration(
                          color: AppColors.blueBackground,
                        ),
                        child: Text(
                          LocaleKeys.custom_lists_title.tr(),
                          style: AppTextStyle.customListNameTitle(),
                          textAlign: TextAlign.center,
                        ),
                      ),
                    ),
                  ),
                  Expanded(
                      flex: 20,
                      child: CustomListsNamesList(
                        favoriteListNames: state.customListNames,
                        onTap: (listName) {
                          widget.onTap(listName);
                        },
                      )),
                ],
              ),
              Positioned(
                  bottom: 120.w, right: 10.w, child: _buildAddCustomListBtn()),
            ],
          );
        }
        return Center(
          child: Stack(
            children: [
              Center(child: Text(LocaleKeys.currency_no_item.tr())),
              Positioned(
                  bottom: 120.w, right: 10.w, child: _buildAddCustomListBtn()),
            ],
          ),
        );
      },
    );
  }

  FloatingActionButton _buildAddCustomListBtn() {
    return FloatingActionButton(
      child: const Icon(Icons.add),
      onPressed: () {
        AlertHelper.shared.addCustomListDialog(context);
      },
    );
  }
}

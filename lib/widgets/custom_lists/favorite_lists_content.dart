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

class CustomListsContent extends StatelessWidget {
  const CustomListsContent({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<FavoritesBloc, FavoritesState>(
      builder: (context, state) {
        if (state is CustomListLoadingState) {
          return Center(child: CircularProgressIndicator(color: AppColors.white,strokeWidth: 3.w,),);
        }

        if (state is CustomListNamesErrorState) {
          return Center(
            child: Text(
              LocaleKeys.errors_custom_error.tr(),
              style: AppTextStyle.homeText(),
            ),
          );
        }

        if (state is CustomListEmptyState) {
          return Center(
            child: Text(
              LocaleKeys.currency_no_item.tr(),
              style: AppTextStyle.homeText(),
            ),
          );
        }
        if (state is CustomListNamesLoadedState) {
          return Column(
            children: [
              height1Per(context: context),
              Expanded(
                child: Padding(
                  padding: EdgeInsets.only(left: 25.w, right: 25.w),
                  child: Container(
                    decoration: const BoxDecoration(
                      color: AppColors.blueBackground,
                    ),
                    child:  Text(
                      'Your Lists',
                      style: AppTextStyle.customListNameTitle(),
                      textAlign: TextAlign.center,
                    ),
                  ),
                ),
              ),
              Expanded(flex: 20,child: CustomListsNamesList(favoriteListNames: state.customListNames,)),
            ],
          );
          
        }
        return Center(child: Text(LocaleKeys.currency_no_item.tr()),);
      },
    );
  }
}

import 'package:crypto_tracker/widgets/favorites/favorites_list.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../bloc/favorites_bloc/favorites_bloc.dart';
import '../../i18n/locale_keys.g.dart';
import '../../utils/app_colors.dart';
import '../../utils/app_textstyles.dart';

class FavoritesContent extends StatelessWidget {
  const FavoritesContent({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<FavoritesBloc, FavoritesState>(
      builder: (context, state) {
        if (state is FavoritesLoadingState) {
          return Center(child: CircularProgressIndicator(color: AppColors.white,strokeWidth: 3.w,),);
        }

        if (state is FavoritesErrorState) {
          return Center(
            child: Text(
              LocaleKeys.errors_custom_error.tr(),
              style: AppTextStyle.homeText(),
            ),
          );
        }

        if (state is FavoritesEmptyState) {
          return Center(
            child: Text(
              LocaleKeys.currency_no_item.tr(),
              style: AppTextStyle.homeText(),
            ),
          );
        }
        if (state is FavoritesLoadedState) {
          return Column(
            children: [
              Expanded(
                child: Padding(
                  padding: EdgeInsets.only(left: 25.w, right: 25.w),
                  child: Container(
                    decoration: const BoxDecoration(
                      color: AppColors.blueBackground,
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Expanded(
                            child: Text(
                              LocaleKeys.currency_row_name.tr(),
                              style: AppTextStyle.currencyRowItemTitle(),
                              textAlign: TextAlign.center,
                            )),
                        Expanded(
                            child: Text(
                              LocaleKeys.currency_row_buy_price.tr(args: ['']),
                              style: AppTextStyle.currencyRowItemTitle(),
                              textAlign: TextAlign.center,
                            )),
                        Expanded(
                            child: Text(
                              LocaleKeys.currency_row_change.tr(),
                              style: AppTextStyle.currencyRowItemTitle(),
                              textAlign: TextAlign.center,
                            )),
                      ],
                    ),
                  ),
                ),
              ),
              Expanded(flex: 10,child: FavoritesList(favorites: state.favorites,)),
            ],
          );
          
        }
        return Center(child: Text(LocaleKeys.currency_no_item.tr()),);
      },
    );
  }
}

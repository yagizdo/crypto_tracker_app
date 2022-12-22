import 'package:crypto_tracker/i18n/locale_keys.g.dart';
import 'package:crypto_tracker/widgets/currency/currency_list.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../bloc/currency_bloc/currency_bloc.dart';
import '../../utils/app_colors.dart';
import '../../utils/app_constants.dart';
import '../../utils/app_textstyles.dart';

class CurrencyContent extends StatelessWidget {
  const CurrencyContent({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.center,
      child: BlocBuilder<CurrencyBloc, CurrencyState>(
        builder: (context, state) {
          if (state is CurrencyLoading) {
            return const Center(
              child: CircularProgressIndicator(
                color: Colors.white,
              ),
            );
          }

          if (state is CurrencyLoaded) {
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
                            LocaleKeys.currency_row_buy_price.tr(args: ['₺']),
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
                Expanded(
                  flex: 10,
                  child: CurrencyList(
                    currencies: state.currencies,
                  ),
                ),
              ],
            );
          }

          if (state is CurrencyError) {
            return Center(
              child: Text(
                LocaleKeys.errors_custom_error.tr(),
                style: const TextStyle(
                  color: Colors.white,
                ),
              ),
            );
          }
          return Center(
            child: Text(LocaleKeys.currency_no_item.tr(),style: const TextStyle(
              color: Colors.white,
            ),),
          );
        },
      ),
    );
  }
}

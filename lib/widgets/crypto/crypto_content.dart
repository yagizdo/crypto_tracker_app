import 'package:crypto_tracker/widgets/crypto/crypto_list.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../bloc/crypto_bloc/crypto_bloc.dart';
import '../../i18n/locale_keys.g.dart';
import '../../utils/app_colors.dart';
import '../../utils/app_textstyles.dart';

class CryptoContent extends StatelessWidget {
  const CryptoContent({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CryptoBloc, CryptoState>(
      builder: (context, state) {
        if (state is CryptoLoading) {
          return Center(
            child: CircularProgressIndicator(color: AppColors.white,strokeWidth: 3.w,),
          );
        }

        if(state is CryptoError) {
          return Center(child: Text(state.errorMessage,style: const TextStyle(color: AppColors.white),),);
        }

        if (state is CryptoLoaded) {
          return Column(
            children: [
              Expanded(child: _cryptoTitlesRow()),
              Expanded(flex: 10, child: CryptoList(cryptos: state.cryptos,)),
            ],
          );
        }
        return const Center(child: Text('No items',style: TextStyle(color: Colors.white),),);
      },
    );
  }

  Widget _cryptoTitlesRow() {
    return Row(
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
    );
  }
}

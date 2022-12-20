import 'package:crypto_tracker/widgets/currency/currency_list.dart';
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
                Expanded(child: Padding(
                  padding: EdgeInsets.only(left: 35.w, right: 20.w),
                  child: Container(
                    decoration: const BoxDecoration(
                      color: AppColors.blueBackground,
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Expanded(child: Text('Name', style: AppTextStyle.currencyRowItemTitle(),)),
                        width7Per(context: context),
                        Expanded(child: Text('Buy Price', style: AppTextStyle.currencyRowItemTitle(),)),
                        width7Per(context: context),
                        Expanded(child: Text('Change', style: AppTextStyle.currencyRowItemTitle(),)),
                      ],
                    ),
                  ),
                ),),
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
            return const Center(
              child: Text(
                'Something went wrong!',
                style: TextStyle(
                  color: Colors.white,
                ),
              ),
            );
          }
          return const Center(
            child: Text('No items'),
          );
        },
      ),
    );
  }
}

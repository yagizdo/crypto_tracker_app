import 'package:crypto_tracker/utils/app_textstyles.dart';
import 'package:crypto_tracker/utils/extensions/string_extension.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../models/currency.dart';
import '../../utils/app_colors.dart';

class CurrencyCard extends StatelessWidget {
  const CurrencyCard({Key? key, required this.currency}) : super(key: key);
  final Currency currency;
  @override
  Widget build(BuildContext context) {
    // String currency change percentage to double
    double? currencyChange =
        double.parse(currency.change!.replaceAll(',', '.').replaceAll('%', ''));

    String? currencyName = currency.name?.replaceAll('-', ' ').toTitleCase();

    if (currencyName!.length < 4) {
      currencyName = currency.name?.replaceAll('-', ' ').toUpperCase();
    }

    return Padding(
      padding: EdgeInsets.symmetric(
        horizontal: 15.w,
        vertical: 5.w,
      ),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8),
          color: AppColors.white.withOpacity(0.9),
        ),
        child: Padding(
          padding: EdgeInsets.symmetric(
            horizontal: 10.w,
            vertical: 3.w,
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Expanded(
                  flex: 2,
                  child: IconButton(
                    onPressed: () {},
                    icon: Icon(
                      Icons.star_border,
                      color: AppColors.blackBackground,
                      size: 25.w,
                    ),
                  )),
              Expanded(
                  flex: 3,
                  child: Text(
                    currencyName ?? 'No Data',
                    maxLines: 2,
                    style: AppTextStyle.currencyTitle(),
                  )),
              Expanded(
                  flex: 3,
                  child: Text(
                    currency.buy.toString(),
                    textAlign: TextAlign.start,
                    style: AppTextStyle.currencyPrice(),
                  )),
              // Currency change container
              Expanded(
                flex: 4,
                child: _buildChangeContainer(currencyChange: currencyChange),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildChangeContainer({required double? currencyChange}) {
    currencyChange == null
        ? currencyChange = 0
        : currencyChange = currencyChange;
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8),
        color: currencyChange > 0 ? Colors.green : Colors.red,
      ),
      child: Padding(
        padding: EdgeInsets.symmetric(
          horizontal: 10.w,
          vertical: 5.w,
        ),
        child: Text(
          currency.change.toString(),
          textAlign: TextAlign.center,
          style: AppTextStyle.currencyChange(),
        ),
      ),
    );
  }
}

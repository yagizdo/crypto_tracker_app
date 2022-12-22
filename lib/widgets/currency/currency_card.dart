import 'package:crypto_tracker/bloc/favorites_bloc/favorites_bloc.dart';
import 'package:crypto_tracker/services/database/database_service.dart';
import 'package:crypto_tracker/services/locator.dart';
import 'package:crypto_tracker/utils/app_textstyles.dart';
import 'package:crypto_tracker/utils/extensions/string_extension.dart';
import 'package:crypto_tracker/widgets/main_widgets/tapWrapper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../models/currency.dart';
import '../../utils/app_colors.dart';

class CurrencyCard extends StatelessWidget {
  const CurrencyCard({Key? key, required this.currency, required this.isFavorite}) : super(key: key);
  final Currency currency;
  final bool isFavorite;
  @override
  Widget build(BuildContext context) {
    // String currency change percentage to double
    double? currencyChange =
        double.parse(currency.change!.replaceAll(',', '.').replaceAll('%', ''));

    String? currencyName = currency.name?.replaceAll('-', ' ').toTitleCase();

    if (currencyName!.length < 4) {
      currencyName = currency.name?.replaceAll('-', ' ').toUpperCase();
    }

    return TapWrapper(
      onTap: () {
       isFavorite ? BlocProvider.of<FavoritesBloc>(context,listen: false).add(DeleteFavoriteEvent(currency.name!)) : BlocProvider.of<FavoritesBloc>(context,listen: false).add(AddFavoriteEvent(currency.name!));
      },
      child: Padding(
        padding: EdgeInsets.symmetric(
          horizontal: 10.w,
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
                      icon: isFavorite ? Icon(
                        Icons.star,
                        color: Colors.yellow,
                        size: 25.w,
                      ) : Icon(
                        Icons.star_border,
                        color: AppColors.blackBackground,
                        size: 25.w,
                      ),
                    )),
                Expanded(
                    flex: 4,
                    child: Text(
                      currencyName ?? 'No Data',
                      maxLines: 2,
                      style: AppTextStyle.currencyTitle(),
                    )),
                Expanded(
                    flex: 4,
                    child: Text(
                      currency.buy.toString(),
                      textAlign: TextAlign.start,
                      style: AppTextStyle.currencyPrice(),
                    )),
                // Currency change container
                Expanded(
                  flex: 5,
                  child: _buildChangeContainer(currencyChange: currencyChange),
                ),
              ],
            ),
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

import 'package:crypto_tracker/models/crypto.dart';
import 'package:crypto_tracker/widgets/main_widgets/tapWrapper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../bloc/favorites_bloc/favorites_bloc.dart';
import '../../utils/app_colors.dart';
import '../../utils/app_textstyles.dart';

class CryptoCard extends StatelessWidget {
  const CryptoCard({Key? key, required this.crypto, required this.isFavorite})
      : super(key: key);
  final Crypto crypto;
  final bool isFavorite;
  @override
  Widget build(BuildContext context) {
    return TapWrapper(
      onTap: () {
        isFavorite
            ? BlocProvider.of<FavoritesBloc>(context, listen: false).add(
                DeleteFavoriteEvent(
                    '${crypto.market?.baseCurrencyCode} - ${crypto.market?.counterCurrencyCode}'))
            : BlocProvider.of<FavoritesBloc>(context, listen: false).add(
                AddFavoriteEvent(
                    '${crypto.market?.baseCurrencyCode} - ${crypto.market?.counterCurrencyCode}'));
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
                      icon: isFavorite
                          ? Icon(
                              Icons.star,
                              color: Colors.yellow,
                              size: 25.w,
                            )
                          : Icon(
                              Icons.star_border,
                              color: AppColors.blackBackground,
                              size: 25.w,
                            ),
                    )),
                Expanded(
                    flex: 4,
                    child: Text(
                      '${crypto.market?.baseCurrencyCode ?? ''} - ${crypto.market?.counterCurrencyCode ?? ''}',
                      maxLines: 2,
                      style: AppTextStyle.cryptoTitle(),
                    )),
                Expanded(
                    flex: 4,
                    child: Text(
                      double.parse(crypto.lastPrice!).toString(),
                      textAlign: TextAlign.start,
                      style: AppTextStyle.cryptoPrice(),
                    )),
                // Crypto change container
                Expanded(
                  flex: 5,
                  child: _buildChangeContainer(
                      cryptoChange: double.parse(crypto.change24h ?? '0')),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildChangeContainer({required double cryptoChange}) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8),
        color: cryptoChange > 0 ? Colors.green : Colors.red,
      ),
      child: Padding(
        padding: EdgeInsets.symmetric(
          horizontal: 10.w,
          vertical: 5.w,
        ),
        child: Text(
          crypto.change24h.toString(),
          textAlign: TextAlign.center,
          style: AppTextStyle.cryptoChange(),
        ),
      ),
    );
  }
}

import 'package:crypto_tracker/i18n/locale_keys.g.dart';
import 'package:crypto_tracker/models/currency.dart';
import 'package:crypto_tracker/utils/app_colors.dart';
import 'package:crypto_tracker/widgets/crypto/crypto_card.dart';
import 'package:crypto_tracker/widgets/currency/currency_card.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../bloc/favorites_bloc/favorites_bloc.dart';
import '../../models/crypto.dart';

class FavoritesList extends StatelessWidget {
  const FavoritesList({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<FavoritesBloc, FavoritesState>(
      builder: (context, state) {
        if (state is FavoritesLoadingState) {
          return Center(child: CircularProgressIndicator(color: AppColors.white,strokeWidth: 3.w,),);
        }
        if (state is FavoritesLoadedState) {
          return ListView.builder(
            itemCount: state.favorites.length,
            itemBuilder: (context,index) {
              var item = state.favorites[index];
              if(item is Currency) {
                return CurrencyCard(currency: item, isFavorite: true,);
              }

              if(item is Crypto) {
                return CryptoCard(crypto: item, isFavorite: true);
              }

              return const SizedBox();
            },
          );
        }
        return Center(child: Text(LocaleKeys.currency_no_item.tr()),);
        },
    );
  }
}

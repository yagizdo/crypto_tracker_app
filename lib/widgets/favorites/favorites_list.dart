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
  const FavoritesList({Key? key, required this.favorites}) : super(key: key);
  final List<dynamic> favorites;
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: favorites.length,
      itemBuilder: (context,index) {
        var item = favorites[index];
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
}

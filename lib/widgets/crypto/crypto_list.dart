import 'package:crypto_tracker/bloc/favorites_bloc/favorites_bloc.dart';
import 'package:crypto_tracker/services/alert_helper.dart';
import 'package:crypto_tracker/widgets/main_widgets/tapWrapper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../models/crypto.dart';
import 'crypto_card.dart';

class CryptoList extends StatelessWidget {
  const CryptoList({Key? key,required this.cryptos}) : super(key: key);
  final List<Crypto> cryptos;

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: cryptos.length,
      itemBuilder: (context, index) {
        return TapWrapper(
            onTap: () {
             AlertHelper.shared.addItemToCustomListDialog(context: context, itemName: '${cryptos[index].market?.baseCurrencyCode ?? ''} - ${cryptos[index].market?.counterCurrencyCode ?? ''}');
            },
            child: CryptoCard(crypto: cryptos[index], isFavorite: false,));
      },
    );
  }
}

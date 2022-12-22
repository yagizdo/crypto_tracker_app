import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../bloc/crypto_bloc/crypto_bloc.dart';
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
        return CryptoCard(crypto: cryptos[index], isFavorite: false,);
      },
    );
  }
}

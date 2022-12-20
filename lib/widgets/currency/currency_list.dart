import 'package:crypto_tracker/utils/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../bloc/currency_bloc/currency_bloc.dart';
import '../../models/currency.dart';
import 'currency_card.dart';

class CurrencyList extends StatelessWidget {
  const CurrencyList({Key? key, required this.currencies}) : super(key: key);
  final List<Currency> currencies;
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: currencies.length,
      itemBuilder: (context, index) {
        Currency currency = currencies[index];
        return CurrencyCard(
          currency: currency,
        );
      },
    );
  }
}

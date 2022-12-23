import 'package:crypto_tracker/services/alert_helper.dart';
import 'package:crypto_tracker/widgets/main_widgets/tapWrapper.dart';
import 'package:flutter/material.dart';
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
        return TapWrapper(
          onTap: () {
            AlertHelper.shared.addItemToCustomListDialog(context);
          },
          child: CurrencyCard(
            currency: currency,
            isFavorite: false,
          ),
        );
      },
    );
  }
}

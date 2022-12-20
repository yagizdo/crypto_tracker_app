import 'package:flutter/material.dart';

class CurrencyContent extends StatelessWidget {
  const CurrencyContent({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.center,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: const [
          Text('Currency Content'),
        ],
      ),
    );
  }
}

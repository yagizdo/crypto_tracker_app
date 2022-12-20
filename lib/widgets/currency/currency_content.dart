import 'package:crypto_tracker/widgets/currency/currency_list.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../bloc/currency_bloc/currency_bloc.dart';

class CurrencyContent extends StatelessWidget {
  const CurrencyContent({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.center,
      child: BlocBuilder<CurrencyBloc, CurrencyState>(
        builder: (context, state) {
          if (state is CurrencyLoading) {
            return const Center(
              child: CircularProgressIndicator(
                color: Colors.white,
              ),
            );
          }

          if (state is CurrencyLoaded) {
            return CurrencyList(
              currencies: state.currencies,
            );
          }
          return const Center(
            child: Text('No items'),
          );
        },
      ),
    );
  }
}

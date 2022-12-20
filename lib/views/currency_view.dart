import 'package:crypto_tracker/bloc/currency_bloc/currency_bloc.dart';
import 'package:crypto_tracker/widgets/currency/currency_content.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CurrencyView extends StatefulWidget {
  const CurrencyView({Key? key}) : super(key: key);

  @override
  State<CurrencyView> createState() => _CurrencyViewState();
}

class _CurrencyViewState extends State<CurrencyView> {

  @override
  void initState() {
    super.initState();
    BlocProvider.of<CurrencyBloc>(context).add(CurrencyEventFetch());
  }
  @override
  Widget build(BuildContext context) {
    return const CurrencyContent();
  }
}

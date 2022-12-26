import 'package:crypto_tracker/bloc/crypto_bloc/crypto_bloc.dart';
import 'package:crypto_tracker/widgets/crypto/crypto_content.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CryptoView extends StatefulWidget {
  const CryptoView({Key? key}) : super(key: key);

  @override
  State<CryptoView> createState() => _CryptoViewState();
}

class _CryptoViewState extends State<CryptoView> {
  @override
  void initState() {
    super.initState();
    BlocProvider.of<CryptoBloc>(context).add(GetCryptosEvent());
  }
  @override
  Widget build(BuildContext context) {
    return const CryptoContent();
  }
}

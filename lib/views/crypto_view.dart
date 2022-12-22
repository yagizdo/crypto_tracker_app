import 'package:crypto_tracker/widgets/crypto/crypto_content.dart';
import 'package:flutter/material.dart';

class CryptoView extends StatefulWidget {
  const CryptoView({Key? key}) : super(key: key);

  @override
  State<CryptoView> createState() => _CryptoViewState();
}

class _CryptoViewState extends State<CryptoView> {
  @override
  Widget build(BuildContext context) {
    return const CryptoContent();
  }
}

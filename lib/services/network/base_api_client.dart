import 'package:dio/dio.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

class BaseApiClient {

  // Dio instance
  final Dio dio = Dio();

  // Base URLS for API
  final String baseCryptoUrl = dotenv.get('CRYPTO_API');
  final String baseCurrencyUrl = dotenv.get('CURRENCY_API');
}
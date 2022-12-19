import 'package:dio/dio.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

class BaseApiClient {

  // Dio instance
  final Dio _dio = Dio();

  // Base URLS for API
  final String _baseCryptoUrl = dotenv.get('CRYPTO_API');
  final String _baseCurrencyUrl = dotenv.get('CURRENCY_API');
}
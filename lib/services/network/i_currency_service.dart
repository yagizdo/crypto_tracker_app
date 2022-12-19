import '../../models/currency.dart';

abstract class ICurrencyService {
  Future<List<Currency>> getCurrencies();
}
import 'package:crypto_tracker/services/network/base_api_client.dart';
import 'package:crypto_tracker/services/network/i_currency_service.dart';

import '../../models/currency.dart';

class CurrencyService extends BaseApiClient implements ICurrencyService {
  @override
  Future<List<Currency>> getCurrencies() async {
    // Get the response from the API with dio
    final response = await dio.get(baseCurrencyUrl);

    // Get the map of currencies and keys from the response
    final Map<String, dynamic> currenciesMap = response.data;

    final keys = currenciesMap.keys.toList();
    final values = currenciesMap.values.toList();

    // Create a list of currencies
    final List<Currency> currencies = [];

    // Loop through the keys and values and create a currency object
    for (var i = 1; i < keys.length; i++) {
      String updatedAt = values[0];
      Currency currency = Currency.fromJson(values[i]);
      currency.name = keys[i];
      currency.updatedAt = updatedAt;
      currencies.add(currency);
    }

    // Sort the currencies by name (alphabetically)
    var sortedCurrencies = currencies
        .where((element) => element.name != 'updated_at')
        .toList()
      ..sort((a, b) => a.name!.compareTo(b.name!));

    return currencies;
  }
}

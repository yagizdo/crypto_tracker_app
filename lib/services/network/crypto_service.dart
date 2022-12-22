import 'package:crypto_tracker/services/network/base_api_client.dart';
import 'package:dio/dio.dart';

import '../../models/crypto.dart';
import 'i_crypto_service.dart';

class CryptoService extends BaseApiClient implements ICryptoService {
  @override
  Future<List<Crypto>> getCryptos() async {
    final Response response = await dio.get(baseCryptoUrl);

    final Map cryptosMap = response.data['data']['ticker'];

    final keys = cryptosMap.keys.toList();
    final values = cryptosMap.values.toList();

    final List<Crypto> cryptos = [];

    for (var i=0; i<keys.length; i++) {
      Crypto crypto = Crypto.fromJson(values[i]);
      cryptos.add(crypto);
    }
    return cryptos;
  }
}
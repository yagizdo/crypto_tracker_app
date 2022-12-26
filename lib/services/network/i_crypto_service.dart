import '../../models/crypto.dart';

abstract class ICryptoService {
  Future<List<Crypto>> getCryptos();
}
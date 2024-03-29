import 'package:crypto_tracker/services/database/database_service.dart';
import 'package:crypto_tracker/services/network/crypto_service.dart';
import 'package:crypto_tracker/services/network/currency_service.dart';
import 'package:get_it/get_it.dart';

import 'auth/auth_service.dart';
import 'navigation_service.dart';

final GetIt getIt = GetIt.instance;

Future<void> setUpInjections() async {
  getIt.registerLazySingleton<AuthService>(() => AuthService());
  getIt.registerLazySingleton<NavigationService>(() => NavigationService());
  getIt.registerLazySingleton<DatabaseService>(() => DatabaseService());
  getIt.registerLazySingleton<CurrencyService>(() => CurrencyService());
  getIt.registerLazySingleton<CryptoService>(() => CryptoService());
}
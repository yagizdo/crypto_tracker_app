import 'package:get_it/get_it.dart';

import 'navigation_service.dart';

final GetIt getIt = GetIt.instance;

Future<void> setUpInjections() async {
  //getIt.registerLazySingleton<AuthService>(() => AuthService());
  getIt.registerLazySingleton<NavigationService>(() => NavigationService());
}
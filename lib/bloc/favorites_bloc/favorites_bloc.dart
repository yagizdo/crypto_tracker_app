import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:crypto_tracker/models/currency.dart';
import 'package:crypto_tracker/services/auth/auth_service.dart';
import 'package:crypto_tracker/services/database/database_service.dart';
import 'package:crypto_tracker/services/locator.dart';
import 'package:crypto_tracker/services/network/crypto_service.dart';
import 'package:crypto_tracker/services/network/currency_service.dart';
import 'package:meta/meta.dart';

import '../../models/crypto.dart';

part 'favorites_event.dart';
part 'favorites_state.dart';

class FavoritesBloc extends Bloc<FavoritesEvent, FavoritesState> {
  FavoritesBloc() : super(FavoritesInitial()) {
    DatabaseService databaseService = getIt<DatabaseService>();
    CryptoService cryptoService = getIt<CryptoService>();
    CurrencyService currencyService = getIt<CurrencyService>();
    AuthService authService = getIt<AuthService>();
    List favoritesNames = [];
    List favorites = [];
    List<Crypto> cryptoFavorites = [];
    List<Currency> currencyFavorites = [];
    on<FavoritesEvent>((event, emit) {});
    on<GetFavoritesEvent>((event, emit) async {
      favoritesNames = await databaseService.getFavorites(
          userUID: authService.currentUser.uid);
      List<Currency> currencies = await currencyService.getCurrencies();
      List<Crypto> cryptos = await cryptoService.getCryptos();

      // Get the favorites from the currencies and cryptos lists and add them to the favorites list
      // but don't add duplicates
      for (var i = 0; i < favoritesNames.length; i++) {
        for (var j = 0; j < currencies.length; j++) {
          if (favoritesNames[i] == currencies[j].name!.toUpperCase()) {
            if (!currencyFavorites.any((element) => element.name == currencies[j].name)) {
              currencyFavorites.add(currencies[j]);
            }
          }
        }
      }

      for (var i = 0; i < favoritesNames.length; i++) {
        for (var j = 0; j < cryptos.length; j++) {
          if (favoritesNames[i] == '${cryptos[j].market?.baseCurrencyCode} - ${cryptos[j].market?.counterCurrencyCode}') {
            if (!cryptoFavorites.any((crypto) => '${crypto.market?.baseCurrencyCode} - ${crypto.market?.counterCurrencyCode}' == '${cryptos[j].market?.baseCurrencyCode} - ${cryptos[j].market?.counterCurrencyCode}')) {
              cryptoFavorites.add(cryptos[j]);
            }
          }
        }
      }

      favorites = [...cryptoFavorites, ...currencyFavorites];
      emit(FavoritesLoadedState(favorites));
    });
    on<AddFavoriteEvent>((event, emit) async {
      if (!favoritesNames.contains(event.itemName)) {
        favoritesNames.add(event.itemName);
        await databaseService.saveFavorites(
            favorites: favoritesNames, userUID: authService.currentUser.uid);
      }

    });
    on<DeleteFavoriteEvent>((event, emit) async {
     if (favoritesNames.contains(event.itemName)) {
       favoritesNames.remove(event.itemName);
       await databaseService.saveFavorites(
           favorites: favoritesNames, userUID: authService.currentUser.uid);
     }
    });
  }
}

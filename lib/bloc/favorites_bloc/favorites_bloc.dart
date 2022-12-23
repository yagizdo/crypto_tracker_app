import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:crypto_tracker/models/currency.dart';
import 'package:crypto_tracker/services/auth/auth_service.dart';
import 'package:crypto_tracker/services/database/database_service.dart';
import 'package:crypto_tracker/services/locator.dart';
import 'package:crypto_tracker/services/navigation_service.dart';
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
    NavigationService navigationService = getIt<NavigationService>();
    // Fav Names
    List favoritesNames = [];

    // Favorites
    List favorites = [];

    // Crypto Favorites
    List<Crypto> cryptoFavorites = [];

    // Currencies Favorites
    List<Currency> currencyFavorites = [];

    on<FavoritesEvent>((event, emit) {});

    // Get Favorites
    Future<void> getFavorites() async {
      // Get Fav Names
      favoritesNames = await databaseService.getFavorites(
          userUID: authService.currentUser.uid);

      // Get Currencies
      List<Currency> currencies = await currencyService.getCurrencies();

      // Get Cryptos
      List<Crypto> cryptos = await cryptoService.getCryptos();

      // Get the favorites from the currencies and cryptos lists and add them to the favorites list
      // but don't add duplicates

      // Get Currencies Favorites
      for (var i = 0; i < favoritesNames.length; i++) {
        for (var j = 0; j < currencies.length; j++) {
          if (favoritesNames[i] == currencies[j].name!.toUpperCase()) {
            if (!currencyFavorites
                .any((element) => element.name == currencies[j].name)) {
              currencyFavorites.add(currencies[j]);
            }
          }
        }
      }

      // Get Cryptos Favorites
      for (var i = 0; i < favoritesNames.length; i++) {
        for (var j = 0; j < cryptos.length; j++) {
          if (favoritesNames[i] ==
              '${cryptos[j].market?.baseCurrencyCode} - ${cryptos[j].market?.counterCurrencyCode}') {
            if (!cryptoFavorites.any((crypto) =>
                '${crypto.market?.baseCurrencyCode} - ${crypto.market?.counterCurrencyCode}' ==
                '${cryptos[j].market?.baseCurrencyCode} - ${cryptos[j].market?.counterCurrencyCode}')) {
              cryptoFavorites.add(cryptos[j]);
            }
          }
        }
      }

      // Add Currencies Favorites and Cryptos Favorites to the favorites list
      favorites = [...cryptoFavorites, ...currencyFavorites];
    }

    // Get Custom Favorites List (Used for the search)
    Future<List> getCustomFavoritesList({required String listName}) async {
      // Get Custom List
      List customList = await databaseService.getCustomList(
          userUID: authService.currentUser.uid, customListName: listName);

      // Get Currencies
      List<Currency> currencies = await currencyService.getCurrencies();

      // Get Cryptos
      List<Crypto> cryptos = await cryptoService.getCryptos();

      // Get the favorites from the currencies and cryptos lists and add them to the favorites list
      // but don't add duplicates

      // Get Currencies Favorites
      for (var i = 0; i < customList.length; i++) {
        for (var j = 0; j < currencies.length; j++) {
          if (customList[i] == currencies[j].name!.toUpperCase()) {
            if (!currencyFavorites
                .any((element) => element.name == currencies[j].name)) {
              currencyFavorites.add(currencies[j]);
            }
          }
        }
      }

      // Get Cryptos Favorites
      for (var i = 0; i < customList.length; i++) {
        for (var j = 0; j < cryptos.length; j++) {
          if (customList[i] ==
              '${cryptos[j].market?.baseCurrencyCode} - ${cryptos[j].market?.counterCurrencyCode}') {
            if (!cryptoFavorites.any((crypto) =>
                '${crypto.market?.baseCurrencyCode} - ${crypto.market?.counterCurrencyCode}' ==
                '${cryptos[j].market?.baseCurrencyCode} - ${cryptos[j].market?.counterCurrencyCode}')) {
              cryptoFavorites.add(cryptos[j]);
            }
          }
        }
      }

      // Add Currencies Favorites and Cryptos Favorites to the favorites list
      favorites = [...cryptoFavorites, ...currencyFavorites];

      return favorites;
    }

    // Get All Custom Lists
    Future<List<String>> getAllCustomLists() async {
      return await databaseService.getAllCustomLists(
          userUID: authService.currentUser.uid);
    }

    on<GetCustomListNamesEvent>((event, emit) async {
      emit(CustomListNamesLoadingState());
      try {
        List<String> customLists = await getAllCustomLists();
        if (customLists.isEmpty) {
          emit(CustomListEmptyState());
        } else {
          emit(CustomListNamesLoadedState(customLists));
        }
      } catch (e) {
        emit(CustomListNamesErrorState(e.toString()));
      }
    });

    on<AddCustomListEvent>((event, emit) async {
      emit(CustomListNamesLoadingState());
      try {
        // Check if the list name already exists
        List<String> customLists = await getAllCustomLists();
        if (customLists.contains(event.listName)) {
          navigationService.showErrorSnackbar(
              errorMessage: 'List name already exists');
          emit(CustomListNamesLoadedState(customLists));
        } else {
          // Add the list name to the database
          await databaseService.saveCustomLists(
              userUID: authService.currentUser.uid,
              listItems: [],
              customListName: event.listName);

          // Get the custom list
          List<String> customList = await getAllCustomLists();

          // Emit the custom list state
          emit(CustomListNamesLoadedState(customList));
        }
      } catch (e) {
        emit(CustomListNamesErrorState(e.toString()));
      }
    });

    on<AddItemToCustomListEvent>((event, emit) async {
      emit(CustomListNamesLoadingState());
      try {
        // Get the custom list
        List customListItems = await databaseService.getCustomList(
            userUID: authService.currentUser.uid,
            customListName: event.listName);

        List<String> customListNames = await getAllCustomLists();

        // Check if the item already exists in the list
        if (customListItems.contains(event.itemName)) {
          navigationService.showErrorSnackbar(
              errorMessage: 'Item already exists in the list');
          emit(CustomListNamesLoadedState(customListNames));
        } else {
          // Add the item to the list
          customListItems.add(event.itemName);

          // Save the list to the database
          await databaseService.saveCustomLists(
              userUID: authService.currentUser.uid,
              listItems: customListItems,
              customListName: event.listName);

          // Get the custom list
          List<String> updatedCustomListNames = await getAllCustomLists();

          // Emit the custom list state
          emit(CustomListNamesLoadedState(updatedCustomListNames));
        }
      } catch (e) {
        emit(CustomListNamesErrorState(e.toString()));
      }
    });

    on<DeleteItemFromCustomListEvent>((event, emit) async {
      emit(CustomListNamesLoadingState());
      try {
        // Get the custom list
        List customListItems = await databaseService.getCustomList(
            userUID: authService.currentUser.uid,
            customListName: event.listName);

        List<String> customListNames = await getAllCustomLists();

        // Check if the item exists in the list
        if (!customListItems.contains(event.itemName)) {
          navigationService.showErrorSnackbar(
              errorMessage: 'Item does not exist in the list');
          emit(CustomListNamesLoadedState(customListNames));
        } else {
          // Remove the item from the list
          customListItems.remove(event.itemName);

          // Save the list to the database
          await databaseService.saveCustomLists(
              userUID: authService.currentUser.uid,
              listItems: customListItems,
              customListName: event.listName);

          // Get the custom list
          List<String> updatedCustomListNames = await getAllCustomLists();

          // Emit the custom list state
          emit(CustomListNamesLoadedState(updatedCustomListNames));
        }
      } catch (e) {
        emit(CustomListNamesErrorState(e.toString()));
      }
    });
  }
}

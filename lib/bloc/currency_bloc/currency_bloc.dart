import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:crypto_tracker/services/network/currency_service.dart';
import 'package:meta/meta.dart';

import '../../models/currency.dart';
import '../../services/locator.dart';

part 'currency_event.dart';
part 'currency_state.dart';

class CurrencyBloc extends Bloc<CurrencyEvent, CurrencyState> {

  CurrencyBloc() : super(CurrencyInitial()) {
    List<Currency> currencies = [];
    final CurrencyService currencyService = getIt<CurrencyService>();
    on<CurrencyEvent>((event, emit) {});

    on<CurrencyEventFetch>((event, emit) async {
      emit(CurrencyLoading());
      try {
        currencies = await currencyService.getCurrencies();
        emit(CurrencyLoaded(currencies));
      } catch (e) {
        print('Error: $e');
        emit(CurrencyError());
      }
    });
  }
}

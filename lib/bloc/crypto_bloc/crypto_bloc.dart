import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:crypto_tracker/i18n/locale_keys.g.dart';
import 'package:crypto_tracker/services/network/crypto_service.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:meta/meta.dart';

import '../../models/crypto.dart';
import '../../services/locator.dart';

part 'crypto_event.dart';
part 'crypto_state.dart';

class CryptoBloc extends Bloc<CryptoEvent, CryptoState> {
  CryptoBloc() : super(CryptoInitial()) {
    List<Crypto> cryptos = [];
    final CryptoService cryptoService = getIt<CryptoService>();

    on<CryptoEvent>((event, emit) {});
    on<GetCryptosEvent>((event, emit) async {
      emit(CryptoLoading());
      try {
        cryptos = await cryptoService.getCryptos();
        emit(CryptoLoaded(cryptos));
      } catch (e) {
        emit(CryptoError(LocaleKeys.errors_undefinied.tr()));
      }
    });
  }
}

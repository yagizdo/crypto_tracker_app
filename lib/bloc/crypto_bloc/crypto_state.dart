part of 'crypto_bloc.dart';

@immutable
abstract class CryptoState {}

class CryptoInitial extends CryptoState {}

class CryptoLoading extends CryptoState {}

class CryptoLoaded extends CryptoState {
  final List<Crypto> cryptos;

  CryptoLoaded(this.cryptos);
}

class CryptoError extends CryptoState {
  final String errorMessage;

  CryptoError(this.errorMessage);
}

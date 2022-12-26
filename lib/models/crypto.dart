class Crypto {
  Market? market;
  String? bid;
  String? ask;
  String? lastPrice;
  String? lastSize;
  String? volume24h;
  String? change24h;
  String? low24h;
  String? high24h;
  String? avg24h;
  String? timestamp;

  Crypto(
      {this.market,
        this.bid,
        this.ask,
        this.lastPrice,
        this.lastSize,
        this.volume24h,
        this.change24h,
        this.low24h,
        this.high24h,
        this.avg24h,
        this.timestamp});

  Crypto.fromJson(Map<String, dynamic> json) {
    market =
    json['market'] != null ? Market.fromJson(json['market']) : null;
    bid = json['bid'];
    ask = json['ask'];
    lastPrice = json['last_price'];
    lastSize = json['last_size'];
    volume24h = json['volume_24h'];
    change24h = json['change_24h'];
    low24h = json['low_24h'];
    high24h = json['high_24h'];
    avg24h = json['avg_24h'];
    timestamp = json['timestamp'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (market != null) {
      data['market'] = market!.toJson();
    }
    data['bid'] = bid;
    data['ask'] = ask;
    data['last_price'] = lastPrice;
    data['last_size'] = lastSize;
    data['volume_24h'] = volume24h;
    data['change_24h'] = change24h;
    data['low_24h'] = low24h;
    data['high_24h'] = high24h;
    data['avg_24h'] = avg24h;
    data['timestamp'] = timestamp;
    return data;
  }
}

class Market {
  String? marketCode;
  String? baseCurrencyCode;
  String? counterCurrencyCode;

  Market({this.marketCode, this.baseCurrencyCode, this.counterCurrencyCode});

  Market.fromJson(Map<String, dynamic> json) {
    marketCode = json['market_code'];
    baseCurrencyCode = json['base_currency_code'];
    counterCurrencyCode = json['counter_currency_code'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['market_code'] = marketCode;
    data['base_currency_code'] = baseCurrencyCode;
    data['counter_currency_code'] = counterCurrencyCode;
    return data;
  }
}

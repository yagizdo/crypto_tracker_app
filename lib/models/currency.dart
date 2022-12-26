class Currency {
  String? name;
  String? updatedAt;
  String? buy;
  String? type;
  String? sell;
  String? change;

  Currency(this.name,this.updatedAt,{this.buy, this.type, this.sell, this.change});

  Currency.fromJson(Map<String, dynamic> json) {
    buy = json['Alış'];
    type = json['Tür'];
    sell = json['Satış'];
    change = json['Değişim'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['Alış'] = buy;
    data['Tür'] = type;
    data['Satış'] = sell;
    data['Değişim'] = change;
    return data;
  }
}
class Currency {
  String? name;
  String? alis;
  String? tur;
  String? satis;
  String? degisim;

  Currency(this.name,{this.alis, this.tur, this.satis, this.degisim});

  Currency.fromJson(Map<String, dynamic> json) {
    alis = json['Alış'];
    tur = json['Tür'];
    satis = json['Satış'];
    degisim = json['Değişim'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['Alış'] = alis;
    data['Tür'] = tur;
    data['Satış'] = satis;
    data['Değişim'] = degisim;
    return data;
  }
}
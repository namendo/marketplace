class TopCategorie {
  String? beneficiarycategorycode;
  String? value;
  bool? istop;

  TopCategorie({this.beneficiarycategorycode, this.value, this.istop});

  TopCategorie.fromJson(Map<String, dynamic> json) {
    beneficiarycategorycode = json['beneficiarycategorycode'];
    value = json['value'];
    istop = json['istop'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['beneficiarycategorycode'] = this.beneficiarycategorycode;
    data['value'] = this.value;
    data['istop'] = this.istop;
    return data;
  }
}

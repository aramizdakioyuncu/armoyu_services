class APIPlayerXp {
  int oyuncuID;
  String oyuncuAdSoyad;
  String oyuncuKullaniciAdi;
  String oyuncuAvatar;
  int oyuncuSeviye;
  String oyuncuSeviyeXP;
  String oyuncuSeviyeSezonlukXP;
  int oyuncuPop;

  APIPlayerXp({
    required this.oyuncuID,
    required this.oyuncuAdSoyad,
    required this.oyuncuKullaniciAdi,
    required this.oyuncuAvatar,
    required this.oyuncuSeviye,
    required this.oyuncuSeviyeXP,
    required this.oyuncuSeviyeSezonlukXP,
    required this.oyuncuPop,
  });

  factory APIPlayerXp.fromJson(Map<String, dynamic> json) {
    return APIPlayerXp(
      oyuncuID: json['oyuncuID'],
      oyuncuAdSoyad: json['oyuncuadsoyad'],
      oyuncuKullaniciAdi: json['oyuncukullaniciadi'],
      oyuncuAvatar: json['oyuncuavatar'],
      oyuncuSeviye: json['oyuncuseviye'],
      oyuncuSeviyeXP: json['oyuncuseviyexp'],
      oyuncuSeviyeSezonlukXP: json['oyuncuseviyesezonlukxp'],
      oyuncuPop: json['oyuncupop'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'oyuncuID': oyuncuID,
      'oyuncuadsoyad': oyuncuAdSoyad,
      'oyuncukullaniciadi': oyuncuKullaniciAdi,
      'oyuncuavatar': oyuncuAvatar,
      'oyuncuseviye': oyuncuSeviye,
      'oyuncuseviyexp': oyuncuSeviyeXP,
      'oyuncuseviyesezonlukxp': oyuncuSeviyeSezonlukXP,
      'oyuncupop': oyuncuPop,
    };
  }
}

import 'package:armoyu_services/core/models/ARMOYU/media.dart';

class APIChatList {
  int kullID;
  String adSoyad;
  String? kullAdi;
  int bildirim;
  String sonGiris;
  String sonMesaj;
  String sohbetTuru;
  Media chatImage;
  String foto;

  APIChatList({
    required this.kullID,
    required this.adSoyad,
    this.kullAdi,
    required this.bildirim,
    required this.sonGiris,
    required this.sonMesaj,
    required this.sohbetTuru,
    required this.chatImage,
    required this.foto,
  });

  factory APIChatList.fromJson(Map<String, dynamic> json) {
    return APIChatList(
      kullID: json['kullid'],
      adSoyad: json['adisoyadi'],
      kullAdi: json['kulladi'],
      bildirim: json['bildirim'],
      sonGiris: json['songiris'],
      sonMesaj: json['sonmesaj'],
      sohbetTuru: json['sohbetturu'],
      chatImage: Media.fromJson(json['chatImage']),
      foto: json['foto'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'kullid': kullID,
      'adisoyadi': adSoyad,
      'kulladi': kullAdi,
      'bildirim': bildirim,
      'songiris': sonGiris,
      'sonmesaj': sonMesaj,
      'sohbetturu': sohbetTuru,
      'chatImage': chatImage.toJson(),
      'foto': foto,
    };
  }
}

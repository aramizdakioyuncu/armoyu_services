class APIEventDetail {
  String eventName;
  String eventDate;
  List<dynamic> dlc; // DLC listesi, içeriğine göre tipi değişebilir
  List<dynamic> files; // Dosya listesi, içeriğine göre tipi değişebilir
  List<dynamic> detail; // Detay listesi, içeriğine göre tipi değişebilir

  APIEventDetail({
    required this.eventName,
    required this.eventDate,
    required this.dlc,
    required this.files,
    required this.detail,
  });

  // JSON'dan APIEventDetail nesnesi oluşturma
  factory APIEventDetail.fromJson(Map<String, dynamic> json) {
    return APIEventDetail(
      eventName: json['event_name'],
      eventDate: json['event_date'],
      dlc: json['dlc'] ?? [],
      files: json['files'] ?? [],
      detail: json['detail'] ?? [],
    );
  }

  // APIEventDetail nesnesini JSON'a dönüştürme
  Map<String, dynamic> toJson() {
    return {
      'event_name': eventName,
      'event_date': eventDate,
      'dlc': dlc,
      'files': files,
      'detail': detail,
    };
  }
}

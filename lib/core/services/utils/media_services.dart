part of 'package:armoyu_services/armoyu_services.dart';

class MediaServices {
  final String? Function() getToken;
  final void Function(String? token) setToken;

  final String apiKey;
  final bool usePreviousAPI;

  late final ApiHelpers _apiHelpers;

  MediaServices({
    required this.getToken,
    required this.setToken,
    required this.apiKey,
    required this.usePreviousAPI,
  }) {
    _apiHelpers = ApiHelpers(apiKey: apiKey, usePreviousAPI: usePreviousAPI);
  }

  Future<ServiceResult> fetch({
    required int uyeID,
    required String category,
    required int page,
  }) async {
    Map<String, dynamic> response = await _apiHelpers.post(
      body: {
        "oyuncubakid": "$uyeID",
        "kategori": category,
        "limit": "30",
        "sayfa": page,
      },
      endpoint: "0/0/${_EndpointConstants.media}/0/0/",
      headers: _apiHelpers.getRequestHeader(token: getToken()),
    );

    ServiceResult result = ServiceResult(
      status: response['durum'] == 1 ? true : false,
      description: response['aciklama'],
      descriptiondetail: response['aciklamadetay'],
    );

    if (response['durum'] == 0) {
      return result;
    }

    return result;
  }

  Future<ServiceResult> rotation({
    required int mediaID,
    required double rotate,
  }) async {
    Map<String, dynamic> response = await _apiHelpers.post(
      body: {
        "fotografID": "$mediaID",
        "derece": "$rotate",
      },
      endpoint: "0/0/${_EndpointConstants.mediaturn}/0/",
      headers: _apiHelpers.getRequestHeader(token: getToken()),
    );

    ServiceResult result = ServiceResult(
      status: response['durum'] == 1 ? true : false,
      description: response['aciklama'],
      descriptiondetail: response['aciklamadetay'],
    );

    if (response['durum'] == 0) {
      return result;
    }

    return result;
  }

  Future<ServiceResult> delete({required int mediaID}) async {
    Map<String, dynamic> response = await _apiHelpers.post(
      body: {
        "medyaID": "$mediaID",
      },
      endpoint: "0/0/${_EndpointConstants.mediaturn}/0/",
      headers: _apiHelpers.getRequestHeader(token: getToken()),
    );

    ServiceResult result = ServiceResult(
      status: response['durum'] == 1 ? true : false,
      description: response['aciklama'],
      descriptiondetail: response['aciklamadetay'],
    );

    if (response['durum'] == 0) {
      return result;
    }

    return result;
  }

  Future<ServiceResult> upload({
    required List<XFile> files,
    required String category,
  }) async {
    List<http.MultipartFile> photosCollection = [];
    for (XFile element in files) {
      photosCollection.add(
        await _apiHelpers.generateImageFile(
          "media[]",
          element,
        ),
      );
    }

    Map<String, dynamic> response = await _apiHelpers.post(
      body: {"category": category},
      files: photosCollection,
      endpoint: "0/0/${_EndpointConstants.mediaupload}/0/",
      headers: _apiHelpers.getRequestHeader(token: getToken()),
    );

    ServiceResult result = ServiceResult(
      status: response['durum'] == 1 ? true : false,
      description: response['aciklama'],
      descriptiondetail: response['aciklamadetay'],
    );

    if (response['durum'] == 0) {
      return result;
    }

    return result;
  }
}

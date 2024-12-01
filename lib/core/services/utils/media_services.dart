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
    required String username,
    required String password,
    required int uyeID,
    required String category,
    required int page,
  }) async {
    password = _apiHelpers.generateMd5(password);

    Map<String, dynamic> response = await _apiHelpers.post(
      body: {
        "oyuncubakid": "$uyeID",
        "kategori": category,
        "limit": "30",
        "sayfa": page,
      },
      endpoint: "$username/$password/${_EndpointConstants.media}/0/0/",
      headers: _apiHelpers.getRequestHeader(
        token: getToken(),
      ),
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
    required String username,
    required String password,
    required int mediaID,
    required double rotate,
  }) async {
    password = _apiHelpers.generateMd5(password);

    Map<String, dynamic> response = await _apiHelpers.post(
      body: {
        "fotografID": "$mediaID",
        "derece": "$rotate",
      },
      endpoint: "$username/$password/${_EndpointConstants.mediaturn}/0/",
      headers: _apiHelpers.getRequestHeader(
        token: getToken(),
      ),
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

  Future<ServiceResult> delete({
    required String username,
    required String password,
    required int mediaID,
  }) async {
    password = _apiHelpers.generateMd5(password);

    Map<String, dynamic> response = await _apiHelpers.post(
      body: {
        "medyaID": "$mediaID",
      },
      endpoint: "$username/$password/${_EndpointConstants.mediaturn}/0/",
      headers: _apiHelpers.getRequestHeader(
        token: getToken(),
      ),
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
    required String username,
    required String password,
    required List<XFile> files,
    required String category,
  }) async {
    password = _apiHelpers.generateMd5(password);

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
      body: {
        "category": category,
      },
      files: photosCollection,
      endpoint: "$username/$password/${_EndpointConstants.mediaupload}/0/",
      headers: _apiHelpers.getRequestHeader(
        token: getToken(),
      ),
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

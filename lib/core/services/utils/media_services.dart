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

  Future<Map<String, dynamic>> fetch({
    required String username,
    required String password,
    required int uyeID,
    required String category,
    required int page,
  }) async {
    return await _apiHelpers.post(
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
  }

  Future<Map<String, dynamic>> rotation({
    required String username,
    required String password,
    required int mediaID,
    required double rotate,
  }) async {
    return await _apiHelpers.post(
      body: {
        "fotografID": "$mediaID",
        "derece": "$rotate",
      },
      endpoint: "$username/$password/${_EndpointConstants.mediaturn}/0/",
      headers: _apiHelpers.getRequestHeader(
        token: getToken(),
      ),
    );
  }

  Future<Map<String, dynamic>> delete({
    required String username,
    required String password,
    required int mediaID,
  }) async {
    return await _apiHelpers.post(
      body: {
        "medyaID": "$mediaID",
      },
      endpoint: "$username/$password/${_EndpointConstants.mediaturn}/0/",
      headers: _apiHelpers.getRequestHeader(
        token: getToken(),
      ),
    );
  }

  Future<Map<String, dynamic>> upload({
    required String username,
    required String password,
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

    return await _apiHelpers.post(
      body: {
        "category": category,
      },
      files: photosCollection,
      endpoint: "$username/$password/${_EndpointConstants.mediaupload}/0/",
      headers: _apiHelpers.getRequestHeader(
        token: getToken(),
      ),
    );
  }
}

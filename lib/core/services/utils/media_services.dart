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

  Future<MediaFetchResponse> fetch({
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

    MediaFetchResponse armoyuresponse = MediaFetchResponse(result: result);

    if (response['durum'] == 0) {
      return armoyuresponse;
    }

    armoyuresponse.response = APIMediaFetch(
      mediaOwner: MediaOwner(
        userID: response['icerik']['media_ownerID'],
        displayname: response['icerik']['media_ownerusername'],
        avatar: MediaURL(
          bigURL: response['icerik']['media_owneravatar'],
          normalURL: response['icerik']['media_owneravatar'],
          minURL: response['icerik']['media_owneravatar'],
        ),
      ),
      mediaDate: response['icerik']['media_time'],
      mediaSize: response['icerik']['media_size'],
      category: response['icerik']['fotokategori'],
      fotoPaylas: response['icerik']['fotopaylas'],
      mediatype: response['icerik']['fotodosyatipi'],
      media: Media(
        mediaID: response['icerik']['media_ID'],
        mediaURL: MediaURL(
          bigURL: response['icerik']['fotoorijinalurl'],
          normalURL: response['icerik']['fotoufaklikurl'],
          minURL: response['icerik']['fotominnakurl'],
        ),
      ),
    );

    return armoyuresponse;
  }

  Future<MediaRotationResponse> rotation({
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

    MediaRotationResponse armoyuresponse =
        MediaRotationResponse(result: result);

    if (response['durum'] == 0) {
      return armoyuresponse;
    }

    return armoyuresponse;
  }

  Future<MediaDeleteResponse> delete({required int mediaID}) async {
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
    MediaDeleteResponse armoyuresponse = MediaDeleteResponse(result: result);

    if (response['durum'] == 0) {
      return armoyuresponse;
    }

    return armoyuresponse;
  }

  Future<MediaUploadResponse> upload({
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
    MediaUploadResponse armoyuresponse = MediaUploadResponse(result: result);

    if (response['durum'] == 0) {
      return armoyuresponse;
    }

    List<APIMediaUpload> medialist = [];
    for (var element in response['durum']['icerik']) {
      medialist.add(
        APIMediaUpload(
          status: element['durum'],
          mediaID: element['media_ID'],
          description: element['aciklama'],
          filetype: element['dosyatipi'],
          filecategory: element['fotokategori'],
          mediaURL: MediaURL(
            bigURL: element['orijinallink'],
            normalURL: element['ufakliklink'],
            minURL: element['minnaklink'],
          ),
        ),
      );
    }
    armoyuresponse.response = medialist;

    return armoyuresponse;
  }
}

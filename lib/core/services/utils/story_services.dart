part of 'package:armoyu_services/armoyu_services.dart';

class StoryServices {
  final String? Function() getToken;
  final void Function(String? token) setToken;

  final String apiKey;
  final bool usePreviousAPI;

  late final ApiHelpers _apiHelpers;

  StoryServices({
    required this.getToken,
    required this.setToken,
    required this.apiKey,
    required this.usePreviousAPI,
  }) {
    _apiHelpers = ApiHelpers(apiKey: apiKey, usePreviousAPI: usePreviousAPI);
  }

  Future<ServiceResult> stories({required int page}) async {
    Map<String, dynamic> response = await _apiHelpers.post(
      body: {
        "sayfa": page,
        "limit": "20",
      },
      endpoint: "0/0/${_EndpointConstants.story}/0/0/",
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

  Future<ServiceResult> addstory({
    required String imageURL,
    required bool isEveryonePublish,
  }) async {
    Map<String, dynamic> response = await _apiHelpers.post(
      body: {
        "hikayemedya": imageURL,
        "hikayepaylasimkategori": isEveryonePublish
      },
      endpoint: "0/0/${_EndpointConstants.addstory}/0/",
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

  Future<ServiceResult> removestory({required int storyID}) async {
    Map<String, dynamic> response = await _apiHelpers.post(
      body: {"hikayeID": "$storyID"},
      endpoint: "0/0/${_EndpointConstants.removestory}/0/",
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

  Future<ServiceResult> hidestory({required int storyID}) async {
    Map<String, dynamic> response = await _apiHelpers.post(
      body: {"hikayeID": "$storyID"},
      endpoint: "0/0/${_EndpointConstants.hidestory}/0/",
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

  Future<ServiceResult> view({required int storyID}) async {
    Map<String, dynamic> response = await _apiHelpers.post(
      body: {"hikayeID": "$storyID"},
      endpoint: "0/0/${_EndpointConstants.viewstory}/0/",
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

  Future<ServiceResult> fetchviewlist({required int storyID}) async {
    Map<String, dynamic> response = await _apiHelpers.post(
      body: {"hikayeID": "$storyID"},
      endpoint: "0/0/${_EndpointConstants.viewliststory}/0/",
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

  Future<ServiceResult> like({required int storyID}) async {
    Map<String, dynamic> response = await _apiHelpers.post(
      body: {"hikayeID": "$storyID"},
      endpoint: "0/0/${_EndpointConstants.likestory}/0/",
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

  Future<ServiceResult> likeremove({required int storyID}) async {
    Map<String, dynamic> response = await _apiHelpers.post(
      body: {"hikayeID": "$storyID"},
      endpoint: "0/0/${_EndpointConstants.likeremovestory}/0/",
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

  Future<ServiceResult> likerslist({required int storyID}) async {
    Map<String, dynamic> response = await _apiHelpers.post(
      body: {"hikayeID": "$storyID"},
      endpoint: "0/0/${_EndpointConstants.likestory}/0/",
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

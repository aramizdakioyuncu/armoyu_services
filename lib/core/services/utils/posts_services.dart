part of 'package:armoyu_services/armoyu_services.dart';

class PostsServices {
  final String? Function() getToken;
  final void Function(String? token) setToken;

  final String apiKey;
  final bool usePreviousAPI;

  late final ApiHelpers _apiHelpers;

  PostsServices({
    required this.getToken,
    required this.setToken,
    required this.apiKey,
    required this.usePreviousAPI,
  }) {
    _apiHelpers = ApiHelpers(apiKey: apiKey, usePreviousAPI: usePreviousAPI);
  }

  Future<ServiceResult> like({required int postID}) async {
    Map<String, dynamic> response = await _apiHelpers.post(
      body: {
        "postID": "$postID",
        "kategori": "post",
      },
      endpoint: "0/0/${_EndpointConstants.postaddlike}/",
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

  Future<ServiceResult> unlike({required int postID}) async {
    Map<String, dynamic> response = await _apiHelpers.post(
      body: {
        "postID": "$postID",
        "kategori": "post",
      },
      endpoint: "0/0/${_EndpointConstants.postremovelike}/",
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

  Future<ServiceResult> commentlike({required int commentID}) async {
    Map<String, dynamic> response = await _apiHelpers.post(
      body: {
        "postID": "$commentID",
        "kategori": "postyorum",
      },
      endpoint: "0/0/${_EndpointConstants.commentaddlike}/",
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

  Future<ServiceResult> commentunlike({required int commentID}) async {
    Map<String, dynamic> response = await _apiHelpers.post(
      body: {
        "postID": "$commentID",
        "kategori": "postyorum",
      },
      endpoint: "0/0/${_EndpointConstants.commentunlike}/",
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

  Future<ServiceResult> share({
    required String text,
    required List<XFile> files,
    required String? location,
  }) async {
    List<http.MultipartFile> photosCollection = [];

    for (XFile element in files) {
      photosCollection.add(
        await _apiHelpers.generateImageFile(
          "paylasimfoto[]",
          element,
        ),
      );
    }

    Map<String, String> formData;

    if (location != null) {
      formData = {
        "sosyalicerik": text,
        "konum": location,
      };
    } else {
      formData = {
        "sosyalicerik": text,
      };
    }
    Map<String, dynamic> response = await _apiHelpers.post(
      body: formData,
      files: photosCollection,
      endpoint: "0/0/${_EndpointConstants.postshare}/",
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

  Future<ServiceResult> remove({required int postID}) async {
    Map<String, dynamic> response = await _apiHelpers.post(
      body: {"postID": "$postID"},
      endpoint: "0/0/${_EndpointConstants.postremove}/",
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

  Future<ServiceResult> removecomment({required int commentID}) async {
    Map<String, dynamic> response = await _apiHelpers.post(
      body: {
        "yorumID": "$commentID",
      },
      endpoint: "0/0/${_EndpointConstants.postremovecomment}/",
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

  Future<ServiceResult> getPosts({required int page}) async {
    Map<String, dynamic> response = await _apiHelpers.post(
      body: {"limit": "20"},
      endpoint: "0/0/${_EndpointConstants.getposts}/$page/",
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

  Future<ServiceResult> detailfetch({
    int? postID,
    String? category,
    int? categoryDetail,
  }) async {
    Map<String, dynamic> response = await _apiHelpers.post(
      body: {
        "postID": "$postID",
        "category": "$category",
        "categorydetail": "$categoryDetail",
      },
      endpoint: "0/0/${_EndpointConstants.getposts}/",
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

  Future<ServiceResult> commentsfetch({required int postID}) async {
    Map<String, dynamic> response = await _apiHelpers.post(
      body: {"postID": "$postID"},
      endpoint: "0/0/${_EndpointConstants.getcomments}/",
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

  Future<ServiceResult> createcomment({
    required int postID,
    required String text,
  }) async {
    Map<String, dynamic> response = await _apiHelpers.post(
      body: {
        "postID": "$postID",
        "yorumicerik": text,
        "kategori": "sosyal",
      },
      endpoint: "0/0/${_EndpointConstants.createcomments}/",
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

  Future<ServiceResult> postlikeslist({required int postID}) async {
    Map<String, dynamic> response = await _apiHelpers.post(
      body: {"postID": "$postID"},
      endpoint: "0/0/${_EndpointConstants.postlikers}/",
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

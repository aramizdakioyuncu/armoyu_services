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

  Future<Map<String, dynamic>> like({
    required String username,
    required String password,
    required int postID,
  }) async {
    return await _apiHelpers.post(
      body: {
        "postID": "$postID",
        "kategori": "post",
      },
      endpoint: "$username/$password/${_EndpointConstants.postaddlike}/",
      headers: _apiHelpers.getRequestHeader(
        token: getToken(),
      ),
    );
  }

  Future<Map<String, dynamic>> unlike({
    required String username,
    required String password,
    required int postID,
  }) async {
    return await _apiHelpers.post(
      body: {
        "postID": "$postID",
        "kategori": "post",
      },
      endpoint: "$username/$password/${_EndpointConstants.postremovelike}/",
      headers: _apiHelpers.getRequestHeader(
        token: getToken(),
      ),
    );
  }

  Future<Map<String, dynamic>> commentlike({
    required String username,
    required String password,
    required int commentID,
  }) async {
    return await _apiHelpers.post(
      body: {
        "postID": "$commentID",
        "kategori": "postyorum",
      },
      endpoint: "$username/$password/${_EndpointConstants.commentaddlike}/",
      headers: _apiHelpers.getRequestHeader(
        token: getToken(),
      ),
    );
  }

  Future<Map<String, dynamic>> commentunlike({
    required String username,
    required String password,
    required int commentID,
  }) async {
    return await _apiHelpers.post(
      body: {
        "postID": "$commentID",
        "kategori": "postyorum",
      },
      endpoint: "$username/$password/${_EndpointConstants.commentunlike}/",
      headers: _apiHelpers.getRequestHeader(
        token: getToken(),
      ),
    );
  }

  Future<Map<String, dynamic>> share({
    required String username,
    required String password,
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
    return await _apiHelpers.post(
      body: formData,
      files: photosCollection,
      endpoint: "$username/$password/${_EndpointConstants.postshare}/",
      headers: _apiHelpers.getRequestHeader(
        token: getToken(),
      ),
    );
  }

  Future<Map<String, dynamic>> remove({
    required String username,
    required String password,
    required int postID,
  }) async {
    return await _apiHelpers.post(
      body: {
        "postID": "$postID",
      },
      endpoint: "$username/$password/${_EndpointConstants.postremove}/",
      headers: _apiHelpers.getRequestHeader(
        token: getToken(),
      ),
    );
  }

  Future<Map<String, dynamic>> removecomment({
    required String username,
    required String password,
    required int commentID,
  }) async {
    return await _apiHelpers.post(
      body: {
        "yorumID": "$commentID",
      },
      endpoint: "$username/$password/${_EndpointConstants.postremovecomment}/",
      headers: _apiHelpers.getRequestHeader(
        token: getToken(),
      ),
    );
  }

  Future<Map<String, dynamic>> getPosts({
    required String username,
    required String password,
    required int page,
  }) async {
    return await _apiHelpers.post(
      body: {"limit": "20"},
      endpoint: "$username/$password/${_EndpointConstants.getposts}/$page/",
      headers: _apiHelpers.getRequestHeader(
        token: getToken(),
      ),
    );
  }

  Future<Map<String, dynamic>> detailfetch({
    required String username,
    required String password,
    int? postID,
    String? category,
    int? categoryDetail,
  }) async {
    return await _apiHelpers.post(
      body: {
        "postID": "$postID",
        "category": "$category",
        "categorydetail": "$categoryDetail",
      },
      endpoint: "$username/$password/${_EndpointConstants.getposts}/",
      headers: _apiHelpers.getRequestHeader(
        token: getToken(),
      ),
    );
  }

  Future<Map<String, dynamic>> commentsfetch({
    required String username,
    required String password,
    required int postID,
  }) async {
    return await _apiHelpers.post(
      body: {"postID": "$postID"},
      endpoint: "$username/$password/${_EndpointConstants.getcomments}/",
      headers: _apiHelpers.getRequestHeader(
        token: getToken(),
      ),
    );
  }

  Future<Map<String, dynamic>> createcomment({
    required String username,
    required String password,
    required int postID,
    required String text,
  }) async {
    return await _apiHelpers.post(
      body: {
        "postID": "$postID",
        "yorumicerik": text,
        "kategori": "sosyal",
      },
      endpoint: "$username/$password/${_EndpointConstants.createcomments}/",
      headers: _apiHelpers.getRequestHeader(
        token: getToken(),
      ),
    );
  }

  Future<Map<String, dynamic>> postlikeslist({
    required String username,
    required String password,
    required int postID,
  }) async {
    return await _apiHelpers.post(
      body: {
        "postID": "$postID",
      },
      endpoint: "$username/$password/${_EndpointConstants.postlikers}/",
      headers: _apiHelpers.getRequestHeader(
        token: getToken(),
      ),
    );
  }
}

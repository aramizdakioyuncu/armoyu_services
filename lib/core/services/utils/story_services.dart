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

  Future<Map<String, dynamic>> stories({
    required String username,
    required String password,
    required int page,
  }) async {
    return await _apiHelpers.post(
      body: {
        "sayfa": page,
        "limit": "20",
      },
      endpoint: "$username/$password/${_EndpointConstants.story}/0/0/",
      headers: _apiHelpers.getRequestHeader(
        token: getToken(),
      ),
    );
  }

  Future<Map<String, dynamic>> addstory({
    required String username,
    required String password,
    required String imageURL,
    required bool isEveryonePublish,
  }) async {
    return await _apiHelpers.post(
      body: {
        "hikayemedya": imageURL,
        "hikayepaylasimkategori": isEveryonePublish
      },
      endpoint: "$username/$password/${_EndpointConstants.addstory}/0/",
      headers: _apiHelpers.getRequestHeader(
        token: getToken(),
      ),
    );
  }

  Future<Map<String, dynamic>> removestory({
    required String username,
    required String password,
    required int storyID,
  }) async {
    return await _apiHelpers.post(
      body: {"hikayeID": "$storyID"},
      endpoint: "$username/$password/${_EndpointConstants.removestory}/0/",
      headers: _apiHelpers.getRequestHeader(
        token: getToken(),
      ),
    );
  }

  Future<Map<String, dynamic>> hidestory({
    required String username,
    required String password,
    required int storyID,
  }) async {
    return await _apiHelpers.post(
      body: {"hikayeID": "$storyID"},
      endpoint: "$username/$password/${_EndpointConstants.hidestory}/0/",
      headers: _apiHelpers.getRequestHeader(
        token: getToken(),
      ),
    );
  }

  Future<Map<String, dynamic>> view({
    required String username,
    required String password,
    required int storyID,
  }) async {
    return await _apiHelpers.post(
      body: {"hikayeID": "$storyID"},
      endpoint: "$username/$password/${_EndpointConstants.viewstory}/0/",
      headers: _apiHelpers.getRequestHeader(
        token: getToken(),
      ),
    );
  }

  Future<Map<String, dynamic>> fetchviewlist({
    required String username,
    required String password,
    required int storyID,
  }) async {
    return await _apiHelpers.post(
      body: {"hikayeID": "$storyID"},
      endpoint: "$username/$password/${_EndpointConstants.viewliststory}/0/",
      headers: _apiHelpers.getRequestHeader(
        token: getToken(),
      ),
    );
  }

  Future<Map<String, dynamic>> like({
    required String username,
    required String password,
    required int storyID,
  }) async {
    return await _apiHelpers.post(
      body: {"hikayeID": "$storyID"},
      endpoint: "$username/$password/${_EndpointConstants.likestory}/0/",
      headers: _apiHelpers.getRequestHeader(
        token: getToken(),
      ),
    );
  }

  Future<Map<String, dynamic>> likeremove({
    required String username,
    required String password,
    required int storyID,
  }) async {
    return await _apiHelpers.post(
      body: {"hikayeID": "$storyID"},
      endpoint: "$username/$password/${_EndpointConstants.likeremovestory}/0/",
      headers: _apiHelpers.getRequestHeader(
        token: getToken(),
      ),
    );
  }

  Future<Map<String, dynamic>> likerslist({
    required String username,
    required String password,
    required int storyID,
  }) async {
    return await _apiHelpers.post(
      body: {"hikayeID": "$storyID"},
      endpoint: "$username/$password/${_EndpointConstants.likestory}/0/",
      headers: _apiHelpers.getRequestHeader(
        token: getToken(),
      ),
    );
  }
}

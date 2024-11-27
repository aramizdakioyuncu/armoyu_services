part of 'package:armoyu_services/armoyu_services.dart';

class NewsServices {
  final String? Function() getToken;
  final void Function(String? token) setToken;

  final String apiKey;
  final bool usePreviousAPI;

  late final ApiHelpers _apiHelpers;

  NewsServices({
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
    required int page,
  }) async {
    password = _apiHelpers.generateMd5(password);

    return await _apiHelpers.post(
      body: {
        "sayfa": page,
        "limit": "10",
      },
      endpoint: "$username/$password/${_EndpointConstants.newsList}/0/",
      headers: _apiHelpers.getRequestHeader(
        token: getToken(),
      ),
    );
  }

  Future<Map<String, dynamic>> fetchnews({
    required String username,
    required String password,
    required int newsID,
  }) async {
    password = _apiHelpers.generateMd5(password);

    return await _apiHelpers.post(
      body: {
        "haberID": "$newsID",
      },
      endpoint: "$username/$password/${_EndpointConstants.newsDetail}/0/",
      headers: _apiHelpers.getRequestHeader(
        token: getToken(),
      ),
    );
  }
}

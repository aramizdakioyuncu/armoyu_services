part of 'package:armoyu_services/armoyu_services.dart';

class SearchServices {
  final String? Function() getToken;
  final void Function(String? token) setToken;

  final String apiKey;
  final bool usePreviousAPI;

  late final ApiHelpers _apiHelpers;

  SearchServices({
    required this.getToken,
    required this.setToken,
    required this.apiKey,
    required this.usePreviousAPI,
  }) {
    _apiHelpers = ApiHelpers(apiKey: apiKey, usePreviousAPI: usePreviousAPI);
  }

  Future<Map<String, dynamic>> hashtag({
    required String username,
    required String password,
    required String hashtag,
    required int page,
  }) async {
    return await _apiHelpers.post(
      body: {
        "etiket": hashtag,
        "sayfa": page,
      },
      endpoint: "$username/$password/${_EndpointConstants.hashtag}/0/0/",
      headers: _apiHelpers.getRequestHeader(
        token: getToken(),
      ),
    );
  }

  Future<Map<String, dynamic>> searchengine({
    required String username,
    required String password,
    required String searchword,
    required int page,
  }) async {
    return await _apiHelpers.post(
      body: {
        "sayfa": "$page",
        "oyuncuadi": searchword,
      },
      endpoint: "$username/$password/${_EndpointConstants.searchengine}/0/0/",
      headers: _apiHelpers.getRequestHeader(
        token: getToken(),
      ),
    );
  }

  Future<Map<String, dynamic>> onlyusers({
    required String username,
    required String password,
    required String searchword,
    required int page,
  }) async {
    return await _apiHelpers.post(
      body: {
        "sayfa": "$page",
        "oyuncuadi": searchword,
        "kategori": "oyuncular",
      },
      endpoint: "$username/$password/${_EndpointConstants.searchengine}/0/0/",
      headers: _apiHelpers.getRequestHeader(
        token: getToken(),
      ),
    );
  }

  Future<Map<String, dynamic>> onlyschools({
    required String username,
    required String password,
    required String searchword,
    required int page,
  }) async {
    return await _apiHelpers.post(
      body: {
        "sayfa": "$page",
        "oyuncuadi": searchword,
      },
      endpoint: "$username/$password/${_EndpointConstants.searchengine}/0/0/",
      headers: _apiHelpers.getRequestHeader(
        token: getToken(),
      ),
    );
  }

  Future<Map<String, dynamic>> onlyworks({
    required String username,
    required String password,
    required String searchword,
    required int page,
  }) async {
    return await _apiHelpers.post(
      body: {
        "sayfa": "$page",
        "oyuncuadi": searchword,
      },
      endpoint: "$username/$password/${_EndpointConstants.searchengine}/0/0/",
      headers: _apiHelpers.getRequestHeader(
        token: getToken(),
      ),
    );
  }
}

part of 'package:armoyu_services/armoyu_services.dart';

class BlockingServices {
  final String? Function() getToken;
  final void Function(String? token) setToken;

  final String apiKey;
  final bool usePreviousAPI;

  late final ApiHelpers _apiHelpers;

  BlockingServices({
    required this.getToken,
    required this.setToken,
    required this.apiKey,
    required this.usePreviousAPI,
  }) {
    _apiHelpers = ApiHelpers(apiKey: apiKey, usePreviousAPI: usePreviousAPI);
  }

//Blocking
  Future<Map<String, dynamic>> list({
    required String username,
    required String password,
  }) async {
    return await _apiHelpers.post(
      endpoint: "$username/$password/${_EndpointConstants.blockinglist}/0/0",
      headers: _apiHelpers.getRequestHeader(
        token: getToken(),
      ),
    );
  }

  Future<Map<String, dynamic>> add({
    required String username,
    required String password,
    required int userID,
  }) async {
    return await _apiHelpers.post(
        endpoint: "$username/$password/${_EndpointConstants.bloclistadd}/0",
        headers: _apiHelpers.getRequestHeader(
          token: getToken(),
        ),
        body: {"userID": userID});
  }

  Future<Map<String, dynamic>> remove({
    required String username,
    required String password,
    required int userID,
  }) async {
    return await _apiHelpers.post(
        endpoint: "$username/$password/${_EndpointConstants.bloclistremove}/0",
        headers: _apiHelpers.getRequestHeader(
          token: getToken(),
        ),
        body: {"userID": userID});
  }

//Blocking
}

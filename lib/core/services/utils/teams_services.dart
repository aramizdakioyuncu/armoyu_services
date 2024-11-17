part of 'package:armoyu_services/armoyu_services.dart';

class TeamsServices {
  final String? Function() getToken;
  final void Function(String? token) setToken;

  final String apiKey;
  final bool usePreviousAPI;

  late final ApiHelpers _apiHelpers;

  TeamsServices({
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
  }) async {
    return await _apiHelpers.post(
      body: {},
      endpoint: "$username/$password/${_EndpointConstants.teamslist}/0/",
      headers: _apiHelpers.getRequestHeader(
        token: getToken(),
      ),
    );
  }
}

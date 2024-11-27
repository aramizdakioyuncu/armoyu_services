part of 'package:armoyu_services/armoyu_services.dart';

class AppServices {
  final String? Function() getToken;
  final void Function(String? token) setToken;

  final String apiKey;
  final bool usePreviousAPI;

  late final ApiHelpers _apiHelpers;

  AppServices({
    required this.getToken,
    required this.setToken,
    required this.apiKey,
    required this.usePreviousAPI,
  }) {
    _apiHelpers = ApiHelpers(apiKey: apiKey, usePreviousAPI: usePreviousAPI);
  }

  Future<Map<String, dynamic>> sitemesaji({
    required String username,
    required String password,
  }) async {
    password = _apiHelpers.generateMd5(password);

    return await _apiHelpers.post(
      endpoint: "$username/$password/${_EndpointConstants.sitemessages}/0/0",
      headers: _apiHelpers.getRequestHeader(
        token: getToken(),
      ),
    );
  }
}
